package com.framework.entity;

import javax.persistence.Transient;
import java.util.Date;

/**
 * @auther: 翁筱寒
 * @date: 2020/5/25 11:43
 * @desc: //首页公告栏
 */

public class Notice {
private  String id;
//内容
    private String content;
    //发布时间
    private Date createTime;
    //str
    @Transient
    private String createTimeStr;

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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
