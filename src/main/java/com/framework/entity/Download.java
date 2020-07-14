package com.framework.entity;

import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/28 22:06
 * @desc: //下载的记录在这里
 */
public class Download implements Serializable{
//    主键
    private Integer downloadId;
//    下载时间
    private Date downloadTime;
    @Transient
    private String downloadTimeStr;
//    下载用户id
    private Integer userId;
//    对应的帖子id
    private  Integer resourceId;

    public Integer getDownloadId() {
        return downloadId;
    }

    public void setDownloadId(Integer downloadId) {
        this.downloadId = downloadId;
    }

    public Date getDownloadTime() {
        return downloadTime;
    }

    public void setDownloadTime(Date downloadTime) {
        this.downloadTime = downloadTime;
    }

    public String getDownloadTimeStr() {
        return downloadTimeStr;
    }

    public void setDownloadTimeStr(String downloadTimeStr) {
        this.downloadTimeStr = downloadTimeStr;
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
}
