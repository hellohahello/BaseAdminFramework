<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>首页</title>
</head>
<body>

<%--顶部导航--%>
<div class="admin-navbar">
    <c:import url="../header.jsp"></c:import>
</div>

<!--主题内容-->
<div class="admin-mian">
    <!--左侧菜单-->
    <c:import url="left.jsp"/>
    <!--iframe载入内容-->
    <div class="input-group" style="margin-top: 35px;margin-left: 20px">
        帖子名称:&nbsp;&nbsp;&nbsp;<input type="text" onkeydown="if(event.keyCode==13){
            sou()
        }" id="keyword" value="${keyword}" class="text" placeholder="在这里输入帖子名称"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


        <input id="searchB" onclick="sou()" type="button" class="button blue" value="搜一下"/>
    </div>
    <%--表格start--%>
    <!--主体内容-->
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
                <div class="admin-search">
                    <%--<div class="input-group">--%>
                    <%--<input type="text" class="text" placeholder="提示信息" />--%>
                    <%--<button class="button blue">搜索</button>--%>
                    <%--</div>--%>
                </div>

                <!--表格上方的操作元素，添加、删除等-->
                <div class="operation-wrap">
                    <div class="buttons-wrap">
                        <button onclick="goToAdd()" class="button yellow radius-3"><span class="icon-plus"></span> 新发布
                        </button>
                        <button id="deleteBtn" class="button red radius-3"><span class="icon-close2"></span> 删除</button>
                    </div>
                </div>
                <table id="table" class="table color2">
                    <thead>
                    <tr>
                        <th class="checkbox"><input type="checkbox" class="fill listen-1"/> </th>
                        <th>帖子名称</th>
                        <th>所属分类</th>
                        <th>积分</th>
                        <th>发布时间</th>
                        <th>审核状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${pageInfo.list}" var="entity" varStatus="status">
                        <tr>
                            <td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="resourceId"
                                                        value="${entity.resourceId}"/> </td>
                            <td>${entity.resourceName}</td>
                            <td>${entity.categoryName}</td>
                            <td>${entity.points}</td>
                            <td>${entity.createTimeStr}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${entity.state==0}">
                                        <font color="orange"><strong>待审核</strong></font>
                                    </c:when>
                                    <c:when test="${entity.state==1}">
                                        <font color="green"><strong>审核通过</strong></font>
                                    </c:when>
                                    <c:otherwise>

                                    <span tip="驳回原因：${entity.reason}">
                                         <font color="#8b0000">审核未通过</font>

                                    </span>
                                    </c:otherwise>
                                </c:choose>

                            </td>
                            <td style="width: 130px">
                                <a href="/portal/user/edit_resource.action?resourceId=${entity.resourceId}">
                                    <button style="font-size: 10px" class="button blue"><span
                                            class="icon-edit-2"></span> 编辑
                                    </button>
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
    <%--表格END--%>
</div>
</body>
<script type="text/javascript">

    //    分页
    var pageNum = '${pageNum}';
    var total = '${total}';
    var pages = '${pageInfo.pages}';
    javaex.page({
        id: "page",
        pageCount: pages,	// 总页数
        currentPage: pageNum,// 默认选中第几页

        totalNum: total,		// 总条数，不填时，不显示
        position: "right",
        callback: function (rtn) {
//            sou(rtn)
        }
    });

    function sou(rtn) {
        var keyword = $("#keyword").val();
        var categoryId = $("#category_id").val();
        if (rtn == undefined) {
            rtn = 1;
            window.location.href = '${pageContext.request.contextPath}/portal/user/resource_manger.action?pageNum='
                + rtn
                + "&pageSize=" + ${pageInfo.pageSize}
                + "&keyword=" + keyword;
              +"&categoryId=" + categoryId;
        }
       else {
            window.location.href = '${pageContext.request.contextPath}/portal/user/resource_manger.action?pageNum='
                + rtn.pageNum
                + "&pageSize=" + ${pageInfo.pageSize}
                + "&keyword=" + keyword;
            +"&categoryId=" + categoryId;
        }
    }

    var hightUrl = "xxxx";
    javaex.menu({
        id: "menu",
        isAutoSelected: true,
        key: "",
        url: hightUrl
    });

    $(function () {
        // 设置左侧菜单高度
        setMenuHeight();
    });

    /**
     * 设置左侧菜单高度
     */
    function setMenuHeight() {
        var height = document.documentElement.clientHeight - $("#admin-toc").offset().top;
        height = height - 10;
        $("#admin-toc").css("height", height + "px");
    }

    // 控制页面载入
    function page(url) {
        $("#page").attr("src", url);
    }

    //一开始就加载iframe页面
    $(function () {
        var url = '/portal/user/resource_list.action';
        page(url)
    })

    function goToAdd() {
        window.location.href = '/portal/user/edit_resource.action';
    }

    //    删除帖子
    $("#deleteBtn").click(function () {
        var idArray = new Array();
        idArray = [];
        $(":checked[name='resourceId']").each(function () {
            if ($(this).val() != '') {
                idArray.push($(this).val());
            }
        });
//        如果没选中任何记录
        if (idArray.length == 0) {
            alert("至少选择一条记录噢亲~")
            return false;
        }
        ;
//        ajax提交
        //如果array不为空，把idArr传到后台处理
        console.log(idArray)
        $.ajax({
            url: "/portal/user/delete.json",
            type: "POST",
            dataType: "json",
            traditional: true,
            data: {
                "idArray": idArray
            },
            success: function (res) {
                if (res.code == "000") {
                    javaex.optTip({
                        content: "已删除，将为你重新加载数据",
                        type: "success"
                    });
                    // 建议延迟加载
                    setTimeout(function () {
                        // 刷新页面
                        window.location.reload();
                        // 跳转页面
                        //
                    }, 1000);
                }
            },
            error: function (res) {

            }
        });
//        ajax结束
    })
</script>
</html>
