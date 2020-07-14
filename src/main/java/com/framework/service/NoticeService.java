package com.framework.service;

import com.framework.dao.noticemapper.NoticeMapper;
import com.framework.entity.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @auther: 翁筱寒
 * @date: 2020/5/25 11:50
 * @desc:
 *
 */
@Service
@Transactional
public class NoticeService {
@Autowired
    protected NoticeMapper noticeMapper;
//查询公告
public Notice findLastNotice(){
    return noticeMapper.findLastNotice();
}

    /**'
     * 更新公告内容
     * @param id
     * @param content
     */
    public void updateNotice(String id ,String content){
       noticeMapper.updateNotice(id,content);
    }
}

