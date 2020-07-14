package com.framework.service;

import com.framework.dao.downloadmapper.DownloadMapper;
import com.framework.entity.Download;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/28 22:18
 * @desc: //TODO
 */
@Service
public class DownloadService {
@Autowired
    protected DownloadMapper downloadMapper;

    /**
     * 判断是否下载过
     * @param userId
     * @param resourceId
     * @return
     */
    public boolean userAleadyDownload(String userId,String resourceId){
    //有记录说明已经下载
    if (downloadMapper.userAleadyDownload(userId,resourceId)==0){
        return false;
    }
    return true;
}

    /**
     * 插入下载记录
     * @param userId
     * @param resourceId
     */
    public void insert(Integer userId, String resourceId) {
        Download download=new Download();
        download.setUserId(userId);
        download.setResourceId(Integer.valueOf(resourceId));
        download.setDownloadTime(new Date());
        downloadMapper.insert(download);
    }

    /**
     * 当帖子删除时，删除对应下载表里的记录
     * @param idArray
     */
    public void deleteByForeignKey(String[] idArray) {
            downloadMapper.deleteByForeignKey(idArray);
    }
}
