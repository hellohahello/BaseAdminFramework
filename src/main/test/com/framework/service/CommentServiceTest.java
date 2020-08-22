package com.framework.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/28 16:48
 * @desc: //TODO
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-mybatis.xml")
public class CommentServiceTest {
    @Autowired
    private DownloadService downloadService;
    @Autowired
    CommentService commentService;
    @Autowired
    ResourceService resourceService;
    @Test
    public void list() throws Exception {
        int num = downloadService.num();
        System.out.println("数字"+num);

    }

}