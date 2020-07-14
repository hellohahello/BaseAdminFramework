package com.framework.entity;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Serializable;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/15 22:21
 * @desc: //帖子类型实体类
 */

public class ResCategory  implements Serializable{
//    categoryId
    private Integer resCategoryId;
//分类名称
    private String categoryName;
//分类描述
    private String remark;
//分类排序
    private Integer sort;

    public Integer getResCategoryId() {
        return resCategoryId;
    }

    public void setResCategoryId(Integer resCategoryId) {
        this.resCategoryId = resCategoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }
}
