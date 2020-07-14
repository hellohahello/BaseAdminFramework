package com.framework.service;

import com.framework.entity.Message;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import java.util.List;

import static org.junit.Assert.*;

/**
 * @auther: 翁筱寒
 * @date: 2020/4/9 21:57
 * @desc: //TODO
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-mybatis.xml")
public class MessageServiceTest {
    @Resource
    MessageService messageService;
    @Test
    public void findListByUserId() throws Exception {
        List<Message> list = messageService.findListByUserId("26");
        for (Message message : list) {
            System.out.println(message.getMessageContent());
        }
    }
}