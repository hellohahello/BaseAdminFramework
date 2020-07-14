<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/3/21
  Time: 22:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>帖子审核页面</title>
</head>
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
        <div class="list-content">
            <!--块元素-->
            <div class="block">
                <!--修饰块元素名称-->
                <div class="banner">
                    <p class="tab fixed">审核</p>
                </div>

                <!--正文内容-->
                <div class="main">
                    <form id="resource_form">
                        <%--帖子id--%>
                        <input type="hidden" name="resourceId" value="${resource.resourceId}">
                        <!--帖子名称文本框-->
                        <div class="unit clear">
                            <div class="left"><span class="required">*</span><p class="subtitle">帖子名称</p></div>
                            <div class="right">
                                <input type="text" class="text" data-type="必填" name="resourceName"  value="${resource.resourceName}" error-pos="42" placeholder="在这里输入名称" style="width: 450px" />
                            </div>
                        </div>
                        <!--下拉选择框-->
                        <div class="unit clear">
                            <div class="left"><p class="subtitle">帖子类型</p></div>
                            <div class="right">
                                <select id="select" name="resCategoryId">
                                    <c:forEach items="${resCategoryList}" var="entity" varStatus="status" >
                                        <option <c:if test="${resource.resCategoryId==entity.resCategoryId}">selected="selected"</c:if> value="${entity.resCategoryId}">${entity.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <%--百度云地址--%>
                        <div class="unit clear">
                            <div class="left">
                                <span class="required">*</span><p class="subtitle">百度云链接</p>
                            </div>
                            <div class="right">
                                <input type="text" class="text" name="download" value="${resource.download}" data-type="必填"  error-pos="42" placeholder="在这里输入链接地址" style="width: 450px" />
                                <span style="margin-left: 35px" >提取密码&nbsp;
                                 <input type="text" name="passWord" class="text" data-type="必填" value="${resource.passWord}"  error-pos="42" placeholder="在这里输入密码" style="width: 150px" />
                            </span>
                            </div>
                        </div>
                        <%--关键字--%>
                        <!--关键字文本框-->
                        <div class="unit clear">
                            <div class="left"><span class="required">*</span><p class="subtitle">关键字</p></div>
                            <div class="right">
                                <input type="text" name="keyword" value="${resource.keyword}" class="text" data-type="必填"  error-pos="42" placeholder="关键字用于检索" style="width: 380px" />
                            </div>
                        </div>
                        <%--富文本--%>
                        <div id="edit" class="edit-container">${(resource.content)}</div>
                        <input type="hidden" id="content"  name="content" value="" />
                        <input type="hidden" id="contentText" name="contentText" value="" />
                        <!--下拉选择框--积分-->
                        <div class="unit clear">
                            <div class="left"><p class="subtitle">下载需积分</p></div>
                            <div class="right">
                                <select id="points_select" name="points">
                                    <option <c:if test="${resource.points==0}">selected</c:if> value="0">免费</option>
                                    <option <c:if test="${resource.points==1}">selected</c:if> value="1">1积分</option>
                                    <option <c:if test="${resource.points==2}">selected</c:if>value="2">2积分</option>
                                    <option <c:if test="${resource.points==3}">selected</c:if> value="3">3积分</option>
                                </select>
                            </div>
                        </div>
                        <%--审核状态--%>
                        <input type="hidden" name="state" value="${resource.state}">
                        <!--提交按钮-->
                        <div class="unit clear" style="width: 800px;">
                            <div style="text-align: center;">
                                <!--表单提交时，必须是input元素，并指定type类型为button，否则ajax提交时，会返回error回调函数-->
                                <input type="button" onclick="back()" id="returnBack" class="button blue" value="返回" />
                                <input type="button" id="verifySuccess" class="button green" value="审核通过"  style="margin-left: 35px"/>
                                <input type="button" id="verifyDefeat" class="button red" value="驳回" style="margin-left: 35px" />
                            </div>
                        </div>

                            <!--文本域-->
                            <div class="unit clear">
                                <div class="left"><p class="subtitle">驳回原因</p></div>
                                <div class="right">
                                    <textarea class="desc" name="reason" placeholder="在这里输入不通过的原因"></textarea>
                                    <!--提示说明-->
                                    <p class="hint"><strong style="color: red">未通过审核时填写，是可选的</strong></p>
                                </div>
                            </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%--iframe载入内容结束--%>
</div>
</body>
<script>
    javaex.select({
        id : "select",
        isSearch : false
    });
    javaex.select({
        id : "points_select",
        isSearch : false
    });



    // 监听点击保存按钮事件
    $("#save").click(function() {
        // 表单验证函数
        if (javaexVerify()) {
            // 返回错误信息时，可以添加自定义异常提示。参数为元素id和提示
            // addErrorMsg("username", "用户名不存在");
            // 提交
            // $("#form").submit();
            alert("验证通过");
        }
    });

    // 监听点击返回按钮事件
    $("#return").click(function() {
        alert("返回");
        // window.location.href = document.referrer;
    });


//    富文本
    javaex.edit({
        id : "edit",
        image : {
            url : "${pageContext.request.contextPath}/upload.json",	// 请求路径
            param : "file",		// 参数名称，Spring中与MultipartFile的参数名保持一致
            dataType : "url",	// 返回的数据类型：base64 或 url
            isShowOptTip : true,	// 是否显示上传提示
            rtn : "rtnData",	// 后台返回的数据对象，在前台页面用该名字存储
            imgUrl : "data.imgUrl"	// 根据返回的数据对象，获取图片地址。  例如后台返回的数据为：{code: "000000", message: "操作成功！", data: {imgUrl: "/1.jpg"}}
        },
        isInit : true,
        callback : function(rtn) {
            $("#content").val(rtn.html);
            $("#contentText").val(rtn.text);
        }
    });
    function back() {
        history.back()
    }
//    审核通过
    $("#verifySuccess").click(function () {
        $.ajax({
            url : "/administrator/verify_success.json",
            type : "POST",
            dataType : "json",
            data : $("#resource_form").serialize(),
            success : function(rtn) {
            if (rtn.code=='000'){
                javaex.message({
                    content : "审核完毕，该帖子已通过",
                    type : "success"
                });
                setTimeout(function () {
                    window.location.href='/administrator/resource.action';
                },1000)
            }
            },
            error : function(rtn) {

            }
        });
    })
    //    审核失败时
    $("#verifyDefeat").click(function () {
        $.ajax({
            url : "/administrator/verify_defeat.json",
            type : "POST",
            dataType : "json",
            data : $("#resource_form").serialize(),
            success : function(rtn) {
                if (rtn.code=='000'){
                    javaex.message({
                        content : "审核完毕,该帖子已驳回",
                        type : "success"
                    });
                    setTimeout(function () {
                        window.location.href='/administrator/resource.action';
                    },1000)
                }
            },
            error : function(rtn) {

            }
        });
    })


</script>
</html>
