<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>后台帖子列表</title>
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

    <!--iframe载入内容-->
    <div class="admin-markdown">
        <div class="input-group" style="margin-top: 35px;margin-left: 20px">
            帖子名称:&nbsp;&nbsp;&nbsp;<input type="text" class="text" id="keyword" value="${keyword}"
                                          placeholder="在这里输入帖子名称"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            审核状态&nbsp;&nbsp;&nbsp;<select id="select">
            <option value="">请选择</option>
            <option value="0">待审核</option>
            <option value="1">审核通过</option>
            <option value="2">审核未通过</option>
        </select>
            &nbsp;&nbsp;
            <input type="button" id="searchBTN" onclick="search()" class="button blue" value="搜一下"/>
        </div>
        <%--表格start--%>
        <div class="list-content">
            <!--块元素-->
            <div class="block">
                <!--页面有多个表格时，可以用于标识表格-->
                <h2>标题</h2>
                <!--右上角的返回按钮-->
                <a href="javascript:history.back();">
                    <button class="button indigo radius-3" style="position: absolute;right: 20px;top: 16px;"><span
                            class="icon-arrow_back"></span> 返回
                    </button>
                </a>

                <!--正文内容-->
                <div class="main">
                    <!--表格上方的搜索操作-->
                    <%--<div class="admin-search">--%>
                    <%--<div class="input-group">--%>
                    <%--<input type="text" class="text" placeholder="提示信息" />--%>
                    <%--<button class="button blue">搜索</button>--%>
                    <%--</div>--%>
                    <%--</div>--%>

                    <!--表格上方的操作元素，添加、删除等-->
                    <div class="operation-wrap">
                        <div class="buttons-wrap">
                            <button class="button disable empty"><span class="icon-plus"></span> 添加</button>
                            <button id="deleteBtn" class="button red radius-3"><span class="icon-close2"></span> 删除
                            </button>
                        </div>
                    </div>
                    <table id="table" class="table color2">
                        <thead>
                        <tr>
                            <th class="checkbox"><input type="checkbox" class="fill listen-1"/> </th>
                            <th>帖子名称</th>
                            <th>所属分类</th>
                            <th>发布人</th>
                            <th>发布时间</th>
                            <th>所需积分</th>
                            <th>审核状态</th>
                            <th>是否热门？</th>
                            <th>是否免费？</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach varStatus="status" var="entity" items="${pageInfo.list}">
                            <tr>
                                <td class="checkbox"><input type="checkbox" name="resourceId" class="fill listen-1-2"
                                                            value="${entity.resourceId}"/> </td>
                                <td>${entity.resourceName}</td>
                                <td>${entity.categoryName}</td>
                                <td>${entity.userName}</td>
                                <td>${entity.createTimeStr}</td>
                                <td>${entity.points}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${entity.state=='0'}">
                                            <a href="#"> <font color="blue"> 待审核</font></a>
                                        </c:when>
                                        <c:when test="${entity.state=='1'}">
                                            <a href="#"><font color="#7cfc00"> 审核通过</font></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#"> <font color="#8b0000"> 审核未通过</font></a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>


                                <td>
                                    <!--开关样式需指定class为switch，如果你想改变大小，可以直接添加zoom属性--->
                                    <input type="checkbox" <c:if test="${entity.itsHot}">checked</c:if> class="switch" onchange="testHot(this,${entity.resourceId})"/>
                                </td>
                                <td> <!--开关样式需指定class为switch，如果你想改变大小，可以直接添加zoom属性--->
                                    <input type="checkbox" <c:if test="${entity.itsFree}">checked</c:if> class="switch" onchange="testFree(this,${entity.resourceId})"/>
                                </td>
                                <td>
                                    <a href="/administrator/resource_verify.action?resourceId=${entity.resourceId}">
                                        <button class="button blue"><i class="icon-fullscreen">审核</i></button>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <%--分页--%>
                    <div class="page">
                        <ul id="page" class="pagination"></ul>
                    </div>

                </div>
            </div>
        </div>
        <%--表格end--%>
    </div>

</div>

</body>
</html>
<script type="text/javascript">
    var totalNum = '${pageInfo.total}';
    javaex.page({
        id: "page",
        pageCount: ${pageInfo.pages},	// 总页数
        currentPage: ${pageNum},// 默认选中第几页
        totalNum: totalNum,		// 总条数，不填时，不显示
        position: "right",
        callback: function (rtn) {
            search(rtn)
        }
    });
    <%--下拉框--%>
    javaex.select({
        id: "select",
        isSearch: false,
        // 回调函数
        callback: function (rtn) {

        }
    });

    //删除帖子
    var idArr = new Array();
    $("#deleteBtn").click(function () {
        idArr = [];
        $(':checkbox[name="resourceId"]:checked').each(function () {
            if ($(this).val() != '') {
                idArr.push($(this).val());
            }
        });
        if (idArr.length == 0) {
            javaex.optTip({
                content: "至少选择一条记录进行删除",
                type: "error"
            });
            return false;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/administrator/resource/delete.json",
            type: "POST",
            dataType: "json",
            traditional: "true",
            data: {
                "idArr": idArr
            },
            success: function (rtn) {
                if (rtn.code == '000') {
                    javaex.optTip({
                        content: "删除成功",
                        type: "success"
                    });
                    setTimeout(
                        function () {
                            window.location.reload();
                        }, 1000)
                } else {
                    javaex.optTip({
                        content: rtn.message,
                        type: "error"
                    });
                    return;
                }
            },
            error: function (rtn) {

            }
        })
    })

    function search(rtn) {
        var keyword = $("#keyword").val();
        var state = $("#select").val();
        if (rtn == undefined) {
            rtn = 1;
            window.location.href = '/administrator/resource.action?pageNum=' + rtn
                + "&pageSize=${pageSize}"
                + "&keyword=" + keyword
                + "&state=" + state;
        }else {
            window.location.href = '/administrator/resource.action?pageNum=' + rtn.pageNum
                + "&pageSize=${pageSize}"
                + "&keyword=" + keyword
                + "&state=" + state;
        }

    }

//    开关 ---是否热门
    function testHot(obj,resourceId) {
        //被选中，则是设置为热门
        if (obj.checked){
            $.ajax({
                url : "${pageContext.request.contextPath}/administrator/resource/setHot.json",
                type : "POST",
                dataType : "json",
                data : {
                    "resourceId" : resourceId,
                    "setHot" : "1"
                },
                success : function(rtn) {

                },
                error : function(rtn) {

                }
            });
        }else {
            $.ajax({
                url : "${pageContext.request.contextPath}/administrator/resource/setHot.json",
                type : "POST",
                dataType : "json",
                data : {
                    "resourceId" : resourceId,
                    "setHot" : "0"
                },
                success : function(rtn) {

                },
                error : function(rtn) {

                }
            });
        }
    }

//开关 ---是否免费
    function testFree(obj,resourceId) {
        if (obj.checked){
            $.ajax({
                url : "${pageContext.request.contextPath}/administrator/resource/setFree.json",
                type : "POST",
                dataType : "json",
                data : {
                    "resourceId" : resourceId,
                    "setFree": "1"
                },
                success : function(rtn) {
                },
                error : function(rtn) {
                }
            });
        }
else {
            $.ajax({
                url : "${pageContext.request.contextPath}/administrator/resource/setFree.json",
                type : "POST",
                dataType : "json",
                data : {
                    "resourceId" : resourceId,
                    "setFree": "0"
                },
                success : function(rtn) {

                },
                error : function(rtn) {

                }
            });
        }

    }
</script>
