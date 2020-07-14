<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>收藏列表</title>
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
    <style type="text/css">
        a:hover { color: #0c7cb5; text-decoration: underline; }/* 鼠标移动到链接上 */
    </style>
</head>
<body>
<%--顶部导航--%>
<div class="admin-navbar">
    <c:import url="../header.jsp"></c:import>
</div>

<!--内容区域-->
<!--主题内容-->
<div class="admin-mian">
    <!--左侧菜单-->
    <c:import url="left.jsp"/>
    <%--表格start--%>
    <!--主体内容-->
    <!--内容区域-->
    <div class="list-content">
        <table id="table">
       <tbody>
       <c:forEach items="${collectionList}" var="entity" varStatus="status">
        <tr>

                <!--块元素-->
                <div class="block" style="border: dashed white;width: 1000px; margin-left: 0px">
                    <!--banner用来修饰块元素的名称-->

                    <!--正文内容-->
                    <div class="main">
                        <input type="checkbox" name="collectionId" class="fill listen-1-2" value="${entity.collectionId}" />
                            <span class="icon-favorite" style="color: red"></span>
                            <a style="margin-left: 50px" href="/portal/detail.action?resourceId=${entity.resourceId}">${entity.resourceName}
                            </a>
                        &nbsp;&nbsp;&nbsp;<font color="#808080">${entity.collectionTimeStr}</font>
                    </div>
                </div>
        </tr>
       </c:forEach>
       </tbody>
        </table>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <input  type="checkbox" class="fill listen-1" />全选
        <button class="button gray" id="delete" style="height: 35px;margin-left: 50px">删除选中收藏</button>
    </div>

</div>
</body>
<script type="text/javascript">
    var ids=new Array();
    $("#delete").click(function () {
        ids=[];
        $(":checked[name='collectionId']").each(function () {
            if ($(this).val() != '') {
                ids.push($(this).val());
            }
        });
        //如果一条也没选中
        if (ids.length==0){
            javaex.message({
                content : "至少选择一条来删除",
                type : "error"
            });
            return false;
        };
        var userId='${sessionScope.user.userId}';
        console.log("用户id："+userId);
        $.ajax({
            url : "${pageContext.request.contextPath}/portal/resource/collection/delete.json",
            type : "POST",
            dataType : "json",
            traditional:true,
            data : {
                "idArr" : ids,
                "userId" : userId
            },
            success : function(rtn) {
                if (rtn.code=='000'){
                    javaex.message({
                        content : "已删除",
                        type : "success"
                    });

                    setTimeout(function () {
                        window.location.reload()
                    }),2000
                }
            },
            error : function(rtn) {

            }
        });
    })
</script>
</html>
