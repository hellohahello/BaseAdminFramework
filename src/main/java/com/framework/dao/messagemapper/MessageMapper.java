package com.framework.dao.messagemapper;

import com.framework.entity.Message;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @auther: 翁筱寒
 * @date: 2020/4/8 13:26
 * @desc: //消息页面
 */
public interface MessageMapper {
    //所有消息列表
    List<Message> findListByUserId(@Param("userId") String userId);

//    未读的消息
    List<Message> findMessageNotRead(@Param("userId") String userId);
//插入消息
    void insert(Message message);
//查询未读消息数
    int getCountByUserId(@Param("userId") Integer userId);

    void setToAlreadyRead(@Param("messageId") Integer messageId);
//删除消息
    void delete(@Param("idArr")String[] idArr);
}
