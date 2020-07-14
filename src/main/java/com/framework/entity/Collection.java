package com.framework.entity;

import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;

/**
 * @auther: 翁筱寒
 * @date: 2020/4/3 16:03
 * @desc: //收藏
 */

public class Collection implements Serializable{
//    id
    private Integer collectionId;
//    是谁收藏的
    private Integer userId;
//    帖子id
    private Integer resourceId;
//    收藏时间
    private Date collectionTime;
    @Transient
    private String collectionTimeStr;

    //帖子名称
    @Transient
    private String resourceName;

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public Integer getCollectionId() {
        return collectionId;
    }

    public void setCollectionId(Integer collectionId) {
        this.collectionId = collectionId;
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

    public Date getCollectionTime() {
        return collectionTime;
    }

    public void setCollectionTime(Date collectionTime) {
        this.collectionTime = collectionTime;
    }

    public String getCollectionTimeStr() {
        return collectionTimeStr;
    }

    public void setCollectionTimeStr(String collectionTimeStr) {
        this.collectionTimeStr = collectionTimeStr;
    }
}
