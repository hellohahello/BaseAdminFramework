package com.framework.service;

import com.framework.entity.Comment;
import com.framework.entity.Resource;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/28 16:48
 * @desc: //TODO
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-mybatis.xml")
public class CommentServiceTest {
    @Autowired
    CommentService commentService;
    @Autowired
    ResourceService resourceService;
    @Test
    public void list() throws Exception {
        Map map=new HashMap();
        List list = commentService.list(map);
        System.out.println("");
        //根据评论时间排序文章列表

    }

}