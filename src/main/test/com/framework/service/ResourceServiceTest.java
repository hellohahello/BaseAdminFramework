package com.framework.service;

import com.framework.entity.Resource;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

/**
 * @auther: 翁筱寒
 * @date: 2020/4/4 20:45
 * @desc: //TODO
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-mybatis.xml")
public class ResourceServiceTest {
    @Autowired
    private ResourceService resourceService;
    @Test
    public void listByCommentTimeDesc() throws Exception {
        List<Resource> resourceList = resourceService.listByCommentTimeDesc();
        for (Resource resource : resourceList) {
            System.out.println(resource.getResourceName());
        }
    }

}