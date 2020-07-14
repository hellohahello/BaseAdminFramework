package com.framework.controller.admin;

import com.framework.entity.User;
import com.framework.service.UserService;
import com.framework.utils.MD5Util;
import com.framework.utils.Result;
import com.framework.utils.SendMail;
import com.framework.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @auther: 翁筱寒
 * @date: 2020/3/13 13:48
 * @desc: //密码相关
 */
@RequestMapping("forgetPassword")
@Controller
public class PassWordController {
    User findUserByEmail=null;
    String sendWho = "";
    @Autowired
    private UserService userService;

    /**
     * 忘记密码首页 1
     *
     * @return
     */
    @RequestMapping("")
    public String forgetPassword() {
        return "admin/forget_password/confirm_account";
    }



    /**
     * 输入邮箱页面验证邮箱是否存在
     *
     * @param email
     * @return
     */
    @RequestMapping("verify.json")
    @ResponseBody
    public Result verifyAccount(@RequestParam(value = "email") String email,
                HttpServletRequest request) {
        if (StringUtils.isEmpty(email)) {
            return Result.error("请输入邮箱");
        }
       findUserByEmail = userService.findByEmail(email);
        if (findUserByEmail == null) {
            return Result.error("该用户不存在");
        }
        HttpSession session = request.getSession();
        session.setAttribute("inputEmail",email);
        session.setAttribute("userInfo",findUserByEmail);
        return Result.success().add("email", findUserByEmail.getEmail());
    }
    /**
     * 验证身份页
     *
     * @return
     */
    @RequestMapping("verify.action")
    public String verify(Model model,
                         HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email= (String) session.getAttribute("inputEmail");
        //隐藏后的邮箱
        String hideEmail = StringUtil.maskEmail(email);
        model.addAttribute("hideEmail", hideEmail);
//            实际邮箱
        model.addAttribute("email", email);
        sendWho = email;
        return "admin/forget_password/verify_identity";
    }
    /**
     * 发送验证码
     *
     * @param request
     * @return
     * @throws MessagingException
     */
    @RequestMapping("verify/sendCode.json")
    @ResponseBody
    public Result sendCode(HttpServletRequest request) throws MessagingException {
        String code = StringUtil.getSixRandomNumber();
        request.getSession().setAttribute("code", code);
        SendMail.sendEmail("验证码", "您本次的验证码为" + code+",该验证码仅用于找回密码", sendWho);
        return Result.success();
    }

    /**
     * 校验验证码是否正确
     *
     * @param code
     * @param request
     * @return
     */
    @RequestMapping("verify/verifyCode.json")
    @ResponseBody
    public Result verifyCode(@RequestParam("code") String code, HttpServletRequest request) {
        String codeInfo = (String) request.getSession().getAttribute("code");
        if (!codeInfo.equals(code)) {
            return Result.error("验证码有误，请稍后再试");
        }
        if (code == "" || code == null) {
            return Result.error("请输入验证码！");
        }
        return Result.success();
    }

    /**
     * 跳转到重置密码页
     * @return
     */
    @RequestMapping("resetPassword.action")
    public String reset(Model model,HttpServletRequest request){
        User updateWho=null;
        if (findUserByEmail!=null){
            updateWho =findUserByEmail;
            model.addAttribute("emailInfo",updateWho.getEmail());
        }
        return "admin/forget_password/reset_password";
    }

    /**
     * 重置密码
     * @param newPassword
     * @param confirmNewPassWord
     * @param emailInfo
     * @return
     */
    @RequestMapping("resetPassword.json")
    @ResponseBody
    public Result resetPass(@RequestParam("newPassword")String newPassword,
                            @RequestParam("confirmNewPassWord")String confirmNewPassWord,
                            @RequestParam("emailInfo")String emailInfo,
                            Model model){
       if (!newPassword.equals(confirmNewPassWord)){
           return Result.error("两次密码输入不一致");
       }
        if (StringUtils.isEmpty(newPassword)||StringUtils.isEmpty(confirmNewPassWord)){
            return Result.error("必填项不能为空！！");
        }
       if (!findUserByEmail.getEmail().equals(emailInfo)){
           return Result.error("账号信息更新失败！请输入正确账号");
       }
       userService.updatePassword(MD5Util.md5(newPassword),emailInfo);
        model.addAttribute("newPass",newPassword);
        return Result.success();
    }
}
