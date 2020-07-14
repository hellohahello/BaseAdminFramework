package com.framework.dao.resourcemapper;

import com.framework.entity.Resource;
import com.sun.org.apache.regexp.internal.RE;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map; /**
 * @auther: 翁筱寒
 * @date: 2020/3/17 21:26
 * @desc: //帖子相关操作 Dao
 */
public interface ResourceMapper {
    //查询帖子列表
    public List<Resource> list(Map<String, Object> param);
//根据id查询resource
    Resource findById(@Param("resourceId") String resourceId);
    //插入帖子
    void insert(Resource resource);
//更新信息
    void update(Resource resource);
//批量删除
    void delete(@Param("idArray") String[] idArray);
//今日新增帖子数
    int todayNewAddResourceCount();
//待审核帖子数
    int notJudgeResourceCount();
//设置为热门
    void setHot(@Param("resourceId")String resourceId);
//    设置为非热门
    void setNotHot(@Param("resourceId") String resourceId);
//设置为免费
    void setFree(@Param("resourceId")String resourceId);
//    设置为收费
    void setNotFree(@Param("resourceId")String resourceId);

    int getCountByCategoryId(@Param("idArr") String[] idArr);
    //查询最新的主题
    List<Resource> lastList(Map<String, Object> param);
//    根据阅读量排序--倒序
    List<Resource> listByClick();

    //根据评论时间排序
    List<Resource> listByCommentTimeDesc();
//    浏览量
    int getViewCount(@Param("resourceId") String resouceId);
}
