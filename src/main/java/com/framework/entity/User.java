package com.framework.entity;

import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/13 14:16
 * @desc: //用户表
 */
public class User implements Serializable {
//用户id
    private Integer userId;
//用户名
    private String userName;
//昵称
    private String nickname;
//密码
    private String passWord;
//头像
    private String avatar;
//QQ用户登录的唯一标识
    private String openId;
//性别
    private String sex;
//邮箱
    private String email;
//是否为vip，默认不是。所以给了个false。对应的数据库为bit
    private boolean itsVip=false;
//vip等级，默认0
    private Integer vipGrade=0;
//角色名称   //管理员  //普通会员
    private String roleName="会员";  //
//用户积分，默认0
    private Integer points=0;
//是否被封号了
    private boolean itsOff=false;
//注册时间
   private Date registerTime;
//最后登录时间
    private Date lastLoginTime;

    //最后登录时间字符串形式
    @Transient
    private String lastLoginTimeStr;
@Transient
//    非数据库字段。消息数
    private Integer messageCount;

private String registerTimeStr;

    public String getRegisterTimeStr() {
        return registerTimeStr;
    }

    public void setRegisterTimeStr(String registerTimeStr) {
        this.registerTimeStr = registerTimeStr;
    }

    public String getLastLoginTimeStr() {
        return lastLoginTimeStr;
    }

    public void setLastLoginTimeStr(String lastLoginTimeStr) {
        this.lastLoginTimeStr = lastLoginTimeStr;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isItsVip() {
        return itsVip;
    }

    public void setItsVip(boolean itsVip) {
        this.itsVip = itsVip;
    }

    public Integer getVipGrade() {
        return vipGrade;
    }

    public void setVipGrade(Integer vipGrade) {
        this.vipGrade = vipGrade;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Integer getPoints() {
        return points;
    }

    public void setPoints(Integer points) {
        this.points = points;
    }

    public boolean isItsOff() {
        return itsOff;
    }

    public void setItsOff(boolean itsOff) {
        this.itsOff = itsOff;
    }

    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public Integer getMessageCount() {
        return messageCount;
    }

    public void setMessageCount(Integer messageCount) {
        this.messageCount = messageCount;
    }


    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", nickname='" + nickname + '\'' +
                ", passWord='" + passWord + '\'' +
                ", avatar='" + avatar + '\'' +
                ", openId='" + openId + '\'' +
                ", sex='" + sex + '\'' +
                ", email='" + email + '\'' +
                ", itsVip=" + itsVip +
                ", vipGrade=" + vipGrade +
                ", roleName='" + roleName + '\'' +
                ", points=" + points +
                ", itsOff=" + itsOff +
                ", registerTime=" + registerTime +
                ", lastLoginTime=" + lastLoginTime +
                '}';
    }
}
