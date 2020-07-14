package com.framework.service;

import com.framework.dao.commentmapper.CommentMapper;
import com.framework.entity.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/27 21:36
 * @desc: //TODO
 */
@Service
public class CommentService {
@Autowired
    private CommentMapper commentMapper;

    /**
     * 评论列表
     * @param map
     * @return
     */
    public List<Comment> list(Map<String,Object> map){

        Map<Integer,Comment> map2=new HashMap<Integer, Comment>();
        List<Comment> parentList=new ArrayList<Comment>();
        List<Comment> nodeList = commentMapper.list(map);
        for (Comment comment : nodeList) {
            map2.put(comment.getCommentId(),comment);
            if (comment.getParentId()==null){  //是顶级节点
                parentList.add(comment);
            }
        }
        for (Comment comment : nodeList) {
            Comment parent =(Comment) map2.get(comment.getParentId());
            if (parent!=null){
                parent.getReplyList().add(comment);
            }
        }

        return parentList;
}

    /**
     * 总评论数
     * @return
     */
    public int commentCount(){
        return commentMapper.commentCount();
}

    /**
     * 保存评论
     * @param comment
     */
    public void save(Comment comment) {
        commentMapper.save(comment);
    }

    /**
     * 根据id查询评论
     * @param commentId
     * @return
     */
    public Comment findById(String commentId) {
        return commentMapper.findById(commentId);
    }

    /**
     * 删除评论
     *
     * 根据父评论id查询到旗下的所有子评论，如果有，然后也删除
     * @param ids
     */
    public void  delete(String[] ids) {
        List<Comment> sonList=null;
        String [] sonCommentIdArray=null;
        for (String id : ids) {
            //查一下是否有子评论
         sonList= commentMapper.finsSonCommentById(id);
        }
//        如果有。级联删除
        if (sonList.size()>0){
           sonCommentIdArray =new String[sonList.size()];
           //把子评论id加到数组中
            for (int x=0;x<sonCommentIdArray.length;x++){
                sonCommentIdArray[x]=String.valueOf(sonList.get(x).getCommentId());
            }
           //删除子评论
            commentMapper.delete(sonCommentIdArray);
        }
            commentMapper.delete(ids);
    }

    /**
     * 今日新增评论数
     * @return
     */
    public int todayNewAddCommentCount() {
        return commentMapper.todayNewAddCommentCount();
    }

    /**
     * 删除帖子时，对应的评论也要删掉
     * @param idArray
     */
    public void deleteByForeignKey(String[] idArray) {
        commentMapper.deleteByForeignKey(idArray);
    }
//根据用户id查找该用户的所有评论
    public List<Comment> findByUserId(Integer userId) {
        return commentMapper.findByUserId(userId);

    }

    public void update(int commentId, String avatar) {
        commentMapper.update(commentId,avatar);
    }
}
