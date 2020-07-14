package com.framework.controller.admin;

import com.framework.entity.Message;
import com.framework.entity.ResCategory;
import com.framework.entity.Resource;
import com.framework.entity.User;
import com.framework.service.*;
import com.framework.utils.IPAddress;
import com.framework.utils.MD5Util;
import com.framework.utils.Result;
import com.framework.utils.UserOnline;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.resources.Messages;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/21 14:31
 * @desc: //管理员的各种操作
 */

//@Controller
    @Component
@RequestMapping("administrator")
public class AdminIndexController {
    @Autowired
    private MessageService messageService;
    @Autowired
    private CollectionService collectionService;
    @Autowired
    protected ResCategoryService categoryService;
    @Autowired
    ResourceService resourceService;
    @Autowired
    private UserService userService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private DownloadService downloadService;

    /**
     * 跳转到管理员登录页
     */
    @RequestMapping("login.action")
    public String index() {
        return "admin/admin_login";
    }

    /**
     * 管理员登录验证
     *
     * @param userName
     * @param passWord
     * @param request
     * @return
     */
    @RequestMapping("login.json")
    @ResponseBody
    public Result login(@RequestParam("userName") String userName,
                        @RequestParam("passWord") String passWord,
                        HttpServletRequest request) {
        if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(passWord)) {
            return Result.error("必填项不能为空");
        }
        User user = userService.findByUserNameAndPassword(userName, MD5Util.md5(passWord));
        if (user == null || !user.getRoleName().
                equals("管理员")) {
            return Result.error("该管理员不存在，请检查输入是否有误");
        }
        request.getSession().setAttribute("administrator", user);
        userService.updateLoginTime(new Date(), String.valueOf(user.getUserId()));
        return Result.success("验证通过√");
    }

    /**
     * 跳转到后台首页
     */
    @RequestMapping("index.action")
    public String toIndex(HttpServletRequest request, Model model) {
        User administrator = (User) request.getSession().getAttribute("administrator");
        if (StringUtils.isEmpty(administrator)) {
            return "admin/admin_login";
        }
        //传递今日新增用户数
        int todayNewAddUserCount = userService.todayNewAddUserCount();
        model.addAttribute("todayNewAddUserCount", todayNewAddUserCount);
        //传递今日新增话题数
        int todayNewAddResourceCount = resourceService.todayNewAddResourceCount();
        model.addAttribute("todayNewAddResourceCount", todayNewAddResourceCount);
        //传递今日新增评论数
        int todayNewAddCommentCount = commentService.todayNewAddCommentCount();
        model.addAttribute("todayNewAddCommentCount", todayNewAddCommentCount);
//    传递待审核帖子数
        int notJudgeResourceCount = resourceService.notJudgeResourceCount();
        model.addAttribute("notJudgeResourceCount", notJudgeResourceCount);
//    传递IP地址
        String ipAddress = IPAddress.getIpAddress(request);
        model.addAttribute("ipAddress", ipAddress);
        model.addAttribute("administrator", administrator);

        return "admin/admin_index";
    }

    /**
     * 跳转到帖子管理
     */
    @RequestMapping("resource.action")
    public String list(Model model,
                       @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                       @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                       @RequestParam(value = "keyword", required = false) String keyword,
                       @RequestParam(value = "state", required = false) String state) {
        Map<String, Object> param = new HashMap<String, Object>();
        PageHelper.startPage(pageNum, pageSize);
        if (!StringUtils.isEmpty(keyword)) {
            param.put("keyWord", "%" + keyword.trim() + "%");
        }
        param.put("state", state);
        List<Resource> resourceList = resourceService.list(param);
        for (Resource resource : resourceList) {
            if (resource.getClick() > 200) {
                resource.setItsHot(true);
            }
            if (resource.isItsFree() == true) {
                resource.setItsFree(true);
            }
            resourceService.save(resource);
        }
        PageInfo<Resource> pageInfo = new PageInfo<Resource>(resourceList);
        model.addAttribute("resourceList", resourceList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("pageSize", pageSize);
        return "admin/admin_resource_list";
    }

    /**
     * 跳转到帖子审核页面
     * 实际就是更改状态
     *
     * @param model
     * @return
     */
    @RequestMapping("resource_verify.action")
    public String verify(Model model,
                         @RequestParam("resourceId") String resourceId) {
        Resource resource = resourceService.findById(resourceId);
        List<ResCategory> resCategoryList = categoryService.list();
        model.addAttribute("resource", resource);
        model.addAttribute("resCategoryList", resCategoryList);
        return "admin/admin_resource_verify";
    }

    /**
     * 审核成功
     *
     * @param resource
     * @return
     */
    @RequestMapping("verify_success.json")
    @ResponseBody
    public Result success(Resource resource) {

        Resource getResource = resourceService.findById(String.valueOf(resource.getResourceId()));
//        更改状态
        getResource.setState(1);
        resourceService.save(getResource);
        //todo 审核后发消息给用户
        //发送消息
        Message message=new Message();
        //创建时间
        message.setCreateTime(new Date());
        //属于谁的消息
        message.setUserId(getResource.getUserId());
        message.setItsAlready(false);
        message.setMessageTitle("审核通过通知");
        message.setMessageContent("您的帖子：【"+resourceService.findById(String.valueOf(resource.getResourceId())).getResourceName()+"】；审核已通过");
        messageService.save(message);
        return Result.success();
    }

    /**
     * 审核未成功
     *
     * @param resource
     * @return
     */
    @RequestMapping("verify_defeat.json")
    @ResponseBody
    public Result defeat(Resource resource) {

        Resource getResource = resourceService.findById(String.valueOf(resource.getResourceId()));
//        更改状态
        getResource.setState(2);
        getResource.setReason(resource.getReason());
        resourceService.save(getResource);
        //todo 审核后发消息给用户
        //发送消息
        Message message=new Message();
        //创建时间
        message.setCreateTime(new Date());
        //属于谁的消息
        message.setUserId(getResource.getUserId());
        message.setItsAlready(false);
        message.setMessageTitle("审核失败通知");
        message.setMessageContent("您的帖子："+resourceService.findById(String.valueOf(getResource.getResourceId())).getResourceName()+"；审核不通过，原因是："+resource.getReason());
        messageService.save(message);
        return Result.success();
    }

    @RequestMapping("loginout.json")
    @ResponseBody
    public Result logout(HttpSession session) {
//        销毁session
        session.invalidate();
        return Result.success();
    }

    //删除选中的帖子
    @RequestMapping("resource/delete.json")
    @ResponseBody
    public Result delete(@RequestParam("idArr") String[] idArr,
                         HttpSession session) {
        //只有在线用户才能操作
        if (!UserOnline.userIsOnline(session)) {
            return Result.error("请登录后再进行操作");
        }
        //删除评论
        commentService.deleteByForeignKey(idArr);
        //删除对应的下载记录
        downloadService.deleteByForeignKey(idArr);
        resourceService.delete(idArr);
        return Result.success();

    }

    /**
     *
     * @param setHot 用来区分是热门还是非热门，1为true，热门  0为false，非热门
     * @param resourceId
     * @return
     */
    @RequestMapping("resource/setHot.json")
    @ResponseBody
    public Result setHot(@RequestParam("setHot")String setHot,
                         @RequestParam("resourceId")String resourceId){
        resourceService.upSetOrNotHot(resourceId,setHot);
        return Result.success();
    }

    /**
     * 设置是否免费帖子
     * @param setFree    用来区分是免费还是收费，1为true，免费  0为false，收费
     * @param resourceId
     * @return
     */
    @RequestMapping("resource/setFree.json")
    @ResponseBody
    public Result setFree(@RequestParam("setFree")String setFree,
                         @RequestParam("resourceId")String resourceId){
        resourceService.setFreeOrNotFree(resourceId,setFree);
        return Result.success();
    }



}
