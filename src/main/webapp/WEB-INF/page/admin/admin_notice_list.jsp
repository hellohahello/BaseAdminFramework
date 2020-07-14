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
                <h2>首页公告栏内容</h2>
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
                            <button id="add" class="button disable empty"><span class="icon-plus"></span> 添加</button>
                            <button id="delete" class="button disable empty"><span class="icon-close2"></span> 删除</button>
                            <button id="save" class="button green"><span class="icon-check2"></span> 保存</button>
                        </div>
                    </div>
                    <table id="noticeTable" class="table color2">
                        <thead>
                        <tr>
                            <th class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
                            <th>公告内容</th>
                        </tr>
                        </thead>
                        <tbody>

                            <tr>
                                <td class="checkbox"><input name="noticeId" id="noticeId" type="checkbox" class="fill listen-1-2" value="${notice.id}" /> </td>
                                <td><input type="text" class="text" id="noticeContent" name="content" data-type="必填"  placeholder="在这里输入公告的内容" value="${notice.content}"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

</div>
</body>
<script type="text/javascript">



    $("#save").click(function () {
        //    点击保存按钮
        var noticeId='${notice.id}';
        var content=$("#noticeContent").val();
        if (javaexVerify()) {
            $.ajax({
                url : "savenotice.json",
                type : "POST",
                dataType : "json",
                traditional : "true",
                data : {
                    "id" : noticeId,
                    "content" : content
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
