package com.framework.controller.portal;

import com.framework.entity.Comment;
import com.framework.entity.Message;
import com.framework.entity.Resource;
import com.framework.entity.User;
import com.framework.service.CommentService;
import com.framework.service.MessageService;
import com.framework.service.ResourceService;
import com.framework.service.UserService;
import com.framework.utils.DateUtil;
import com.framework.utils.Result;
import com.framework.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.resources.Messages;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/27 21:16
 * @desc: //TODO
 */
@Controller
@RequestMapping("portal/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;
    @Autowired
    private UserService userService;
    @Autowired
    private MessageService messageService;
    @Autowired
    private ResourceService resourceService;

    /**
     * 评论列表展示
     *
     * @param resourceId
     * @param
     * @return
     */
    @RequestMapping("/list.json")
    @ResponseBody
    public Result list(@RequestParam("resourceId") String resourceId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("resourceId", resourceId);
        //评论列表
        List<Comment> commentList = commentService.list(map);
//        评论总条数
        int count = commentService.commentCount();
        for (Comment comment : commentList) {
            comment.setCommentTimeStr(DateUtil.date2String(comment.getCommentTime()));
            for (Comment reply : comment.getReplyList()) {
                reply.setCommentTimeStr(DateUtil.date2String(reply.getCommentTime()));
            }

        }
        return Result.success().add("commentList", commentList);
    }

    /**
     * 保存评论
     *
     * @param
     * @return
     */
    @RequestMapping("save.json")
    @ResponseBody
    public Result save(
                       @RequestParam("content") String content,
                       @RequestParam("avatar") String avatar,
                       @RequestParam("userId") String userId,
                       @RequestParam("commentTime") Date commentTime,
                       @RequestParam("resourceId") String resourceId) {
        //新增评论
           Comment comment = new Comment();
           comment.setContent(content);
           comment.setCommentTime(commentTime);
           comment.setUserId(Integer.valueOf(userId));
           comment.setStatus(1);
           comment.setAvatar(avatar);
           comment.setResourceId(Integer.valueOf(resourceId));
           commentService.save(comment);

           //发送消息
        Message message=new Message();
        //创建时间
        message.setCreateTime(new Date());
        //属于谁的消息
        message.setUserId(resourceService.findById(resourceId).getUserId());
        message.setItsAlready(false);
        message.setMessageTitle("新评论");
        message.setMessageContent("您的帖子：【"+resourceService.findById(resourceId).getResourceName()+"】有了新回复");
        messageService.save(message);
        return Result.success();
    }

    /**
     * 回复评论
     * @param content
     * @param toUserId
     * @param commentTime
     * @param resourceId
     * @param commentId
     * @param userId
     * @param avatar
     * @return
     */
    @RequestMapping("reply.json")
    @ResponseBody
    public Result reply(@RequestParam("content") String content,
                        @RequestParam("toUserId") String toUserId,
                        @RequestParam("commentTime") Date commentTime,
                        @RequestParam("resourceId") String resourceId,
                        @RequestParam("commentId") String commentId,
                        @RequestParam("userId")String userId,
                        @RequestParam("avatar")String avatar
                        ){
        Comment oldComment=commentService.findById(commentId);
        User oldCommentOfUser = userService.findById(oldComment.getUserId());
        User currentReplyUser=userService.findById(Integer.valueOf(userId));
        String userName = oldCommentOfUser.getUserName();
        Comment reply=new Comment();
        reply.setCommentTime(commentTime);
        //
        reply.setToUserName(userName);
        reply.setContent(content);
        reply.setToUid(Integer.valueOf(oldComment.getUserId()));
        reply.setResourceId(Integer.valueOf(resourceId));
        reply.setParentId(Integer.valueOf(commentId));
        reply.setStatus(1);
        reply.setUserId(Integer.valueOf(userId));
        reply.setAvatar(avatar);
        reply.setToUserName(oldCommentOfUser.getUserName());
        reply.setReplyUserName(currentReplyUser.getUserName());
        commentService.save(reply);
        //
        //发送消息
        Message message=new Message();
        //创建时间
        message.setCreateTime(new Date());
        //属于谁的消息
        message.setUserId(Integer.valueOf(toUserId));
        message.setItsAlready(false);
        message.setMessageTitle("新回复");
        message.setMessageContent("您在帖子【"+resourceService.findById(resourceId).getResourceName()+"】下的评论，用户"+userService.findById(Integer.valueOf(userId)).getUserName()+"回复了你");
        messageService.save(message);
        return Result.success();
    }
}
