<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/3/21
  Time: 21:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="admin-container-fluid clear">
    <!--logo名称-->
    <div class="admin-logo">后台管理</div>

    <!--导航-->
    <ul class="admin-navbar-nav fl">
        <li class="active"><a href="/administrator/index.action">总览</a></li>
        <li><a href="/portal/index.action">首页</a></li>
    </ul>

    <!--右侧-->
    <ul class="admin-navbar-nav fr">
        <li>
            <a href="javascript:;">${sessionScope.administrator.roleName}：
                ${sessionScope.administrator.userName}
                &nbsp;&nbsp;<font color="#7cfc00">已登录</font>
            </a>
            <ul class="dropdown-menu" style="right: 10px;">
                <li><a href="javascript:loginout()">退出当前账号</a></li>
            </ul>
        </li>
    </ul>
</div>
</body>
<script type="text/javascript">
    function loginout() {
        $.ajax({
            url : "${pageContext.request.contextPath}/administrator/loginout.json",
            type : "POST",
            dataType : "json",
            data : {

            },
            success : function(rtn) {
            if (rtn.code=='000'){
                javaex.optTip({
                    content : "已退出",
                    type : "success"
                });
                // 延迟加载
                setTimeout(function() {
                     window.location.href = "${pageContext.request.contextPath}/administrator/login.action";
                }, 1000);
            }
            },
            error : function(rtn) {

            }
        });
    }
</script>
</html>
