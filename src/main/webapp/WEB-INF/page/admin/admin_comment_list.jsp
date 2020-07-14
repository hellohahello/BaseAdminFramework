<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>评论列表</title>
    <link href="/javaex/pc/css/icomoon.css" rel="stylesheet" />
    <!--动画-->
    <link href="/javaex/pc/css/animate.css" rel="stylesheet" />
    <!--骨架样式-->
    <link href="/javaex/pc/css/common.css" rel="stylesheet" />
    <!--皮肤（缇娜）-->
    <link href="/javaex/pc/css/skin/tina.css" rel="stylesheet" />
    <!--jquery，不可修改版本-->
    <script src="/javaex/pc/lib/jquery-1.7.2.min.js"></script>
    <!--全局动态修改-->
    <script src="/javaex/pc/js/common.js"></script>
    <!--核心组件-->
    <script src="/javaex/pc/js/javaex.min.js"></script>
    <!--表单验证-->
    <script src="/javaex/pc/js/javaex-formVerify.js"></script>
    <!--网站样式-->
    <link href="/assets/css/main.css" rel="stylesheet"/>
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

    <!--iframe载入内容开始-->
    <div class="admin-markdown">
        <!--主体内容-->
        <div class="list-content">
            <!--块元素-->
            <div class="block">
                <!--页面有多个表格时，可以用于标识表格-->
                <h2>评论管理</h2>
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
                            <button id="delete" class="button red radius-3"><span class="icon-close2"></span> 删除</button>
                        </div>
                    </div>
                    <table id="table" class="table color2">
                        <thead>
                        <tr>
                            <th class="checkbox"><input type="checkbox"  class="fill listen-1" /> </th>
                            <th>评论内容</th>
                            <th>评论出处</th>
                            <th>评论人</th>
                            <th>评论时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${pageInfo.list}" varStatus="status" var="entity">
                            <tr>
                                <td class="checkbox"><input type="checkbox" name="commentId" class="fill listen-1-2" value="${entity.commentId}" /> </td>
                                <td>${entity.content}</td>
                                <td>${entity.resourceName}</td>
                                <td><img style="max-width: 15%;max-height: 70px" src="${entity.avatar}"/>${entity.commentOwnName}</td>
                                <td>${entity.commentTimeStr}</td>
                                <td><button onclick="deleteOneComment(${entity.commentId})" class="button yellow">删除</button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%--iframe载入内容结束--%>
    </div>

</div>
</body>
<script type="text/javascript">

    //只删除一条评论
    function deleteOneComment(id) {
        $.ajax({
            url : "${pageContext.request.contextPath}/administrator/comment/delete.json",
            type : "POST",
            dataType : "json",
            data : {
                "ids" : id
            },
            success : function(rtn) {
                if (rtn.code=='000'){
                    javaex.optTip({
                        content : "删除成功",
                        type : "success"
                    });
                    setTimeout(
                        function () {
                        window.location.reload();
                    },1000)
                }
            },
            error : function(rtn) {

            }
        })
    }
    /**
     * 批量删除评论
     */
    $("#delete").click(function () {
        var ids= new Array();
        ids=[];
        $(':checkbox[name="commentId"]:checked').each(function() {
           if ($(this).val()!=''){
               ids.push($(this).val());
           }
        });
        if (ids.length==0){
            javaex.optTip({
                content : "至少选择一条记录进行删除",
                type : "error"
            });
            return;
        }
        $.ajax({
            url : "${pageContext.request.contextPath}/administrator/comment/delete.json",
            type : "POST",
            dataType : "json",
            traditional : "true",
            data : {
                "ids" : ids
            },
            success : function(rtn) {
                if (rtn.code=='000'){
                    javaex.optTip({
                        content : "删除成功",
                        type : "success"
                    });
                    setTimeout(
                        function () {
                            window.location.reload();
                        },1000)
                }
            },
            error : function(rtn) {

            }
        })

    })
</script>
</html>
