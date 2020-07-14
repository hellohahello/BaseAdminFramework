package com.framework.dao.commentmapper;

import com.framework.entity.Comment;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/27 21:21
 * @desc: //TODO
 */
public interface CommentMapper {
//    总评论数
    int commentCount();
//    评论列表
    List<Comment> list(Map<String,Object> param);

//    保存评论
    void  save(Comment comment);
//根据id查询评论
    Comment findById(@Param("commentId") String commentId);

    void delete(@Param("idArray") String[] idArray);
//根据评论id查询子评论
    List<Comment> finsSonCommentById(@Param("commentId") String commentId);
//今日新增评论数
    int todayNewAddCommentCount();
//删除帖子时，对应的评论先删除
    void deleteByForeignKey(@Param("idArray")String[] idArray);
    //根据用户id查找该用户的所有评论
    List<Comment> findByUserId(@Param("userId") Integer userId);
//更新评论表的用户头像
    void update(@Param("commentId") int commentId,@Param("avatar") String avatar);
}
