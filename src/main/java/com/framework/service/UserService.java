package com.framework.service;

import com.framework.dao.usermapper.UserMapper;
import com.framework.entity.User;
import com.framework.utils.MD5Util;
import com.framework.utils.Result;
import com.framework.utils.SendMail;
import com.framework.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/13 14:42
 * @desc: //TODO
 */
@Service
@Transactional
public class UserService {
    String inputCode="";
@Autowired
    private UserMapper userMapper;

    /**
     * 根据用户名和密码查询用户
     * @param userName
     * @param passWord
     * @return
     */
    public User findByUserNameAndPassword(String userName,String passWord){
    User user = userMapper.findByUserNameAndPassword(userName, passWord);
    return user;
}

    /**
     * 根据邮箱查询用户。  忘记密码时---通过邮箱找回密码
     * @param email
     * @return
     */
    public User findByEmail(String email){
        return userMapper.findByEmail(email);
    }

    /**
     * 根据邮箱更新密码
     * @param newPassWord
     * @param emailInfo
     */
    public void updatePassword(String newPassWord, String emailInfo) {
        userMapper.updatePassword(newPassWord,emailInfo);
    }

    /**
     * 根据id是否为空，判断是注册还是更新用户信息
     * @param user
     * @return   0表示操作成功， 返回1则表示操作失败
     */
  protected  static final String DEFAULT_IMAGE_URL="http://duxiaoyue.top/head.gif";
    public int save(User user){
        //插入用户
        if (StringUtils.isEmpty(user.getUserId())){
            //邮箱已被注册
            if (null!=userMapper.findByEmail(user.getEmail())){
                return 1;
            }
            user.setAvatar(DEFAULT_IMAGE_URL);
            user.setLastLoginTime(new Date());
            user.setRegisterTime(new Date());
            String passWord = user.getPassWord();
            passWord= MD5Util.md5(passWord);
            user.setPassWord(passWord);
            userMapper.insertUser(user);
            return 0;
        }
        return 0;
    }

    /**
     * 根据用户id，更新最后登录时间
     * @param loginTime
     * @param userId
     */
    public void updateLoginTime(Date loginTime,String userId){
        userMapper.updateLoginTime(loginTime,userId);
    }

    /**
     * 根据id查询用户
     * @param userId
     */
    public User findById(Integer userId) {
        return userMapper.findById(userId);
    }

    /**
     * 更新积分
     * @param userId
     * @param points
     */
    public void updatePoints(String userId,String points){
        userMapper.updatePoints(userId,points);
}

    /**
     * 返回今日新增用户数
     * @return
     */
    public int todayNewAddUserCount(){
        return userMapper.todayNewAddUserCount();
    }

    /**
     * 返回用户列表
     * @return
     */
    public List<User> list() {
        return userMapper.list();
    }

    /**
     * 更新vip状态
     *  根据setToVIP的值判断是取消vip状态还是设置为vip用户
     * @param userId
     * @param setToVip
     */
    public void updateVipState(String userId, String setToVip) {
        if (Integer.valueOf(setToVip)==1){
            //如果已经是vip,则无需设置
            if (userMapper.findById(Integer.valueOf(userId)).isItsVip()){
                return;
            }
            userMapper.setVip(userId);
        }
        else if (Integer.valueOf(setToVip)==0){
            //如果原先就不是vip,则无需设置
            if (!userMapper.findById(Integer.valueOf(userId)).isItsVip()){
                return;
            }
            userMapper.setNoVip(userId);
        }
    }
    /**
     * 设置用户是否被封禁
     * 根据setToOff的值判断是封禁还是取消封禁
     * @param userId
     * @param setToOff
     * @return
     */
    public void updateOffState(String userId, String setToOff) {
        //封禁用户
        if (Integer.valueOf(setToOff)==1){
            if (userMapper.findById(Integer.valueOf(userId)).isItsOff()){
                return;
            }
            userMapper.offUserById(userId);
        }
        //取消封禁
        else {
            if (!userMapper.findById(Integer.valueOf(userId)).isItsOff()){
                return;
            }
            userMapper.noOffUserById(userId);
        }
    }
    public void updateRoleName(String roleName,String userId){
        userMapper.updateRoleName(roleName,userId);
    }

    /**
     * 更新用户头像
     * @param base64Image
     */
    public void updateAvatar(String base64Image,String userId) {
        userMapper.updateAvatar(base64Image,userId);
    }
}
