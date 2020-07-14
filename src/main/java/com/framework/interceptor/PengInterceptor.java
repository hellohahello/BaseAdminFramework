package com.framework.interceptor;

import com.framework.entity.User;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/14 14:21
 * @desc: //TODO
 */
@Component
public class PengInterceptor implements HandlerInterceptor {
    /**
     * 执行Handler方法之前执行
     * 用于身份认证、身份授权
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        // 获取请求的url
        String uri = request.getRequestURI();
        // 如果是登录，json请求。或者是去找回密码首页就放行
        if (uri.contains("login")
                ||uri.contains("json")
                ||uri.equals("/forgetPassword.action")
                ||uri.contains("register")
                ||uri.contains("portal")) {
            return true;
        }
        System.out.println("uri:"+uri);
        System.out.println("url:"+request.getRequestURL());
        // 判断session
        HttpSession session  = request.getSession();
        User userInfo= (User) session.getAttribute("userInfo");
        // 前台用户的session存在时，放行
        if (userInfo!=null) {
            return true;
        }
        //后台用户的session存在时，放行
        if (session.getAttribute("administrator")!=null){
            return true;
        }


        //拦截
        if (uri.contains("administrator")){
            request.getRequestDispatcher("/administrator/login.action").forward(request, response);
            return false;
        }
        // 执行这里表示用户身份需要认证，跳转登陆页面（这里填写登录请求）
        request.getRequestDispatcher("/login.action").forward(request, response);

        return false;
    }

    /**
     * 进入Handler方法之后，返回modelAndView之前执行
     * 应用场景从modelAndView出发：将公用的模型数据(比如菜单导航)在这里
     * 传到视图，也可以在这里统一指定视图
     */
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {

    }

    /**
     * 执行Handler完成后，执行此方法
     * 应用场景：统一异常处理，统一日志处理
     */
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {

    }
}
