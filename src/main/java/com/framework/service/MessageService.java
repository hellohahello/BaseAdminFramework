package com.framework.service;

import com.framework.dao.messagemapper.MessageMapper;
import com.framework.entity.Message;
import com.framework.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @auther: 翁筱寒
 * @date: 2020/4/8 13:25
 * @desc: //TODO
 */
@Service
public class MessageService {
    @Autowired
    protected MessageMapper messageMapper;

    /**
     * 查询消息列表
     *
     * @param userId
     * @return
     */
    public List<Message> findListByUserId(String userId) {
        List<Message> list = messageMapper.findListByUserId(userId);
        for (Message message : list) {
            message.setCreateTimeStr(DateUtil.date2String(message.getCreateTime()));
        }
        return list;
    }
    /**
     * 未读的消息里列表
     *
     */
    public List<Message> findMessageNotRead(String userId){
        List<Message> list = messageMapper.findMessageNotRead(userId);
        for (Message message : list) {
            message.setCreateTimeStr(DateUtil.date2String(message.getCreateTime()));
        }
        return list;
    }

    /**
     * 保存消息
     * @param message
     */
    public void save(Message message) {
        messageMapper.insert(message);
    }

    /**
     * 未读消息数
     * @param userId
     * @return
     */
    public int getCountByUserId(Integer userId) {
        return messageMapper.getCountByUserId(userId);
    }

    /**
     * 设置为已读
     * @param id
     */
    public void setToAlreadyRead(Integer id) {
        messageMapper.setToAlreadyRead(id);
    }

    /**
     * 删除
     * @param idArr
     */
    public void delete(String[] idArr) {
        messageMapper.delete(idArr);
    }
}
