
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="admin-container-fluid clear">
    <!--logo名称-->
    <div class="admin-logo">天地是舞台...</div>

    <!--导航-->
    <ul class="admin-navbar-nav fl" id="typeIdHead">
        <li>
            <a href="/portal/index.action"><font size="4">首页</font></a>
        </li>
    </ul>

    <!--右侧-->

    <ul class="admin-navbar-nav fr">
        <li>
            <c:choose>
                <c:when test="${empty  sessionScope.user}">
                    <a href="javascript:;" style="margin-top: 24px" onclick="toLogin()"><i class="icon-tag_faces" style="font-size: 16px">登录/注册</i></a>
                </c:when>
                <c:otherwise>
                    <c:if test="${sessionScope.user.itsVip==true}"><strong style="color: red">vip${sessionScope.user.vipGrade}</strong>&nbsp;&nbsp;</c:if>
                    <span>
                            ${sessionScope.user.userName}&nbsp;
                                <a id="imgHref" href="javascript:;">
                                    <img id="headImg" src="${sessionScope.user.avatar}" style="width:50px;height: 45px;margin-top: 12px">
                                </a>

                    </span>
                    <%--如果是会员，头像右下角显示会员图标--%>
                    <%--如果是会员，头像右下角显示会员图标伴随会员等级--%>
                    <%--end--%>
                    <ul class="dropdown-menu" >
                        <li>
                            <a href="/portal/user/home.action"><i class="icon-cog2" style="font-size: 20px"></i>个人主页</a></li>
                        <li>
                            <a href="/portal/my/message/list.action">
                                <i class="icon-comment-o" style="font-size: 20px">

                                </i>
                                我的消息
                                <c:if test="${sessionScope.messageCount>0}">
                                    <sup>[</sup><sup style="color:orangered">${sessionScope.messageCount}</sup><sup>]</sup>
                                </c:if>
                            </a>
                        </li>
                        <li><a href="/portal/user/resource_manger.action"><i class="icon-fire"  style="font-size: 20px"></i>帖子管理</a></li>
                        <hr>
                        <c:if test="${sessionScope.user.itsVip==false}">  <li><a href="/portal/vip.action"><i class="icon-star_border" style="font-size: 20px"></i>开通VIP</a></li></c:if>
                        <li><a href="#" onclick="loginout()"><i class="icon-close2" style="font-size: 20px"></i>退出</a></li>
                    </ul>

                </c:otherwise>
                <%--登录前显示登陆注册，登陆后有更多的功能，所以下拉菜单更多--%>
            </c:choose>
        </li>
        <c:if test="${! empty sessionScope.user}">
            <li>
                <span style="margin-left: 2px">积分：<font color="#adff2f">${sessionScope.user.points}</font></span>
            </li>
        </c:if>
        <li>
            <a href="javascript:QQLogin();" style="margin-left: 5px;font-size: 20px;margin-top: 22px">
                <i class="icon-qq"></i>
            </a>
        </li>
    </ul>
</div>
</body>
<script type="text/javascript">
<%--页面一加载，就请求分类数据--%>
    $(function () {
        $.ajax({
            url : "${pageContext.request.contextPath}/portal/category_list.json",
            type : "POST",
            dataType : "json",
            data : {
            },
            success : function(rtn) {
                if (rtn.code=='000'){
                    var categoryList=rtn.data.categoryList;
                    var html='';
                    for (var i=0;i<categoryList.length;i++){
                        html+='<li class="active" ><a target="_blank" href="/portal/type.action?resCategoryId='+categoryList[i].resCategoryId+'&pageNum=1&pageSize=1"><font size="4">'+categoryList[i].categoryName+'</font></a></li>';
                    }
                }
                //html+='<li><a href="">后台</a></li>';
                $("#typeIdHead").append(html);

            },
            error : function(rtn) {

            }
        });

    })



    function QQLogin() {
        javaex.optTip({
            content : "接口申请中，暂时无法登录，请谅解！",
            type : "error"
        });
        return;
    }
    function toLogin() {

        var href='/login.action';
        window.location.href=href;
    }

    function loginout() {
        var email='${sessionScope.user.email}';
        $.ajax({
            url : "${pageContext.request.contextPath}/loginout.json",
            type : "POST",
            dataType : "json",
            data : {
                "email" : email
            },
            success : function(rtn) {
                if (rtn.code=='000'){
                    javaex.optTip({
                        content : "已退出",
                        type : "success"
                    });
                    // 建议延迟加载
                    setTimeout(function() {
                        // 刷新页面
//                        window.location.reload();
                        // 跳转页面
                         window.location.href = "${pageContext.request.contextPath}/login.action";
                    }, 1000);
                }
            },
            error : function(rtn) {

            }
        });
    }

</script>
</html>
