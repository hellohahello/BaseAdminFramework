<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/3/26
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    <title>${keyWord}--检索</title>
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
            <%--搜索框start--%>
            <div class="input-group">
                <input type="text" id="searchContent"  class="text" value="${keyWord}" placeholder="提示信息" onkeydown="if (event.keyCode==13){doSearch(this.value)}"  style="margin-left: 800px;margin-top: 40px" />
                <input type="button" id="searchBtn" class="button blue" value="搜索" />
            </div>

        <%--前台正文--%>
        <!--主体内容-->
        <div class="list-content" style="position:absolute; left:0px; top:40px;width: auto ">
            <!--块元素-->
            <!--正文内容-->
            <c:forEach varStatus="status" items="${pageInfo.list}" var="entity">
                <div class="block">

                    <div>
                            <span>
                               <a href="/portal/type.action?resCategoryId=${entity.resCategoryId}"> <font color="green">[${entity.categoryName}] &nbsp;</font></a>
                                <a href="/portal/detail.action?resourceId=${entity.resourceId}"><font color="blue" size="3">
                                   ${entity.resourceName}

                                    <c:if test="${entity.click gt 50}">
                                        <span class="icon-fire" style="color: red">

                                    </span>
                                    </c:if>
                                </font>
                                </a>
                            </span>
                    </div>
                    <div>
                        <br/>
                        <span>作者：${entity.userName}</span>
                        <span style="margin-left: 35px">日期：${entity.createTimeStr}</span>
                        <span style="margin-left: 500px" class="icon-eye">${entity.click}</span>

                    </div>
                    <br>
                </div>
            </c:forEach>
            <%--分页start--%>
            <div class="page">
                <ul id="page" class="pagination"></ul>
            </div>
            <%--分页end--%>
        </div>
        <%--正文end--%>
    </div>
</div>
</body>
</html>
<script>
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
            window.location.href="/portal/search.action?keyWord=${keyWord}&pageNum="+rtn.pageNum+"&pageSize=${pageInfo.pageSize}";
        }
    });
    //    页面一加载，就向后台请求类型数据
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
                        html+='<span class="active" style="margin-left: 30px;"><a target="_blank" href="/portal/type.action?resCategoryId='+categoryList[i].resCategoryId+'&pageNum=1&pageSize=1"><font size="4">'+categoryList[i].categoryName+'</font></a></span>';
                    }
                }
                $("#typeId").append(html);

            },
            error : function(rtn) {

            }
        });

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
