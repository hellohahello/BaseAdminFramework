package com.framework.dao.downloadmapper;

import com.framework.entity.Download;
import org.apache.ibatis.annotations.Param;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/28 22:08
 * @desc: //TODO
 */
public interface DownloadMapper {
    int userAleadyDownload(@Param("userId") String userId,@Param("resourceId") String resourceId);

    //用户下载后，自动插入一条记录
    void insert(Download download);

    /**
     * 当帖子删除时，删除对应下载表里的记录
     * @param idArray
     */
    void deleteByForeignKey(@Param("idArray") String[] idArray);
}
