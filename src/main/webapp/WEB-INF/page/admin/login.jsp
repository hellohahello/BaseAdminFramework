<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户登录</title>
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
    <style>
        .loginreg-frame {
            margin-top: 40px;
            padding-top:0;
            height: 420px;
        }
        .loginreg-frame-ti {
            width: 360px;
            margin: 0 auto;
            height: 366px;
        }
    </style>
</head>

<body>
<div class="loginreg-title-con">
    <div class="loginreg-title-subcon">
        <a href="/portal/index.action" class="account-login right">首页</a>

    </div>
</div>
<div class="login-step-con">
    <div class="loginreg-frame">
        <form id="login_form">
            <div class="loginreg-frame-top">
                <div class="loginreg-frame-ti">
                    <h2 class="login-title">登录</h2>
                    <p id="loginreg-error-tip" class="errorInfo vh"></p>
                    <div class="info-container">
                        <span class="country-container">用户名：</span>
                        <input type="text" class="txt-info original" id="userName" name="userName" data-type="必填"   placeholder="请输入用户名"/>
                    </div>
                    <div class="info-container">
                        <span class="country-container">密码：</span>
                        <input type="password" class="txt-info original" id="passWord" name="passWord" placeholder="请输入密码" autocomplete="off"/>
                    </div>
                    <div class="forget-pwd right">
                        <a href="/forgetPassword.action" target="_blank" style="margin-left: 300px">忘记密码</a>
                    </div>

                    <a href="javascript:;" id="login" onclick="doLogin()" class="btn-green btn-login">登录</a>
                </div>
            </div>
        </form>
        <div class="loginreg-frame-bottom">
            <p class="loginreg-frame-ln">
                <a href="/register.action" class="left">注册</a>
                <span class="right"><a href="/login/other" style="margin-left: 300px">其他方式登录</a></span>
            </p>
        </div>
    </div>
</div>
</body>
<script src="/assets/js/loginreg.js"></script>
<script>
   function doLogin() {
       $.ajax({
           url : "/login.json",
           type : "POST",
           dataType : "json",
           data : $("#login_form").serialize(),
           success : function(rtn) {
        if (rtn.code=='000'){
            javaex.optTip({
                content : "登录成功，跳转中...",
                type : "success"
            });
            // 建议延迟加载
            setTimeout(function() {
                // 刷新页面
//                 window.location.reload();
                // 跳转页面
               window.location.href = "${pageContext.request.contextPath}/portal/index.action";

            }, 2000);
        }
        else {
            javaex.optTip({
                content : rtn.message,
                type : "error"
            });
        }
           },
           error : function(rtn) {

           }
       });
   }
</script>
</html>
