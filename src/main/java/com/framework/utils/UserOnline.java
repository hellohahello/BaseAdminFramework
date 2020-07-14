package com.framework.utils;

import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/31 22:18
 * @desc: //判断用户是否还在线
 */
@Component
public class UserOnline {
    //管理员是否在线，在线才能进行操作
    public static boolean userIsOnline(HttpSession session){
        Object administrator = session.getAttribute("administrator");
        if (administrator==null){
            return false;
        }
return true;
    }

    /**
     * 普通用户是否在线
     * @param session
     * @return
     */
    public static boolean portalUserIsOnline(HttpSession session){
        Object user = session.getAttribute("user");
        if (user==null){
            return false;
        }
        return true;
    }
}
