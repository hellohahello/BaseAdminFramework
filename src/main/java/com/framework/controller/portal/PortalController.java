package com.framework.controller.portal;

import com.framework.entity.*;
import com.framework.service.*;
import com.framework.utils.DateUtil;
import com.framework.utils.Result;
import com.framework.utils.StringUtil;
import com.framework.utils.UserOnline;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.xml.internal.serializer.utils.Messages;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/14 22:31
 * @desc: //前台首页
 */
@Controller
@RequestMapping("portal")

public class PortalController {
    @Autowired
    private CollectionService collectionService;
    @Autowired
    protected ResCategoryService categoryService;
    @Autowired
    protected ResourceService resourceService;
    @Autowired
    private UserService userService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private DownloadService downloadService;
    @Autowired
    private NoticeService noticeService;

    /**
     * 前台首页
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("index.action")
    public String index(HttpServletRequest request,
                        Model model,
                        @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                        @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }
        PageHelper.startPage(pageNum, pageSize);
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("state", 1);
        List<Resource> resourceList = resourceService.list(param);
        PageInfo<Resource> pageInfo = new PageInfo<Resource>(resourceList);
        model.addAttribute("pageInfo", pageInfo);
//        最新主题list
        List<Resource> lastList = resourceService.lastList(param);
        for (Resource resource : lastList) {
            resource.setCreateTimeStr(DateUtil.onlyDate(resource.getCreateTime()));
        }
        //根据阅读量排序
        List<Resource> listByClick = resourceService.listByClick();
        model.addAttribute("listByClick", listByClick);
//        最新发表的
        model.addAttribute("lastList", lastList);
//        评论时间排序--倒序
        List<Resource> listByCommentTimeDesc = resourceService.listByCommentTimeDesc();
        for (Resource resource : listByCommentTimeDesc) {
            resource.setCommentTimeStr(DateUtil.onlyDate(resource.getCommentTime()));
        }

        model.addAttribute("listByCommentTimeDesc", listByCommentTimeDesc);
//公告
        model.addAttribute("notice", noticeService.findLastNotice());

        return "portal/index";
    }

    /**
     * 页面一加载，就向后台请求分类category的数据
     *
     * @return
     */
    @Autowired
    private MessageService messageService;

    @RequestMapping("category_list.json")
    @ResponseBody
    public Result list(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            int count = messageService.getCountByUserId(user.getUserId());
            session.setAttribute("messageCount", count);
        }

