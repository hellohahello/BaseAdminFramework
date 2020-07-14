<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/3/30
  Time: 23:33
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <!--字体图标-->
    <link href="/javaex/pc/css/icomoon.css" rel="stylesheet"/>
    <!--动画-->
    <link href="/javaex/pc/css/animate.css" rel="stylesheet"/>
    <!--骨架样式-->
    <link href="/javaex/pc/css/common.css" rel="stylesheet"/>
    <!--皮肤（缇娜）-->
    <link href="/javaex/pc/css/skin/tina.css" rel="stylesheet"/>
    <!--jquery-->
    <script src="/javaex/pc/lib/jquery-1.7.2.min.js"></script>
    <!--全局动态修改-->
    <script src="/javaex/pc/js/common.js"></script>
    <!--核心组件-->
    <script src="/javaex/pc/js/javaex.min.js"></script>
    <!--表单验证-->
    <script src="/javaex/pc/js/javaex-formVerify.js"></script>
    <!--网站样式-->
    <link href="/assets/css/main.css" rel="stylesheet"/>
    <title>用户管理</title>
</head>
<body>
<!--顶部导航-->
<div class="admin-navbar">
    <c:import url="header.jsp"></c:import>
</div>

<!--主题内容-->
<div class="admin-mian">
    <!--左侧菜单-->
    <div class="admin-aside admin-aside-fixed">
        <c:import url="left.jsp"></c:import>
    </div>

    <!--iframe载入内容-->
    <div class="admin-markdown">
        <!--主体内容-->
        <div class="list-content">
            <!--块元素-->
            <div class="block">
                <!--页面有多个表格时，可以用于标识表格-->
                <h2>标题</h2>
                <!--右上角的返回按钮-->
                <a href="javascript:history.back();">
                    <button class="button indigo radius-3" style="position: absolute;right: 20px;top: 16px;"><span class="icon-arrow_back"></span> 返回</button>
                </a>

                <!--正文内容-->
                <div class="main">
                    <!--表格上方的搜索操作-->
                    <div class="admin-search">
                        <div class="input-group">
                            <input type="text" class="text" placeholder="提示信息" />
                            <button class="button blue">搜索</button>
                        </div>
                    </div>

                    <!--表格上方的操作元素，添加、删除等-->
                    <div class="operation-wrap">
                        <div class="buttons-wrap">
                            <button class="button blue radius-3" onclick="goToRegister()"><span class="icon-plus"></span> 添加</button>
                            <button class="button red radius-3 disable"><span class="icon-close2"></span> 删除</button>
                        </div>
                    </div>
                    <table id="table" class="table color2">
                        <thead>
                        <tr>
                            <th class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
                            <th>用户名(昵称)</th>
                            <th>性别</th>
                            <th>邮箱</th>
                            <th>积分</th>
                            <th>最后登录时间</th>
                            <th>VIP用户</th>
                            <th>有违规</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                       <c:forEach var="entity" varStatus="status" items="${pageInfo.list}">
                           <tr>
                               <td class="checkbox"><input type="checkbox" class="fill listen-1-2" value="${entity.userId}" /> </td>
                               <td><img src="${entity.avatar}"style="width: 40px;max-height: 40px"/>${entity.userName}(${entity.nickname})</td>
                               <td>${entity.sex}</td>
                               <td>${entity.email}</td>
                               <td>${entity.points}</td>
                               <td>${entity.lastLoginTimeStr}</td>
                               <td>
                                   <!--开关样式需指定class为switch，如果你想改变大小，可以直接添加zoom属性--->
                                   <input type="checkbox" <c:if test="${entity.itsVip}">checked</c:if> class="switch" onchange="test(this,${entity.userId})"/>
                               </td>
                               <td> <!--开关样式需指定class为switch，如果你想改变大小，可以直接添加zoom属性--->
                                   <input type="checkbox" <c:if test="${entity.itsOff}">checked</c:if> class="switch" onchange="test2(this,${entity.userId})"/>
                               </td>
                               <td>
                                   <button onclick="roleSet(${entity.userId})" class="button green">角色设置</button>
                               </td>
                           </tr>
                       </c:forEach>
                        </tbody>
                    </table>
                    <%--分页start--%>
                    <div class="page">
                        <ul id="page" class="pagination"></ul>
                    </div>
                    <%--分页end--%>
                </div>
            </div>
        </div>
    </div>
    <%--至上一个div,iframe结束--%>

</div>
</body>
<script type="text/javascript">
    function goToRegister() {
     window.location.href='   ${pageContext.request.contextPath}/register.action';
    }
    function test(obj,userId) {
//        获取是否被选中的属性checked
        var checked=obj.checked;
//如果被选中，则设置该用户为vip用户，开关关掉则设置为非vip用户
       if (checked){
           $.ajax({
               url : "${pageContext.request.contextPath}/administrator/user/update_vip.json",
               type : "POST",
               dataType : "json",
               data : {
                   "userId" : userId,
                   "setToVip":"1"
               },
               success : function(rtn) {

               },

           });
       }
       //取消vip身份
       else {
           $.ajax({
               url : "${pageContext.request.contextPath}/administrator/user/update_vip.json",
               type : "POST",
               dataType : "json",
               data : {
                   "userId" : userId,
                   "setToVip":"0"
               },
               success : function(rtn) {

               },
           });
       }

    }

//更改违规状态
    function test2(obj,userId) {
//        获取是否被选中的属性checked
        var checked=obj.checked;
//如果被选中，则设置该用户被封禁（有违法行为），关掉则设置为正常用户
        if (checked){
            $.ajax({
                url : "${pageContext.request.contextPath}/administrator/user/update_off.json",
                type : "POST",
                dataType : "json",
                data : {
                    "userId" : userId,
                    "setToOff":"1"
                },
                success : function(rtn) {

                },
                error : function(rtn) {

                }
            });
        }
        //取消封禁
        else {
            $.ajax({
                url : "${pageContext.request.contextPath}/administrator/user/update_off.json",
                type : "POST",
                dataType : "json",
                data : {
                    "userId" : userId,
                    "setToOff":"0"
                },
                success : function(rtn) {

                },
                error : function(rtn) {

                }
            });
        }

    }

    /**
     * 改密码按钮
     */
    function roleSet(userId) {
        javaex.dialog({
            type : "dialog",	// 弹出层类型
            width : "400",
            height : "300",
            url : "role_set.action?userId="+userId
        });
    }


    javaex.page({
        id : "page",
        pageCount : ${pageInfo.pages},	// 总页数
        currentPage : ${pageInfo.pageNum},// 默认选中第几页
        totalNum : ${pageInfo.total},		// 总条数，不填时，不显示
        position : "right",
        callback : function(rtn) {
            window.location.href='${pageContext.request.contextPath}/administrator/user/list.action?pageNum='+rtn.pageNum
                +"&pageSize="+${pageSize};
        }
    });
</script>
</html>
