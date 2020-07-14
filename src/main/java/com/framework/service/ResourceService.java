package com.framework.service;

import com.framework.dao.resourcemapper.ResourceMapper;
import com.framework.entity.Resource;
import com.framework.utils.DateUtil;
import com.framework.utils.StringUtil;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/17 21:25
 * @desc: //帖子
 */
@Service
public class ResourceService {
    Date startDate=null;
    Date endDate=null;
    @Autowired
    private ResourceMapper resourceMapper;

    /**
     * 查询帖子列表
     * @param param
     * @return
     */
    public List<Resource> list(Map<String, Object> param){
        List<Resource> list=resourceMapper.list( param);
        for (Resource resource : list) {
            if (resource.getCreateTime()!=null){
                resource.setCreateTimeStr(DateUtil.date2String(resource.getCreateTime()));
            }
        }
        return list;
    }

    /**
     * 根据id查询resource
     * @param resourceId
     * @return
     */
    public Resource findById(String resourceId) {
        //更新打开时更新浏览次数
        int viewCount = resourceMapper.getViewCount(resourceId);
        viewCount++;
        Resource resource = resourceMapper.findById(resourceId);
        resource.setClick(viewCount);
        resourceMapper.update(resource);
        return resource;

    }

    /**
     * 保存帖子
     * @param resource
     */
    public void save(Resource resource) {
        //新增
        if (StringUtils.isEmpty(resource.getResourceId())){
            resourceMapper.insert(resource);
        }
        //编辑
        else {
            resourceMapper.update(resource);
        }
    }

    /**
     * 批量删除
     * @param idArray
     */
    public void delete(String[] idArray) {

        resourceMapper.delete(idArray);

    }

    /**
     * 今日新增帖子数
     * @return
     */
    public int todayNewAddResourceCount() {
        return resourceMapper.todayNewAddResourceCount();
    }

    /**
     * 待审核帖子数
     * @return
     */
    public int notJudgeResourceCount() {
        return resourceMapper.notJudgeResourceCount();
    }

    /**
     * 更新帖子是否是热门
     * @param resourceId
     * @param setHot
     */
    public void upSetOrNotHot(String resourceId, String setHot) {
        if (setHot.equals("1")){
            resourceMapper.setHot(resourceId);
            Resource resource = resourceMapper.findById(resourceId);
            resource.setClick(StringUtil.get100To500Number());
            resourceMapper.update(resource);

        }
        else {
            resourceMapper.setNotHot(resourceId);
            Resource resource = resourceMapper.findById(resourceId);
            resource.setClick(StringUtil.getTenToFiftyNumber());
            resourceMapper.update(resource);
        }
    }

    public void setFreeOrNotFree(String resourceId, String setFree) {
        if (setFree.equals("1")){
            resourceMapper.setFree(resourceId);
        }
        else {
            resourceMapper.setNotFree(resourceId);
        }
    }

    /**
     * 最新插入的5条记录
     * @param map
     * @return
     */
    public List<Resource> lastList(Map map){
       return resourceMapper.lastList(map);
    }

    /**
     * 根据阅读量倒序
     * @return
     */
    public List<Resource> listByClick(){
        return resourceMapper.listByClick();
    }

    /**
     * 根据评论时间倒序
     * @return
     */
    public List<Resource> listByCommentTimeDesc(){
        return resourceMapper.listByCommentTimeDesc();
    }
}
