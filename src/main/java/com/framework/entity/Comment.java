package com.framework.entity;

import com.sun.net.httpserver.Authenticator;
import javafx.beans.binding.IntegerExpression;
import org.springframework.instrument.classloading.tomcat.TomcatLoadTimeWeaver;

import javax.persistence.Transient;
import javax.servlet.http.HttpSession;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/27 19:18
 * @desc: //TODO
 */
public class Comment implements Serializable {
//    评论id
    private int commentId;
//    评论时间
    private Date commentTime;

    @Transient
    private String commentTimeStr;   //页面上字符串形式的时间
//    评论状态  0待审核  1通过 2未通过     默认1
    private Integer status;
//    用户id
    private Integer userId;
//    帖子id
    private Integer resourceId;
//    评论内容
    private String content;
//    发布该评论的用户名
    @Transient
     private String commentOwnName;

    //被回复人的用户名
    @Transient
    private String replyedName;

    //被回复用户id
    private int toUid;
//    父评论id
    private Integer parentId;
//    回复给谁
    private String toUserName;
//    谁回复的
    private String replyUserName;
//    头像
    private String avatar;
//    帖子名称
    private String resourceName;
//   回复列表
    private List<Comment> replyList=new ArrayList<Comment>();

    public String getToUserName() {
        return toUserName;
    }

    public void setToUserName(String toUserName) {
        this.toUserName = toUserName;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public String getCommentTimeStr() {
        return commentTimeStr;
    }

    public void setCommentTimeStr(String commentTimeStr) {
        this.commentTimeStr = commentTimeStr;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getResourceId() {
        return resourceId;
    }

    public void setResourceId(Integer resourceId) {
        this.resourceId = resourceId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCommentOwnName() {
        return commentOwnName;
    }

    public void setCommentOwnName(String commentOwnName) {
        this.commentOwnName = commentOwnName;
    }

    public String getReplyedName() {
        return replyedName;
    }

    public void setReplyedName(String replyedName) {
        this.replyedName = replyedName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public List<Comment> getReplyList() {
        return replyList;
    }

    public void setReplyList(List<Comment> replyList) {
        this.replyList = replyList;
    }

    public int getToUid() {
        return toUid;
    }

    public void setToUid(int toUid) {
        this.toUid = toUid;
    }

    public String getReplyUserName() {
        return replyUserName;
    }

    public void setReplyUserName(String replyUserName) {
        this.replyUserName = replyUserName;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }
}
