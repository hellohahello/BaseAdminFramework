<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/4/8
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>无标题文档</title>
    <!--字体图标-->
    <link href="/javaex/pc/css/icomoon.css" rel="stylesheet"/>
    <!--动画-->
    <link href="/javaex/pc/css/animate.css" rel="stylesheet"/>
    <!--骨架样式-->
    <link href="/javaex/pc/css/common.css" rel="stylesheet"/>
    <!--皮肤（缇娜）-->
    <link href="/javaex/pc/css/skin/tina.css" rel="stylesheet"/>
    <!--jquery，不可修改版本-->
    <script src="/javaex/pc/lib/jquery-1.7.2.min.js"></script>
    <!--全局动态修改-->
    <script src="/javaex/pc/js/common.js"></script>
    <!--核心组件-->
    <script src="/javaex/pc/js/javaex.min.js"></script>
    <!--表单验证-->
    <script src="/javaex/pc/js/javaex-formVerify.js"></script>
</head>
<style>
    body{background-color: #fff;}
    .login-form{background: #fff;margin:40px;}
    .login-title{font-size: 20px;text-align: center;margin-bottom: 25px;}
    .login-item{display: flex;margin-bottom: 14px;}
    .login-link{margin-bottom: 14px;}
    .login-link label, .login-link a{color: #9B9B9C;}
    .login-link a{font-size: 14px;}
    .login-text{min-height: 40px;width: 100%;color: #B3B3B3;font-size: 14px;border: 1px solid #EEEFF0;border-radius: 3px;font-family: Helvetica, "microsoft yahei", sans-serif;padding-left: 16px;outline: none;}
    .button.login{background-color: #2D9C8B;color: white;width: 100%;border-radius: 3px;font-size: 14px;height: 40px;line-height: 40px;}
    .login-link .line{display: inline-block;width: 1px;height: 12px;background-color: #EEEEEE;margin: 0 6px;}
</style>
<body>
<!--登录-->
<div class="login-form">
    <form id="form222">
        <!--标题-->
        <div class="login-title">重置密码</div>
        <!--用户名-->
        <div class="login-item">
            <input type="text" class="login-text" id="oldPassword" name="oldPassword" data-type="必填" placeholder="旧密码" />
        </div>
        <!--密码-->
        <div class="login-item">
            <input type="password" class="login-text" name="newPassword" data-type="必填" placeholder="新密码" />
        </div>
        <!--登录按钮-->
        <div class="login-item">
            <input type="button" id="submit" class="button login" value="修改" />
        </div>
        <!--底部链接-->
        <div class="login-link">

        </div>
    </form>
</div>
</body>
<script>
    // 监听点击保存按钮事件
    $("#submit").click(function() {

        // 表单验证函数
        if (javaexVerify()) {
            $.ajax({
                url : "update_password.json",
                type : "POST",
                dataType : "json",
                data : $("#form222").serialize(),
                success : function(rtn) {
                    if (rtn.code=='000'){
                        javaex.optTip({
                            content : "操作成功",
                            type : "success"
                        });
                        // 建议延迟加载
                        setTimeout(function() {
                            // 刷新页面
                             parent.location.reload();
                            // 跳转页面
                            // window.location.href = "${pageContext.request.contextPath}/zone_info/list.action";
                        }, 1000);

                    }
                    else {
                        javaex.optTip({
                            content : rtn.message,
                            type : "error"
                        });
                        return false;
                    }
                    },
                error : function(rtn) {
                    javaex.optTip({
                        content : rtn.message,
                        type : "error"
                    });
                }
            });
        }
        else {
            return false;
        }
    });
</script>
</html>