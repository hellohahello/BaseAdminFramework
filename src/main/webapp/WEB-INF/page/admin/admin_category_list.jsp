<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/4/3
  Time: 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
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
    <title>分类列表</title>
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

                        </div>
                    </div>

                    <!--表格上方的操作元素，添加、删除等-->
                    <div class="operation-wrap">
                        <div class="buttons-wrap">
                            <button id="add" class="button blue"><span class="icon-plus"></span> 添加</button>
                            <button id="delete" class="button red"><span class="icon-close2"></span> 删除</button>
                            <button id="save" class="button green"><span class="icon-check2"></span> 保存</button>
                        </div>
                    </div>
                    <table id="table" class="table color2">
                        <thead>
                        <tr>
                            <th class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
                            <th>序号</th>
                            <th>分类名称</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach varStatus="status" items="${categoryList}" var="entity">
                            <tr>
                                <td class="checkbox"><input name="resCategoryId" type="checkbox" class="fill listen-1-2" value="${entity.resCategoryId}" /> </td>
                                <td><input type="text" class="text" name="sort"  data-type="正整数" error-msg="必须是正整数" placeholder="请输入序号" value="${entity.sort}" /></td>
                                <td><input type="text" class="text" name="categoryName" data-type="必填"  placeholder="请输入名称" value="${entity.categoryName}" /></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

</div>
</body>
<script type="text/javascript">
    <%--点击添加按钮--%>
    $("#add").click(function () {
        var html='';
        html+=' <tr>';
        html+='<td class="checkbox"><input name="resCategoryId" type="checkbox" class="fill listen-1-2" value="${entity.resCategoryId}" /> </td>';
        html+='<td><input type="text" class="text" name="sort"  data-type="正整数" error-msg="必须是正整数" placeholder="请输入序号" value="${entity.sort}" /></td>';
        html+='<td><input type="text" class="text" name="categoryName" data-type="必填" placeholder="请输入名称" value="${entity.categoryName}" /></td>';
        html+=' </tr>';
        $("#table tbody").append(html);
//        重新渲染
        javaex.render()
    })

//    点击保存按钮
    var idArr=new Array();
    var sortArr=new Array();
    var nameArr=new Array();
    $("#save").click(function () {
        if (javaexVerify()) {
            idArr = [];
            sortArr = [];
            nameArr = [];

            // id
            $(':checkbox[name="resCategoryId"]').each(function() {
                idArr.push($(this).val());
            });

            // sort
            $('input[name="sort"]').each(function() {
                sortArr.push($(this).val());
            });

            // name
            $('input[name="categoryName"]').each(function() {
                nameArr.push($(this).val());
            });

            $.ajax({
                url : "save.json",
                type : "POST",
                dataType : "json",
                traditional : "true",
                data : {
                    "idArr" : idArr,
                    "sortArr" : sortArr,
                    "nameArr" : nameArr
                },
                success : function(rtn) {
                    if (rtn.code=="000") {
                        javaex.optTip({
                            content : rtn.message,
                            type : "success"
                        });
                        // 建议延迟加载
                        setTimeout(function() {
                            // 刷新页面
                            window.location.reload();
                        }, 2000);
                    } else {
                        javaex.optTip({
                            content : rtn.message,
                            type : "error"
                        });
                    }
                }
            });
        }
    })
    // 点击删除按钮事件
    $("#delete").click(function() {
        idArr = [];
        // 1.0 遍历所有被勾选的复选框
        $(':checkbox[name="resCategoryId"]:checked').each(function() {
            // 2.0 添加主键存在的记录
            var resCategoryId = $(this).val();
            if (resCategoryId!="") {
                idArr.push(resCategoryId);
            }
        });

        // 判断所勾选的是不是新增的空白记录
        if (idArr.length==0) {
            $(':checkbox[name="resCategoryId"]:checked').each(function() {
                // 前台无刷新去除新增的tr
                $(this).parent().parent().parent().remove();
            });
        } else {
            $.ajax({
                url : "delete.json",
                type : "POST",
                dataType : "json",
                traditional : "true",
                data : {
                    "idArr" : idArr
                },
                success : function(rtn) {
                    if (rtn.code=="000") {
                        javaex.optTip({
                            content : rtn.message,
                            type:"success"
                        });
                        // 建议延迟加载
                        setTimeout(function() {
                            // 刷新页面
                            window.location.reload();
                        }, 2000);
                    } else {
                        javaex.optTip({
                            content : rtn.message,
                            type : "error"
                        });
                    }
                }
            });
        }
    });
</script>
</html>
