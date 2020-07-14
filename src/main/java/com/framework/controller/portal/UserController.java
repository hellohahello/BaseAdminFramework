package com.framework.controller.portal;

import com.framework.entity.Comment;
import com.framework.entity.ResCategory;
import com.framework.entity.Resource;
import com.framework.entity.User;
import com.framework.service.*;
import com.framework.utils.*;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/16 22:06
 * @desc: //用户登录后的各个选项页
 */
@Controller
@RequestMapping("portal/user")
public class UserController {
    private static final String SUPER_ADMIN_EMAIL="1291482971@qq.com";
    @Autowired
    private CommentService commentService;
    @Autowired
    private DownloadService downloadService;
    @Autowired
    protected ResourceService resourceService;
    @Autowired
    private ResCategoryService categoryService;
    @Autowired
    private UserService userService;

    /**
     * 帖子管理页
     * 直接显示list
     * <p>
     * 注：只显示当前登录用户的帖子
     *
     * @param model
     * @return
     */
    @RequestMapping("resource_manger.action")
    public String manger(Model model,
                         @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                         @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                         @RequestParam(value = "keyword",required = false) String keyword,
                         HttpServletRequest request) {

        PageHelper.startPage(pageNum, pageSize);
        Map<String, Object> params = new HashMap<String, Object>();
//       帖子管理页  只能查询当前登录用户自己的帖子
        User user = (User) request.getSession().getAttribute("user");
//        把userID传过去，添加一个根据userID查询的条件
        if (user != null) {
            params.put("userId", user.getUserId());
        } else {
            return "admin/login";
        }
//        是否是搜索操作
        if (!StringUtils.isEmpty(keyword)){
            params.put("keyWord","%"+keyword.trim()+"%");
        }
        List<Resource> list = resourceService.list(params);
        PageInfo<Resource> pageInfo = new PageInfo<Resource>(list);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("keyword", keyword);
        return "portal/user/resource_manger";
    }

    /**
     * 进入发布帖子页面
     * 只有已登录的用户才能进入发布
     *
     * @param model
     * @param resourceId
     * @return
     */
    @RequestMapping("edit_resource.action")
    public String edit(HttpServletRequest request,
                       Model model,
                       @RequestParam(value = "resourceId", required = false) String resourceId) {
        User user = (User) request.getSession().getAttribute("user");
        //如果未登录，访问时返回到登录页
        if (user == null) {
            return "admin/login";
        }
        Map<String, Object> param = new HashMap<String, Object>();
//        id不为空，则是编辑操作
        if (!StringUtils.isEmpty(resourceId)) {
            Resource resource = resourceService.findById(resourceId);
            model.addAttribute("resource", resource);
        }

        List<ResCategory> categoryList = categoryService.list();
        model.addAttribute("resCategoryList", categoryList);
//        编辑时
//        model.addAttribute("resourceId",resourceId);
        return "portal/user/edit_resource";
    }

    /**
     * 帖子保存
     *
     * @param resource
     * @return
     */
    @RequestMapping("save.json")
    @ResponseBody
    public Result save(Resource resource, HttpServletRequest request) throws MessagingException {
        //以下是新添加操作
        //积分是否在正常区间
        if (resource.getPoints() < 0 || resource.getPoints() > 3) {
            return Result.error("积分帖，积分值只能设置在1-3之间");
        }
        //检查百度云连接是否有效
        boolean active = BaiDuYun.isActive(resource.getDownload());
        if (!active) {
            return Result.error("该网页链接已失效或网址格式错误，请纠正后重试");
        }

        // 编辑
        if (!StringUtils.isEmpty(resource.getResourceId())) {
            if (resource.getPoints() == 0) {
                resource.setItsFree(true);

            }
            //若是审核驳回，修改后设置状态为“待审核”
            if (resource.getState() == 3) {
                resource.setState(0);
            }

            //新帖子是否热门
            resourceService.save(resource);
            return Result.success();
        }
//        获取userid，以便得知是谁发布的
        User user = (User) request.getSession().getAttribute("user");
        resource.setCreateTime(new Date());
        resource.setUserId(user.getUserId());
        resource.setClick(StringUtil.getTenToFiftyNumber());//随机得到点击量
        resource.setItsHot(false);
        if (resource.getClick() > 30) {
            resource.setItsHot(true);
        }

        if (resource.getPoints() == 0) {
            resource.setItsFree(true);
        } else {
            resource.setItsFree(false);
        }
        if (active) {
            resource.setItsUseful(true);
        }
        resource.setState(0);
        //管理员免审核
        User currentUser= (User) request.getSession().getAttribute("user");
        if (currentUser!=null&&currentUser.getRoleName().equals("管理员")){
            resource.setState(1);
        }
        //发布一次5积分
        resourceService.save(resource);
        user.setPoints(user.getPoints()+5);
        userService.save(user);
        //邮件告知管理员审核帖子
        if (resource.getState()==0){
                List<User> userList = userService.list();
                for (User isAdmin : userList) {
                    //好几个管理员，由于发邮件需要消费不短的时间。
                    //为了体验感，这里只选择一个人发算了
                    if (isAdmin.getRoleName().equals("管理员")&&(isAdmin.getUserName().equals("赵雅芝"))){
                        SendMail.sendEmail("【有新主题待审】","本站会员【"+currentUser.getUserName()+"】刚刚发布了新帖：【"+resource.getResourceName()+"】,等待你的审批~",isAdmin.getEmail());
                    }
                }
        }
        return Result.success();
    }

