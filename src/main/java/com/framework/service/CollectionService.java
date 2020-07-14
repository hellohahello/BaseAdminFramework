package com.framework.service;

import com.framework.dao.collectionmapper.CollectionMapper;
import com.framework.entity.Collection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @auther: 翁筱寒
 * @date: 2020/4/3 16:12
 * @desc: //TODO
 */
@Service
public class CollectionService  {
    @Autowired
    private CollectionMapper collectionMapper;

    /**
     * 某个帖子的收藏数
     * @param resourceId
     * @return
     */
    public int collectionCount(String resourceId){
        return collectionMapper.collectionCount(resourceId);
    }

    /**
     * 根据用户id找到用户，判断是否收藏了该帖子
     * @param userId
     * @param resourceId
     * @return
     */
    public boolean isAlreadyCollect(String userId, String resourceId) {
        int count=collectionMapper.isAlreadyCollect(userId,resourceId);
        if (count>0){
            return true;  //已经收藏过了
        }
        return false;
    }

    public void insert(String userId, String resourceId) {
        Collection collection=new Collection();
        collection.setUserId(Integer.valueOf(userId));
        collection.setResourceId(Integer.valueOf(resourceId));
        collection.setCollectionTime(new Date());
        collectionMapper.insert(collection);
    }

    /**
     * 根据用户id查询收藏夹列表
     * @param map
     * @return
     */
    public List<Collection> findList(Map<String, Object> map) {
        return collectionMapper.findList(map);
    }

    /**
     * 删除收藏
     * @param userId
     * @param idArr
     */
    public void deleteByUserIdAndResId(String userId, String[] idArr) {
        collectionMapper.deleteByUserIdAndResId(userId,idArr);
    }
}
