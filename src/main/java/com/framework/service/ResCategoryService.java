package com.framework.service;

import com.framework.dao.rescategorymapper.ResCategoryMapper;
import com.framework.dao.resourcemapper.ResourceMapper;
import com.framework.entity.ResCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/18 20:17
 * @desc: //TODO
 */
@Service
public class ResCategoryService  {
@Autowired
    private ResCategoryMapper categoryMapper;
@Autowired
private ResourceMapper resourceMapper;

    /**
     * 根据sort字段，倒序查询分类列表
     * @return
     */
    public List<ResCategory> list(){
    return categoryMapper.list();
}

    /**
     * 保存分类
     * @param idArr
     * @param nameArr
     * @param sortArr
     */
    public void save(String[] idArr, String[] nameArr, String[] sortArr) {
        // 遍历第一个数组
        for (int i=0; i<idArr.length; i++) {
            // 判断这条数据是需要更新还是插入
            if (StringUtils.isEmpty(idArr[i])) {
                // 插入
                categoryMapper.insert(nameArr[i], sortArr[i]);
            } else {
                // 更新
                categoryMapper.update(idArr[i], nameArr[i], sortArr[i]);
            }
        }
    }

    /**
     * 批量删除
     * @param idArr
     */
    public void delete(String[] idArr) throws Exception {
        //判断该分类有没有被使用，被使用则无法删除
       int count= resourceMapper.getCountByCategoryId(idArr);
       if (count>0){
           throw new Exception("存在被使用的分类，无法删除");
       }
        //删除分类
        categoryMapper.delete(idArr);
    }
}
