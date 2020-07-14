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
    <!--jquery，不可修改版本-->
    <script src="/javaex/pc/lib/jquery-1.7.2.min.js"></script>
    <!--全局动态修改-->
    <script src="/javaex/pc/js/common.js"></script>
    <!--核心组件-->
    <script src="/javaex/pc/js/javaex.min.js"></script>
    <!--表单验证-->
    <script src="/javaex/pc/js/javaex-formVerify.js"></script>
    <title>首页</title>
    <style type="text/css">
        a:hover{
            color: deepskyblue;
        }

    </style>
</head>
<body>
<!--顶部导航-->
<div class="admin-navbar">
    <c:import url="header.jsp"></c:import>
</div>

<!--主题内容-->
<div class="admin-mian">
    <!--iframe载入内容-->
    <div class="admin-markdown">

        <%--宣言--%>
        <font color="#663399" style="position:absolute;left: 22px;top: 20px">${notice.content}</font>

        <%--搜索框start--%>
        <div class="input-group">
                <input type="text" id="searchContent"   class="text" placeholder="输入标题以检索" onkeydown="if (event.keyCode==13){doSearch(this.value)}"  style="width:350px;margin-left: 710px;margin-top: 60px" />
                <input type="button" id="searchBtn" class="button blue" value="搜索" />
            </div>
                <%--搜索框end--%>

            <%--帖子正文--%>
            <div class="list-content" style="position:absolute; left:0px; top:38px;width: 900px ">

                <c:forEach varStatus="status" items="${pageInfo.list}" var="entity">
                    <%--块元素--%>
                    <div class="block">
                        <div>
                            <span>
                               <a href="/portal/type.action?resCategoryId=${entity.resCategoryId}"> <font color="green">[${entity.categoryName}] &nbsp;</font></a>
                                <a href="/portal/detail.action?resourceId=${entity.resourceId}"><font color="#00bfff" size="3"> ${entity.resourceName}<c:if test="${entity.click gt 50}"><span class="icon-fire" style="color: red"></span></c:if></font></a>
                            </span>
                        </div>
                           <div>
                               <br/>
                               <span>作者：<font color="#ff4500">${entity.userName}</font></span>
                               <span style="margin-left: 35px">日期：${entity.createTimeStr}</span>
                               <span style="margin-left: 400px" class="icon-eye">${entity.click}</span>

                           </div>
                           <br>
                </div>
                </c:forEach>
                <div class="page">
                    <ul id="page" class="pagination"></ul>
                </div>

            </div>
        <%--正文end--%>

            <!--右侧主题等  start-->
            <div class="list-content" style="width: 450px;margin-left: 710px;margin-top: 25px">
                <!--块元素-->
                <%--新主题--%>
                <div class="block">
                    <div class="banner">
                        <p style="color: darkgoldenrod" class="tab fixed">新主题&nbsp;<font color="red">【new~】</font></p>
                    </div>
                    <br>
                    <div class="main">
                        <ul>
                        <c:forEach items="${lastList}" varStatus="status" var="entity">
                            <li>
                                <a href="/portal/detail.action?resourceId=${entity.resourceId}" target="_blank">
                                    <font color="#1e90ff">${entity.resourceName}</font>
                                </a>
                                <a href="#" style="float: right"><font>${entity.userName}</font></a>
                            </li>
                            <br/>
                        </c:forEach>
                        </ul>
                    </div>
                </div>
                <%--新回复--%>
                <div class="block">
                    <div class="banner">
                        <p class="tab fixed"><font color="orange">新回复<span style="color: green"  class="icon-comments"></span></font></p>
                    </div>
                    <div class="main">
                        <ul>
                            <c:forEach items="${listByCommentTimeDesc}" var="entity">
                                <li>
                                    <a href="/portal/detail.action?resourceId=${entity.resourceId}" target="_blank">
                                        <font color="#1e90ff">${entity.resourceName}</font>
                                    </a>
                                    <a href="#" style="float: right"><font>${entity.commentTimeStr}</font></a>
                                </li>
                                <br/>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <%--热门--%>
                <div class="block">
                    <div class="banner">
                        <p class="tab fixed"><font color="red">热门帖</font><span class="icon-fire"></span></p>
                    </div>
                    <div class="main">
                        <ul id="listByCommentTimeDesc">
                            <c:forEach items="${listByClick}" var="entity">
                                <li>
                                    <a href="/portal/detail.action?resourceId=${entity.resourceId}" target="_blank">
                                        <font color="#1e90ff">${entity.resourceName}</font>
                                    </a>
                                    <a href="#" style="float: right"><font>${entity.userName}</font></a>
                                </li>
                                <br/>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <%--右侧主题等  end--%>
    </div>
</div>

</body>
<script type="text/javascript">
    var pageCount="${pageInfo.pages}";
    var total="${pageInfo.total}";
    var pageNum="${pageInfo.pageNum}";

    javaex.page({
        id : "page",
        pageCount : pageCount,	// 总页数
        currentPage : pageNum,// 默认选中第几页
        totalNum : total,		// 总条数，不填时，不显示
        position : "right",
        callback : function(rtn) {
            window.location.href="/portal/index.action?pageNum="+rtn.pageNum+"&pageSize=${pageInfo.pageSize}";
        }
    });

    $("#searchBtn").click(function () {
        doSearch($("#searchContent").val());
        console.log($("#searchContent").val());
    })
//    搜索
   function  doSearch(keyWord){
// 判断关键字是否为空
       keyWord = keyWord.replace(/(^\s*)|(\s*$)/g, "");
       if (keyWord!="") {
           window.location.href = "${pageContext.request.contextPath}/portal/search.action?keyWord="+keyWord;
       }
    }
</script>
</html>
