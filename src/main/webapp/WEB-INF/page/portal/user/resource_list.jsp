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
    <title>Title</title>
</head>
<body>
<div class="input-group" style="margin-top: 35px;margin-left: 20px">
    帖子名称:&nbsp;&nbsp;&nbsp;<input type="text" class="text" placeholder="在这里输入帖子名称" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    审核状态&nbsp;&nbsp;&nbsp;<select id="select">
        <option value="">请选择</option>
        <option value="1">待审核</option>
        <option value="2">审核通过</option>
        <option value="3">审核未通过</option>
    </select>
    &nbsp;&nbsp;
    <input type="button" class="button blue" value="搜一下" />
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
            <button class="button indigo radius-3" style="position: absolute;right: 20px;top: 16px;"><span class="icon-arrow_back"></span> 返回</button>
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
                    <button  class="button yellow radius-3"><span class="icon-plus"></span> 新发布</button>
                    <button class="button red radius-3"><span class="icon-close2"></span> 删除</button>
                </div>
            </div>
            <table id="table" class="table color2">
                <thead>
                <tr>
                    <th class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
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
                        <td class="checkbox"><input  type="checkbox" class="fill listen-1-2" name="resourceId"  value="${entity.resourceId}"/> </td>
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
                            <button style="font-size: 10px" class="button blue"><span class="icon-edit-2"></span> 编辑</button>
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
</body>
</html>
<script type="text/javascript">
    <%--下拉框--%>
    javaex.select({
        id : "select",
        isSearch : false,
        // 回调函数
        callback: function (rtn) {
            console.log("selectValue:" + rtn.selectValue);
            console.log("selectName:" + rtn.selectName);
        }
    });
//    分页
    var pageSize='${pageSize}';
    var pageNum='${pageNum}';
    var total='${total}';
    console.log("total:"+total)
    javaex.page({
        id : "page",
        pageCount : 12,	// 总页数
        currentPage : 1,// 默认选中第几页

        totalNum : total,		// 总条数，不填时，不显示
        position : "right",
        callback : function(rtn) {
            console.log("当前选中的页数：" + pageNum);
            console.log("每页显示条数：" + pageSize);
        }
    });
    //跳转到新发布页面
    function goToAdd() {
        window.location.href='/portal/user/edit_resource.action';
    }
</script>
