package com.framework.utils;

import org.springframework.util.StringUtils;

import java.util.Random;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/14 10:32
 * @desc: //字符串工具
 */
public class StringUtil {
    /**
     * 隐藏邮箱信息，默认隐藏@符号前面的后三位
     * @param email
     * @return
     */
    public static String maskEmail(String email) {
        if (email==""||email==null) {
            return email;
        }
        return email.replaceAll("(\\w+)\\w{3}@(\\w+)", "$1***@$2");
    }
    /**
     * 隐藏手机号
     *
     * @param mobile
     * @return
     */
    public static String maskMobile(String mobile) {
        if (StringUtils.isEmpty(mobile) || (mobile.length() != 11)) {
            return mobile;
        }
        return mobile.replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2");
    }
    /**
     * 隐藏身份证号码
     *
     * @param id
     * @return
     */
    public static String maskIdCardNo(String id) {
        if (StringUtils.isEmpty(id) || (id.length() < 8)) {
            return id;
        }
        return id.replaceAll("(?<=\\w{6})\\w(?=\\w{6})", "*");
    }
    /**
     * 六位随机数
     */
    public static synchronized String getSixRandomNumber(){
        StringBuilder res=new StringBuilder();
        Random random=new Random();
        for (int i=0;i<6;i++){
            res.append(random.nextInt(10));
        }
        return String.valueOf(res);
    }

    /**
     * 得到10-50的数
     * @return
     */
    public static int getTenToFiftyNumber(){
        Random random=new Random();
       int res= random.nextInt(40)+10;
       return res;
    }

    //100-500的随机数
    public static int get100To500Number(){
        Random random=new Random();
        int res= random.nextInt(900)+400;
        return res;
    }
//    1-4随机数
    public static int getOneTOFive(){
        Random random=new Random();
        int res= (random.nextInt(5))+1;
        while (res>=4||res==0){
            res= random.nextInt(5)+1;
        }
        return res;
    }

    public static void main(String[] args) {
        for (int i=0;i<120;i++){
            System.out.println(getOneTOFive());
        }
    }
}
