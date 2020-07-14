package com.framework.entity;


import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/16 16:02
 * @desc: //帖子表实体类
 */

public class Resource implements Serializable{
//    帖子id
    private Integer resourceId;
//帖子名称
    private String resourceName;
//发布时间
    private Date createTime;
    @Transient
//    发布时间字符串
    private String createTimeStr;
//    发布用户id
    private Integer userId;
//帖子类型id
    private Integer resCategoryId;
//是否免费  0不免费 1免费   默认1
    private boolean itsFree=true;
//下载花费积分
    private Integer points;
//帖子内容
    private String content;

    @Deprecated
    @Transient
    private String contentNoTag;


    //封面
    private String cover;
//下载地址
    private String download;
//下载密码
    private String passWord;
//描述
    private String desc;
//是否热门 0不热门 1热门 默认0
    private boolean itsHot=false;
//状态   0待审核  1审核通过  1审核驳回
    private Integer state;
//审核未通过原因
    private String reason;
//审查日期
    private Date checkDate;
//点击数
   private Integer click;
//关键字
   private String keyword;
//帖子的链接是否有效   0（false）无效   1有效
   private boolean itsUseful=true;
//所属用户头像地址
   @Transient
   private String avatar;
@Transient
private String userName;
//分类名称
    @Transient
   private String categoryName;

//    评论时间Str
    @Transient
    private Date commentTime;
    @Transient
    private String commentTimeStr;

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Integer getResourceId() {
        return resourceId;
    }

    public void setResourceId(Integer resourceId) {
        this.resourceId = resourceId;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreateTimeStr() {
        return createTimeStr;
    }

    public void setCreateTimeStr(String createTimeStr) {
        this.createTimeStr = createTimeStr;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getResCategoryId() {
        return resCategoryId;
    }

    public void setResCategoryId(Integer resCategoryId) {
        this.resCategoryId = resCategoryId;
    }

    public boolean isItsFree() {
        return itsFree;
    }

    public void setItsFree(boolean itsFree) {
        this.itsFree = itsFree;
    }

    public Integer getPoints() {
        return points;
    }

    public void setPoints(Integer points) {
        this.points = points;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContentNoTag() {
        return contentNoTag;
    }

    public void setContentNoTag(String contentNoTag) {
        this.contentNoTag = contentNoTag;
    }

    public String getDownload() {
        return download;
    }

    public void setDownload(String download) {
        this.download = download;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public boolean isItsHot() {
        return itsHot;
    }

    public void setItsHot(boolean itsHot) {
        this.itsHot = itsHot;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Date getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(Date checkDate) {
        this.checkDate = checkDate;
    }

    public Integer getClick() {
        return click;
    }

    public void setClick(Integer click) {
        this.click = click;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getKeyword() {
        return keyword;
    }

    public boolean isItsUseful() {
        return itsUseful;
    }

    public void setItsUseful(boolean itsUseful) {
        this.itsUseful = itsUseful;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
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
}
