package com.framework.dao.usermapper;

import com.framework.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/12 14:22
 * @desc: //TODO
 */
public interface UserMapper {
//    根据用户名和密码查询用户
    public User findByUserNameAndPassword(@Param("userName")String userName,@Param("passWord")String passWord);

//根据邮箱查询用户 （找回密码时输入邮箱，判断是不是这个人—）
    public User findByEmail(@Param("email")String email);

    void updatePassword(@Param("newPassWord") String newPassWord, @Param("emailInfo") String emailInfo);
//   注册
    public void insertUser(User user);
//    更新用户信息
    public void updateUser(User user);
//    更新最后登录时间
    void updateLoginTime(@Param("lastLoginTime")Date lastLoginTime,@Param("userId")String userId);

//    根据id查找用户
    User findById(@Param("userId") Integer userId);
//    更新积分
    void updatePoints(@Param("userId") String userId,@Param("points") String points);
//返回今日新增用户数
    int todayNewAddUserCount();
    //返回用户列表
    List<User> list();

    void setVip(@Param("userId") String userId);
//取消vip
    void setNoVip(@Param("userId")String userId);

    void offUserById(@Param("userId") String userId);
    void noOffUserById(@Param("userId") String userId);

//    更新角色
    void updateRoleName(@Param("roleName") String roleName,@Param("userId") String userId);
//更新头像
    void updateAvatar(@Param("base64Image") String base64Image,@Param("userId")String userId);
}
