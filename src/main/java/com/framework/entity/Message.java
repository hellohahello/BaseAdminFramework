package com.framework.entity;

import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;

/**
 * @auther: 翁筱寒
 * @date: 2020/4/1 21:12
 * @desc: //消息表
 */
public class Message implements Serializable{
//    id
    private Integer messageId;
//    消息内容
    private  String messageContent;
//    消息原因
    private String  messageTitle;
//    所属用户
    private Integer userId;
//    创建时间
    private Date createTime;
    @Transient
    private String createTimeStr;
//    是否已读，默认未读
    private boolean itsAlready=false;

    public Integer getMessageId() {
        return messageId;
    }

    public void setMessageId(Integer messageId) {
        this.messageId = messageId;
    }

    public String getMessageContent() {
        return messageContent;
    }

    public void setMessageContent(String messageContent) {
        this.messageContent = messageContent;
    }

    public String getMessageTitle() {
        return messageTitle;
    }

    public void setMessageTitle(String messageTitle) {
        this.messageTitle = messageTitle;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
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

    public boolean isItsAlready() {
        return itsAlready;
    }

    public void setItsAlready(boolean itsAlready) {
        this.itsAlready = itsAlready;
    }
}
