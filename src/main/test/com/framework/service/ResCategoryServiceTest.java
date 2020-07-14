package com.framework.service;

import com.framework.entity.ResCategory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/18 20:29
 * @desc: //TODO
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-mybatis.xml")

public class ResCategoryServiceTest {
@Autowired
private ResCategoryService resCategoryService;
    @Test
    public void list() throws Exception {
        List<ResCategory> list = resCategoryService.list();
        for (ResCategory resCategory : list) {
            System.out.println(resCategory.getCategoryName());
        }
    }

}