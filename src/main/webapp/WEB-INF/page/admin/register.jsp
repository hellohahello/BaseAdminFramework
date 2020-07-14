<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/3/14
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
    <title>用户注册</title>
</head>
<body>
<!--全部主体内容-->
<div class="list-content">
    <!--块元素-->
    <div class="block">
        <!--修饰块元素名称-->
        <div class="banner">
            <p class="tab fixed"><a href="/portal/index.action">首页</a></p>
        </div>

        <!--正文内容-->
        <div class="main">
            <form id="form" style="margin-left: 370px">
                <!--文本框-->
                <div class="unit clear">
                    <div class="left"><span class="required">*</span><p class="subtitle">用户名</p></div>
                    <div class="right">
                        <input   style="width: 400px" type="text" class="text" name="userName" data-type="必填"  error-pos="42" placeholder="请输入用户名" />
                    </div>
                </div>

                <!--密码框-->
                <div class="unit clear" style="margin-top: 50px">
                    <div class="left"><span class="required">*</span><p class="subtitle">密码</p></div>
                    <div class="right">
                        <input   style="width: 400px" type="password" class="text" name="passWord" data-type="必填"  error-pos="42" placeholder="请输入密码" />
                    </div>
                </div>

                <!--昵称-->
                <div class="unit clear" style="margin-top: 50px">
                    <div class="left"><span class="required">*</span><p class="subtitle">昵称</p></div>
                    <div class="right">
                        <input   style="width: 400px" type="text" class="text" name="nickname" data-type="必填"  error-pos="42" placeholder="请输入昵称" />
                    </div>
                </div>

                <!--邮箱-->
                <div class="unit clear" style="margin-top: 50px">
                    <div class="left"><span class="required">*</span><p class="subtitle">邮箱</p></div>
                    <div class="right">
                        <input   style="width: 400px" type="text" class="text" id="email" name="email" data-type="邮箱" error-msg="邮箱格式错误"  error-pos="42" placeholder="请输入邮箱" />
                    </div>
                </div>
                <%--获取验证码按钮--%>
                    <span>
                        <a id="aid" href="#" style="margin-left: 520px;color: #0a628f" onclick="getCode()">获取验证码</a>
                    </span>

                <!--单选框-->
                <div class="unit clear" style="margin-top: 20px">
                    <div class="left"><p class="subtitle">性别</p></div>
                    <div class="right">
                        <ul class="equal-8 clear">
                            <li><input type="radio" class="fill" name="sex" value="男" checked/>男</li>
                            <li><input type="radio" class="fill" name="sex" value="女" />女</li>
                        </ul>
                    </div>
                </div>

                <!--验证码-->
                <div class="unit clear" style="margin-top: 20px">
                    <div class="left"><span class="required">*</span><p class="subtitle">验证码</p></div>
                    <div class="right">
                        <input   style="width: 400px" type="text" class="text" id="cpacha" name="cpacha" data-type="必填"  error-pos="42" placeholder="请输入邮箱收到的验证码" />
                    </div>
                </div>
                <!--提交按钮-->
                <div class="unit clear" style="width: 800px;">
                    <div style="text-align: center;  margin-right: 300px">
                        <!--表单提交时，必须是input元素，并指定type类型为button，否则ajax提交时，会返回error回调函数-->
                        <input type="button" onclick="goLogin()" id="login" class="button yellow"  value="账号密码登录"/>
                        <input type="button" id="register" class="button yes" value="注册" />
                        <input type="button"  class="button green" id="other" value="其他方式登录"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
   /*
   * 转到登录页
   * */
    function goLogin() {
        window.location.href='/login.action';
    }
    javaex.select({
        id : "select",
        isSearch : false
    });


    // 监听点击注册按钮事件
    $("#register").click(function() {
        // 表单验证函数
        if (javaexVerify()) {
            $.ajax({
                url : "save.json",
                type : "POST",
                dataType : "json",
                data : $("#form").serialize(),
                success : function(res) {
                if (res.code=='000'){
                    javaex.optTip({
                        content : "注册成功",
                        type : "success"
                    });
                    // 建议延迟加载
                    setTimeout(function() {
                        // 刷新页面
                        // window.location.reload();
                        // 跳转到登录页面
                        window.location.href = "${pageContext.request.contextPath}/login.action";
                    }, 2000);
                }
                else {
                    javaex.optTip({
                        content : res.message,
                        type : "error"
                    });
                }
                },
                error : function(res) {

                }
            });
        }
    });
    /**
     * 验证码倒计时
     * @type {boolean}
     */
    var flag=true;
    var index=40;
    function getCode() {

        if (index>0){
            index--;
            $("#aid").text("请"+index+"秒后再试");
            $("#aid").css("cursor","default")
            $("#aid").removeAttr("href");
            $("#aid").removeAttr("onclick");
//            向后台请求验证码   ajax
            if (flag){
                flag=false;
                $.ajax({
                    url : "/sendCodeForRegister.json",
                    type : "POST",
                    dataType : "json",
                    data : $("#form").serialize(),
                    success : function(res) {
                        if (res.code=='000'){
                            javaex.optTip({
                                content : "验证码已发出",
                                type : "success"
                            });
                        }
                        else {
                            javaex.optTip({
                                content : res.message,
                                type : "error"
                            });
                        }
                    },
                    error : function(res) {

                    }
                });
//                ajax结束
            }

                setTimeout(function () {
                    getCode();
                },1000);
        }

       else if(index==0) {
            index=40;
            $("#aid").text("获取验证码");
            $("#aid").css("cursor","pointer");
            $("#aid").attr("onclick","getCode()");
            $("#aid").attr("href","#");
            flag=true;
            return;
        }
    }
</script>
</body>
</html>
