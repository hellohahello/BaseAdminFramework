<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>

    <title>Title</title>
</head>
<body>
<!--左侧菜单-->
<div class="admin-aside admin-aside-fixed">
    <h1><span class="admin-nav-name"><strong>个人中心</strong></span></h1>
    <div id="admin-toc" class="admin-toc">
        <div class="menu-box">
            <div id="menu" class="menu">
                <ul>
                    <li >
                        <a href="/portal/user/home.action">个人主页</a>
                    </li>
                        <li>
                            <a href="/portal/user/avatar.action">我的头像</a>
                        </li>
                            <li>
                                <a href="#">账号安全</a>
                            </li>

                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
