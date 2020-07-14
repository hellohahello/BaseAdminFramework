package com.framework.dao.noticemapper;

import com.framework.entity.Notice;
import org.apache.ibatis.annotations.Param;

/**
 * @auther: 翁筱寒
 * @date: 2020/5/25 11:44
 * @desc: //TODO
 */
public interface NoticeMapper {
    //返回最新的公告
    Notice findLastNotice();
//更新公告
    void updateNotice(@Param("id") String id,@Param("content") String content);
}
