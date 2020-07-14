package com.framework.service;

import com.framework.entity.User;
import com.framework.utils.MD5Util;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;

import static org.junit.Assert.*;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/13 14:43
 * @desc: //TODO
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-mybatis.xml")
public class UserServiceTest {
    final   String  USER_NAME="李朋";
    static    String  PASS_WORD="12345";
    @Autowired
    private UserService userService;
    @Test
    public void findByUserNameAndPassword() throws Exception {
        PASS_WORD= MD5Util.md5(PASS_WORD);
        User user = userService.findByUserNameAndPassword(USER_NAME, PASS_WORD);
        System.out.println(user);

    }
    Random random=new Random();
    @Test
    public void  test2(){
        AtomicInteger atomicInteger=new AtomicInteger(0);

        String[] userNameArr={"张无忌","周芷若","小昭","扫地僧","段誉","乔峰"};
        String[] nickNameArr={"张无忌昵称","周芷若昵称","小昭昵称","扫地僧昵称","段誉昵称","乔峰昵称"};
       for (int i=0;i<3500000;i++){
           int res = random.nextInt(20);
           User user=new User();
           user.setPoints(10);
           user.setMessageCount(0);
           user.setPassWord(String.valueOf(res));
           user.setAvatar("test.jpg");
           UUID uuid = UUID.randomUUID();
          String email= String.valueOf(uuid).substring(0,8);
           user.setEmail(email+"@163.com");
           user.setRegisterTime(new Date());
           user.setVipGrade(1);
           if (i%2==0){
               user.setRoleName("会员");
               user.setSex("男");
           }else {
               user.setRoleName("管理员");
               user.setSex("女");
           }
           while (res>5){
               res=random.nextInt(20);
           }
           user.setUserName(userNameArr[res]);
           user.setNickname(nickNameArr[res]);
           user.setItsVip(true);
           user.setLastLoginTime(new Date());
           user.setRegisterTime(new Date());
           userService.save(user);
           System.out.println("已插入"+atomicInteger+"次");
           atomicInteger.getAndIncrement();
       }
        System.out.println("插入结束，共插入了"+atomicInteger+"条数据");

    }




}