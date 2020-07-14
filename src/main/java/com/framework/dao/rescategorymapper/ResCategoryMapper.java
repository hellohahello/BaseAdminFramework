package com.framework.dao.rescategorymapper;

import com.framework.entity.ResCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/18 20:13
 * @desc: //TODO
 */
public interface ResCategoryMapper {
//    查询分类列表
public List<ResCategory> list();
//插入分类
    void insert(@Param("categoryName") String categoryName, @Param("sort") String sort);
//    更新分类信息id
    void update(@Param("resCategoryId") String resCategoryId,@Param("categoryName") String categoryName, @Param("sort") String sort);

    void delete(@Param("idArr") String[] idArr);
}
