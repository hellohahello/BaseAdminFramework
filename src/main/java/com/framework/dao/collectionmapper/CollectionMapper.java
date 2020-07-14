package com.framework.dao.collectionmapper;

import com.framework.entity.Collection;
import com.framework.entity.Comment;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/27 21:21
 * @desc: //收藏表
 */
public interface CollectionMapper {
    //某个帖子的收藏数
    int collectionCount(@Param("resourceId") String resourceId);
    //是否收藏了某个帖子
    int isAlreadyCollect(@Param("userId") String userId, @Param("resourceId") String resourceId);
//用户收藏帖子
    void insert(Collection collection);
//根据用户id查询收藏列表
    List<Collection> findList(Map<String, Object> map);

    void deleteByUserIdAndResId(@Param("userId") String userId, @Param("idArr") String[] idArr);
}