        List<ResCategory> categoryList = categoryService.list();
        return Result.success().add("categoryList", categoryList);
    }

    /**
     * 根据分类id查询对应的所有帖子
     *
     * @return
     */
    @RequestMapping("type.action")
    public String pageByTypeId(@RequestParam("resCategoryId") String resCategoryId,
                               @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                               @RequestParam(value = "pageSize", defaultValue = "8") int pageSize,
                               Model model) {

        Map<String, Object> param = new HashMap<String, Object>();
        param.put("categoryId", resCategoryId);
//        分页只需要在查询前调用
        PageHelper.startPage(pageNum, pageSize);
        List<Resource> resourceList = resourceService.list(param);
//        todo 404
        PageInfo<Resource> pageInfo = new PageInfo<Resource>(resourceList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("pageSize", pageSize);
//        当在type页点击typeName时
        model.addAttribute("resCategoryId", resCategoryId);
        return "portal/type";
    }

    /**
     * 搜索帖子
     *
     * @param keyWord
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping("search.action")
    public String search(@RequestParam(value = "keyWord", required = true) String keyWord,
                         @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                         @RequestParam(value = "pageSize", defaultValue = "8") int pageSize,
                         Model model) {
        Map<String, Object> param = new HashMap<String, Object>();
        if (!StringUtils.isEmpty(keyWord)) {
            param.put("keyWord", "%" + keyWord.trim() + "%");
        }
//        只需要在分页前调用
        PageHelper.startPage(pageNum, pageSize);
        List<Resource> resourceList = resourceService.list(param);
//        分页
        PageInfo<Resource> pageInfo = new PageInfo<Resource>(resourceList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("keyWord", keyWord);
        model.addAttribute("pageNum", pageNum);
        return "portal/search";
    }

    /**
     * 根据主键到详情页
     *
     * @param resourceId
     * @param model
     * @return
     */
    @RequestMapping("detail.action")
    public String detail(@RequestParam("resourceId") String resourceId,
                         Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        //每次打开时都会更新浏览量
        Resource resource = resourceService.findById(resourceId);
        //30分钟刷新才能刷新一次浏览量
        if (session.getAttribute("timeTool") == null) {
            session.setAttribute("timeTool", "time");
            session.setMaxInactiveInterval(60 * 30);

        } else {
            resource.setClick(resource.getClick() - 1);
            resourceService.save(resource);
        }
        //时间以字符串显示在页面
        resource.setCreateTimeStr(DateUtil.onlyDate(resource.getCreateTime()));
//        TODO 如果没找到，就去404
        model.addAttribute("resource", resource);
        request.setAttribute("resourceId", resourceId);
        //如果是登录用户查看，且该用户已下载，则显示积分为0
        User currentUser = (User) request.getSession().getAttribute("user");
        if (currentUser != null) {
            if (downloadService.userAleadyDownload(String.valueOf(currentUser.getUserId()), resourceId)) {
                model.addAttribute("zero", 0);
            }
        }
        //显示该帖子的收藏总数
        int collectionCount = collectionService.collectionCount(resourceId);
        model.addAttribute("collectionCount", collectionCount);
        return "portal/detail";
    }

    /**
     * 下载
     * @param resourceId
     * @param session
     * @return
     */
    @RequestMapping("/resource/download.json")
    @ResponseBody
    public Result download(@RequestParam("resourceId") String resourceId,
                           HttpSession session) {
        //是否已登录
        if (session.getAttribute("user") == null) {
            return Result.error("请登录后下载");
        }
        User user = (User) session.getAttribute("user");
//        要下载的帖子
        Resource resource = resourceService.findById(resourceId);
        //帖子状态是否是可下载的
        if (resource.getState() != 1) {
            return Result.error("当前帖子异常，请稍后重试");
        }
        int pointsResult = user.getPoints() - resource.getPoints();
        //积分不够
        if (pointsResult < 0) {
            return Result.error("当前用户的积分不足");
        }
        //如果没有下载过
        if (!downloadService.userAleadyDownload(String.valueOf(user.getUserId()), resourceId)) {
            //积分够，扣除相应的积分
            user.setPoints(pointsResult);
            userService.updatePoints(String.valueOf(user.getUserId()), String.valueOf(pointsResult));
            //并且插入一条下载记录
            downloadService.insert(user.getUserId(), resourceId);
        }

        //如果是vip,不扣当前用户的分.但仍给作者加分
        if (user.isItsVip()) {
            //将扣除的积分添加至帖子发布人身上
            Integer userId = resourceService.findById(resourceId).getUserId();
            User author = userService.findById(userId);
            userService.updatePoints(String.valueOf(author.getUserId()), String.valueOf(author.getPoints() + resource.getPoints()));
            downloadService.insert(user.getUserId(), resourceId);
            return Result.success();
        }

        //已经下载过了
        //TODO 已经改过了，若用户下载了则会直接显示下载地址和密码，不会再出现下载的按钮
        //TODO 所以下面的else里不会执行了
//        else {
//            //不扣积分
//            return Result.success("已经下载过，本次不会再扣除积分");
//        }
        //将扣除的积分添加至帖子发布人身上
        Integer userId = resourceService.findById(resourceId).getUserId();
        User author = userService.findById(userId);
        userService.updatePoints(String.valueOf(author.getUserId()), String.valueOf(author.getPoints() + resource.getPoints()));
        return Result.success("下载成功");
    }

    /**
     * 某个用户收藏某个帖子
     *
     * @param userId
     * @param resourceId
     * @return
     */
    @RequestMapping("resource/collection.json")
    @ResponseBody
    public Result collect(@RequestParam("userId") String userId,
                          @RequestParam("resourceId") String resourceId) {
        //已经收藏过，则不能再收藏
        boolean isAlreadyCollect = collectionService.isAlreadyCollect(userId, resourceId);
        if (isAlreadyCollect) {
            return Result.error("你之前已经收藏过了");
        }

        collectionService.insert(userId, resourceId);
        return Result.success();
    }

    /**
     * 根据用户id进入收藏夹
     *
     * @return
     */
    @RequestMapping("resource/collection/list.action")
    public String collectionList(HttpSession session,
                                 @RequestParam("userId") String userId,
                                 Model Model) {
        //只能进入自己的收藏
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "admin/login";
        }
        //当前用户的id和输入的不一样，返回false
        if (!String.valueOf(currentUser.getUserId()).equals(userId)) {
            return null;
        }
        //找不到该用户，返回null
        if (userService.findById(Integer.valueOf(userId)) == null) {
            return null;
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", userId);
        List<Collection> collectionList = collectionService.findList(map);
        for (Collection collection : collectionList) {
            collection.setCollectionTimeStr(DateUtil.date2String(collection.getCollectionTime()));
        }
        Model.addAttribute("collectionList", collectionList);
        return "portal/user/collection_list";
    }

    /**
     * 删除收藏
     *
     * @param userId
     * @param idArr
     * @param
     * @return
     */
    @RequestMapping("resource/collection/delete.json")
    @ResponseBody
    public Result deleteCollection(@RequestParam("userId") String userId,
                                   @RequestParam("idArr") String[] idArr,
                                   HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return Result.error("登陆后才能操作");
        }
        collectionService.deleteByUserIdAndResId(userId, idArr);
        return Result.success();
    }

    @RequestMapping("vip.action")
    public String vip() {
        return "portal/user/vip";
    }
}
