<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/4/3
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>消息列表</title>
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
        a:hover {
            color: #0c7cb5;
            text-decoration: underline;
        }

        /* 鼠标移动到链接上 */
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
            <c:if test="${ empty pageInfo.list}">
                <tr>
                    <!--块元素-->
                    <div class="block" style="border: dashed white;width: 1000px; margin-left: 0px">
                        <!--banner用来修饰块元素的名称-->

                        <!--正文内容-->
                        <div class="main">

                            &nbsp;
                            <font style="margin-left: 480px" color="#ff4500">暂无新消息</font>
                        </div>
                    </div>
                </tr>
            </c:if>
            <c:forEach var="entity" items="${pageInfo.list}">
                <tr>
                    <!--块元素-->
                    <div class="block" style="border: dashed white;width: 1000px; margin-left: 0px">
                        <!--banner用来修饰块元素的名称-->

                        <!--正文内容-->
                        <div class="main">
                            <input type="checkbox" name="messageId" class="fill listen-1-2" value="${entity.messageId}"/>
                            <c:choose>
                                <c:when test="${entity.itsAlready}">
                                    <span class="icon-at-sign" style="color: green">
                                        已读
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="icon-at-sign" style="color: red">
                                        未读
                                    </span>

                                </c:otherwise>
                            </c:choose>
                            </span>
                            <font style="background-color: lightslategrey">
                                    ${entity.createTimeStr}
                            </font>
                            &nbsp;
                            【<font color="#00bfff">${entity.messageTitle}</font>】
                            &nbsp;
                            <font>${entity.messageContent}</font>
                        </div>
                    </div>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="checkbox" class="fill listen-1"/>全选
        <button class="button gray" id="allAlreadyRead" onclick="read()" style="height: 35px;margin-left: 50px">一键已读
        </button>
        <button class="button red" id="deleteSelected" style="height: 35px;margin-left: 50px">删除所选</button>
    </div>

</div>
</body>
<script type="text/javascript">
    function read() {
        setTimeout(function () {
            window.location.reload()
        }, 1000)
    }

    /**
     * 删除消息
     */
    var idArr=new Array();
    $("#deleteSelected").click(function () {
    idArr=[];
    $(':checked[name="messageId"]').each(function () {
        if ($(this).val()!=''){
            idArr.push($(this).val());
        }
    })
        if (idArr.length==0){
            javaex.optTip({
                content : "至少选择一条",
                type : "error"
            });
            return false;
        }

        javaex.optTip({
            content : "数据提交中，请稍候...",
            type : "submit"
        });

        $.ajax({
            url : "deleteMsg.json",
            type : "POST",
            traditional:true,
            dataType : "json",
            data : {
                "idArr" : idArr
            },
            success : function(rtn) {
                if (rtn.code=='000'){
                    javaex.optTip({
                        content : "已删除",
                        type : "success"
                    });
                    setTimeout(function () {
                        window.location.reload()
                    },2000)
                }else {
                    javaex.optTip({
                        content : rtn.message,
                        type : "error"
                    });
                }
            },
            error : function(rtn) {

            }
        });
    })
</script>
</html>
