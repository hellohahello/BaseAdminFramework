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
    <h1><span class="admin-nav-name">总览</span></h1>
    <div id="admin-toc" class="admin-toc">
        <div class="menu-box">
            <div id="menu" class="menu">
                <ul>
                    <li >
                        <a href="/portal/user/home.action">我的主页</a>
                    </li>
                    <%--高亮显示  li: class="menu-item hover"--%>
                        <a href="/portal/resource/collection/list.action?userId=${sessionScope.user.userId}">收藏夹</a>
                            <li><a href="/portal/user/edit_resource.action">发布帖子</a></li>
                            <li><a href="/portal/user/resource_manger.action">帖子管理</a></li>
                            <li><a href="/portal/my/message/list.action">我的消息</a></li>

                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