    @RequestMapping("delete.json")
    @ResponseBody
    public Result delete(@RequestParam("idArray") String[] idArray,
                                 HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");
        if (user==null){
            return Result.error("登录后再试");
        }
//        只能删除自己的帖子
        for (String s : idArray) {
            if (resourceService.findById(s).getUserId()!=user.getUserId()){
                return Result.error("仅能对您自己发布的帖子进行删除操作");
            }
        }
        // 需要先删除该帖子对应的评论
        commentService.deleteByForeignKey(idArray);

//       也需要先该删除对应的下载记录
        downloadService.deleteByForeignKey(idArray);
        resourceService.delete(idArray);
        return Result.success();
    }

    /**
     * 用户主页
     * @return
     */
    @RequestMapping("home.action")
    public String home(HttpSession session,Model model){
      User currentUser= (User) session.getAttribute("user");
      if (currentUser==null){
          return "admin/login";
      }
        User user = userService.findById(currentUser.getUserId());
      user.setRegisterTimeStr(DateUtil.date2String(user.getRegisterTime()));
        model.addAttribute("user",user);
        return "portal/user/home";
    }

    /**
     * 个人中心===更新头像页
     * @param session
     * @param model
     * @return
     */
    @RequestMapping("avatar.action")
    public String avatar(HttpSession session,Model model){
        User currentUser= (User) session.getAttribute("user");
        if (currentUser==null){
            return "admin/login";
        }
        User user = userService.findById(currentUser.getUserId());
        model.addAttribute("user",user);
        return "portal/user/avatar";
    }

    /**
     * 更新头像
     * @param base64Image
     * @param session
     * @return
     * @throws IOException
     */
    @RequestMapping("avatar/update.json")
    @ResponseBody
    public Result updateAvatar(@RequestParam("base64Image")String base64Image,HttpSession session)throws IOException {
//        imgURL默认只是图片名  如abc.jpg,所以加上存储空间的地址
        User user=new User();
        user.setAvatar(base64Image);
        User currentUser = (User) session.getAttribute("user");
//        更新头像
        userService.updateAvatar(base64Image,String.valueOf(currentUser.getUserId()));
        //同时更新该用户评论表的头像地址

        //根据userId获取某用户的所有评论
        List<Comment> commentList=commentService.findByUserId(currentUser.getUserId());
       //然后更新每条评论的头像地址
        for (Comment comment : commentList) {
            commentService.update(comment.getCommentId(),user.getAvatar());
        }

        return Result.success().add("base64Image",base64Image);
    }

    /**
     * 在个人主页修改密码===页面
     * @return
     */
    @RequestMapping("update_password.action")
    public String pass(){
        return "portal/user/update_password";
    }

    /**
     * 更新密码
     * @param oldPassword
     * @param newPassword
     * @param session
     * @return
     */
    @RequestMapping("update_password.json")
    @ResponseBody
    public Result updateP(@RequestParam("oldPassword")String oldPassword,
                          @RequestParam("newPassword")String newPassword,
                          HttpSession session){

        if (session.getAttribute("user")==null){
            return Result.error("登录已失效，请重新登录");
        }
        if (StringUtils.isEmpty(newPassword)||StringUtils.isEmpty(oldPassword)){
            return Result.error("必填项不能为空！");
        }
        if (newPassword.length()<5){
            return Result.error("密码长度不能小于5位");
        }
        User currentUser = (User) session.getAttribute("user");
        User user = userService.findById(Integer.valueOf(currentUser.getUserId()));
        if (user==null){
            return Result.error("该用户不存在");
        }
        //判断输入的旧密码是否正确
        if (!MD5Util.md5(oldPassword).equals(user.getPassWord())){
            return Result.error("旧密码有误，请重新输入");
        }
        userService.updatePassword(MD5Util.md5(newPassword),user.getEmail());
        return Result.success();
    }
}
