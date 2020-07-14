<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

    <title>左侧菜单</title>

</head>
<body>
    <h1><span class="admin-nav-name">总览</span></h1>
    <div id="admin-toc" class="admin-toc">
        <div class="menu-box">
            <div id="menu2" class="menu">
                <ul>
                    <li class="">
                        <a href="/administrator/category/list.action">分类管理</a>
                    </li>
                    <li class="">
                        <a href="/administrator/resource.action">帖子管理</a>
                    </li>
                    <li class="">
                        <a href="/administrator/user/list.action">用户管理</a>
                    </li>
                    <li class="">
                        <a href="/administrator/comment/list.action">评论管理</a>
                    </li>
                    <li class="">
                        <a href="/administrator/notice.action">公告内容</a>
                    </li>
                    <li class="menu-item">
                        <a href="javascript:;">个人中心<i class="icon-keyboard_arrow_left"></i></a>
                        <ul>
                            <li><a href="/portal/user/avatar.action">修改头像</a></li>
                            <li><a href="/portal/user/home.action">修改密码</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
</div>
</body>
<script>
    javaex.menu({
        id : "menu2",
        isAutoSelected : true
    });
</script>
</html>
