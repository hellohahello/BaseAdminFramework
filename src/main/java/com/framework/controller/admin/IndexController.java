package com.framework.controller.admin;

import com.framework.entity.User;
import com.framework.service.MessageService;
import com.framework.service.UserService;
import com.framework.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Date;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/12 14:15
 * @desc: //TODO
 */
@Controller

public class IndexController {
    @Autowired
    MessageService messageService;
    @Autowired
    private UserService userService;

    /**
     * 转到注册页
     * @return
     */
    @RequestMapping("register.action")
    public String register(){
        return "admin/register";
    }

    /**
     * 注册功能
     * @param user  表单的参数
     * @param cpacha  验证码
     * @return
     */
    @RequestMapping("save.json")
    @ResponseBody
    public Result save(User user,@RequestParam("cpacha")String cpacha,
                       HttpServletRequest request){
        //session中取出发送的验证码
        String code = (String) request.getSession().getAttribute("registerVerifyCode");
//       如果验证码输入不对
        if (!code.equals(cpacha)){
            return Result.error("验证码有误，请重新输入");
        }
        //密码长度不能小于5位数

        if (user.getPassWord().length()<5||user.getPassWord().length()>15){
            return Result.error("密码长度须在5-15位之间");
        }
//        注册时送30个积分
        user.setPoints(30);
        int zeroOrOne = userService.save(user);
        if (zeroOrOne==1){
            return Result.error("该邮箱已被注册");
        }
        //用户名也要唯一
        //逻辑与邮箱一样，数据库这里设置了唯一约束
            //注册成功
        return Result.success();
    }

    /**
     * 注册用的验证码
     * @param email
     * @param request
     * @return
     */
    @RequestMapping("sendCodeForRegister.json")
    @ResponseBody
    public Result sendCodeForRegister(@RequestParam("email")String email,
                                      HttpServletRequest request) {
        if (StringUtils.isEmpty(email)){
            return Result.error("邮箱不能为空");
        }
        if (userService.findByEmail(email)!=null){
            return Result.error("该邮箱已被注册,请重新输入...");
        }
        String randomNumber = StringUtil.getSixRandomNumber();
//        把验证码存到session中
        request.getSession().setAttribute("registerVerifyCode",randomNumber);
        try {
            SendMail.sendEmail("用户注册","您本次注册的验证码为："+randomNumber,email);
        } catch (MessagingException e) {
          e.printStackTrace();
            return Result.error("验证码发送失败，请联系管理员");
        }
        return Result.success();
    }
    /**
     * 转到登录页
     * @return
     */
    @RequestMapping("login.action")
    public String login(@RequestParam(value = "returnUrl",required = false)String returnUrl ){
        return "admin/login";
    }

    /**
     *
     * @param codeNumber  验证码个数（几个字符），一般4个即可
     * @param codeWidth   生成图片的宽度
     * @param codeHeight   图片高度
     */
    @RequestMapping("get_cpacha.action")
    public void getCpacha(@RequestParam(value = "codeNumber",defaultValue = "4",required = false)int codeNumber,
                          @RequestParam(value = "codeWidth",defaultValue = "100",required = false)int codeWidth,
                          @RequestParam(value = "codeHeight",defaultValue = "30",required = false)int codeHeight,
                          HttpServletRequest request,
                          HttpServletResponse response){
        //设置验证码的属性
        CpachaUtil cpachaUtil=new CpachaUtil(codeNumber,codeWidth,codeHeight);
//        生成验证码
        String checkCode = cpachaUtil.generatorVCode();
//        存入到session
        request.getSession().setAttribute("checkCode",checkCode);
//        获得旋转字体有干扰线的验证码图片
        BufferedImage bufferedImage = cpachaUtil.generatorRotateVCodeImage(checkCode, true);
        try {
            //图片渲染到前端
            ImageIO.write(bufferedImage,"gif",response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * //登录。不需要验证码。
     * @param userName
     * @param passWord
     * @param cpacha  不用验证码，所以此处cpacha参数设置为false
     * @param request
     * @return
     */
    @RequestMapping("login.json")
    @ResponseBody
    public Result login(  @RequestParam(value = "returnUrl",required = false)String returnUrl,
                        @RequestParam("userName")String userName,
                        @RequestParam("passWord")String passWord,
                        @RequestParam(value = "cpacha",required = false)String cpacha,
                            HttpServletRequest request){
        //是否为空
        if (StringUtils.isEmpty(userName)
                ||StringUtils.isEmpty(passWord)){
            return Result.error("必填项不能为空");
        }
        User user = userService.findByUserNameAndPassword(userName, MD5Util.md5(passWord));
        if (user==null){
            return Result.error("用户名或密码错误");
        }
        if (user.isItsOff()){
            return Result.error("该账号已被封禁,请联系管理员解封后再试");
        }
        //未读消息数
        int messageCount=messageService.getCountByUserId(user.getUserId());
        request.getSession().setAttribute("messageCount",messageCount);
        request.getSession().setAttribute("user",user);
        //更新最后登录时间
        userService.updateLoginTime(new Date(),String.valueOf(user.getUserId()));  //更新最后登录时间
        userService.save(user);
        //登陆成功
        return Result.success();
    }

    /**
     * 退出登录
     * @param email
     * @param request
     * @return
     */
    @RequestMapping("loginout.json")
    @ResponseBody
    public Result logout(@RequestParam("email")String email,HttpServletRequest request){
        request.getSession().invalidate();
        return Result.success();
    }
}
