<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/3/13
  Time: 13:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>找回密码</title>
    <!--字体图标-->
    <link href="/javaex/pc/css/icomoon.css" rel="stylesheet" />
    <!--动画-->
    <link href="/javaex/pc/css/animate.css" rel="stylesheet" />
    <!--骨架样式-->
    <link href="/javaex/pc/css/common.css" rel="stylesheet" />
    <!--皮肤（缇娜）-->
    <link href="/javaex/pc/css/skin/tina.css" rel="stylesheet" />
    <!--jquery，不可修改版本-->
    <script src="/javaex/pc/lib/jquery-1.7.2.min.js"></script>
    <!--全局动态修改-->
    <script src="/javaex/pc/js/common.js"></script>
    <!--核心组件-->
    <script src="/javaex/pc/js/javaex.min.js"></script>
    <!--表单验证-->
    <script src="/javaex/pc/js/javaex-formVerify.js"></script>
    <!--网站样式-->
    <link href="/assets/css/main.css" rel="stylesheet" />
</head>

<body>
<div class="loginreg-title-con">
    <div class="loginreg-title-subcon">
        <a href="/" class="account-login right">首页</a>
        <div class="javaexLogo"><a href="/" class="javaexLogo-link"></a></div>
    </div>
</div>
<div class="login-step-con">
    <div class="step-container clear">
        <div class="security-step security-step1 active">
            <i class="icon-step icon-step1"><span class="txt-step">确认账号</span></i>
        </div>
        <div class="security-step security-step2">
            <i class="icon-step icon-step2"><span class="txt-step">验证身份</span></i>
        </div>
        <div class="security-step security-step3">
            <i class="icon-step icon-step3"><span class="txt-step">重置密码</span></i>
        </div>
    </div>

    <div class="loginreg-frame">
        <form id="form">
            <div class="loginreg-frame-top" style="margin-top: 40px;">
                <div class="loginreg-frame-ti">
                    <p id="loginreg-error-tip" class="errorInfo vh"></p>
                    <div class="info-container">
                        <span class="country-container">邮箱：</span>
                        <input id="emailid"  type="text" class="txt-info original" name="email" data-type="邮箱" error-tip-id="loginreg-error-tip" placeholder="请输入邮箱" error-msg="邮箱格式错误" value=""/>
                    </div>
                    <a href="#" onclick="accountVerify()"  class="btn-green btn-login">下一步</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script src="/assets/js/loginreg.js"></script>
<script>
    /**
     * 账号校验
     */
    function accountVerify() {
        var email=$("#emailid").val();
        $.ajax({
            url : "/forgetPassword/verify.json",
            type : "POST",
            dataType : "json",
            data : $("#form").serialize(),
            success : function(rtn) {
                if (rtn.code=="000") {
                    window.location.href = "/forgetPassword/verify.action";
                } else {
                    $("#loginreg-error-tip").text(rtn.message);
                    $("#loginreg-error-tip").removeClass("vh");
                }
            }
        });
    }
</script>
</html>
