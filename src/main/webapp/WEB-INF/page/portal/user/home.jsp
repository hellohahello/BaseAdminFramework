<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>个人中心</title>
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
<body>
<%--顶部导航--%>
<div class="admin-navbar">
    <c:import url="../header.jsp"></c:import>
</div>

<div class="admin-mian">
    <!--左侧菜单-->
    <c:import url="user_center_left.jsp"/>
    <%--表格start--%>
    <!--主体内容-->
    <!--内容区域-->
    <div class="list-content">
        <table id="table">
            <tbody>
                <tr>

                    <!--块元素-->
                    <div class="block" style="border: dashed white;width: 1000px; margin-left: 0px">
                        <!--banner用来修饰块元素的名称-->
                        <!--正文内容-->
                        <div class="main">
                            <img src="${user.avatar}" style="width: 110px;height: 110px;margin-left: 400px">
                           <br/>
                            <button class="button blue" style="margin-left: 850px"><span class="icon-edit-2"></span> 编辑</button>
                           <br/>
                            <font style="margin-left: 410px" color="orange">${user.userName}<font color="red">【${user.roleName}】</font></font>
                            <br/>
                            <br/>
                            <font style="margin-left: 380px"> <font color="teal">注册于：</font>${user.registerTimeStr}</font>
                        </div>
                    </div>
                </tr>

                <tr>
                  <td width="60%">
                      <!--块元素-->
                      <div class="block">
                          <!--banner用来修饰块元素的名称-->
                          <div class="banner">
                              <p class="tab fixed" style="font-size: 20px;color: red">账号安全</p>
                          </div>
                          <!--正文内容-->
                          <div class="main">
                              <span class="icon-vpn_key" style="font-size:60px;color:deepskyblue;"></span>
                              <font style="font-size: 20px;position: absolute;top: 75px;left: 90px;">我的密码</font>
                              <br/>
                              <br/>
                              <c:if test="${! empty user.passWord}">
                                  <font style="margin-left: 5px" color="#ff4500">已设置</font>
                              </c:if>
                              <a href="#" onclick="updatePassword()">
                                  <font style="margin-left: 160px" color="#00bfff">更改密码></font>
                              </a>
                          </div>
                      </div>
                  </td>
                </tr>
            </tbody>
        </table>
        </div>

</div>
</body>
<script type="text/javascript">
    function updatePassword(){
        javaex.dialog({
            type : "dialog",	// 弹出层类型
            width : "400",
            height : "300",
            url : "update_password.action"
        });
    }
</script>
</html>
