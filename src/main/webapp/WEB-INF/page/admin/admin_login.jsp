
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员登录</title>
    <!--字体图标-->
    <link href="/javaex/pc/css/icomoon.css" rel="stylesheet" />
    <!--动画-->
    <link href="/javaex/pc/css/animate.css" rel="stylesheet" />
    <!--骨架样式-->
    <link href="/javaex/pc/css/common.css" rel="stylesheet" />
    <!--皮肤（缇娜）-->
    <link href="/javaex/pc/css/skin/tina.css" rel="stylesheet" />
    <!--jquery-->
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
<style>
    .bg-wrap, body, html {height: 100%;}
    input{line-height: normal;-webkit-appearance: textfield;background-color: white;-webkit-rtl-ordering: logical;cursor: text;padding: 1px;border-width: 2px;border-style: inset;border-color: initial;border-image: initial;}
    input[type="text"], input[type="password"]{border: 0;outline: 0;}
    input, button{text-rendering: auto;color: initial;letter-spacing: normal;word-spacing: normal;text-transform: none;text-indent: 0px;text-shadow: none;display: inline-block;text-align: start;margin: 0em;font: 400 13.3333px Arial;}
    input[type=button]{-webkit-appearance: button;cursor: pointer;}
    .bg-wrap {position: relative;background: url(http://img.javaex.cn/FipOsQoe90u_7i3dOVpaeX5QD7c6) top left no-repeat;background-size: cover;overflow: hidden;}
    .main-cont-wrap{z-index: 1;position: absolute;top: 50%;left: 50%;margin-left: -190px;margin-top: -255px;box-sizing: border-box;width: 380px;padding: 30px 30px 40px;background: #fff;box-shadow: 0 20px 30px 0 rgba(63,63,65,.06);border-radius: 10px;}
    .form-title{margin-bottom: 40px;}
    .form-title>span{font-size: 20px;color: #2589ff;}
    .form-item{margin-bottom: 30px;position: relative;height: 40px;line-height: 40px;border-bottom: 1px solid #e3e3e3;box-sizing: border-box;}
    .form-txt{display: inline-block;width: 70px;color: #595961;font-size: 14px;margin-right: 10px;}
    .form-input{border: 0;outline: 0;font-size: 14px;color: #595961;width: 155px;}
    .form-btn{margin-top: 40px;}
    .ui-button{display: block;width: 320px;height: 50px;text-align: center;color: #fff;background: #2589ff;border-radius: 6px;font-size: 16px;border: 0;outline: 0;}
</style>

<div class="bg-wrap">
    <div class="main-cont-wrap login-model">
        <form id="administrator_form">
            <div class="form-title">
                <span>后台登录</span>
            </div>
            <div class="form-item">
                <span class="form-txt">用户名：</span>
                <input type="text" class="form-input original" id="user_name" name="userName" placeholder="请输入用户名" data-type="必填" error-pos="32" />
            </div>
            <div class="form-item">
                <span class="form-txt">密码：</span>
                <input type="passWord" class="form-input original" name="passWord" placeholder="请输入密码" data-type="必填" error-pos="32" />
            </div>
            <div class="form-btn">
                <input type="button" class="ui-button" id="login" value="登录" />
            </div>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
    $("#login").click(function () {
            if (javaexVerify()){
                $.ajax({
                    url : "/administrator/login.json",
                    type : "POST",
                    dataType : "json",
                    data : $("#administrator_form").serialize(),
                    success : function(rtn) {
                    if (rtn.code=='000'){
                        javaex.message({
                            content : rtn.message,
                            type : "success"
                        });
                        setTimeout(function() {
                            // 刷新页面
                            // window.location.reload();
                            // 跳转页面
                           window.location.href = "${pageContext.request.contextPath}/administrator/index.action";
                        }, 1000);
                    }else {
                        javaex.message({
                            content : rtn.message,
                            type : "error"
                        });
                    }
                    },
                    error : function(rtn) {
                        alert("登录失败");
                    }
                });
            }
    })
</script>
</html>
