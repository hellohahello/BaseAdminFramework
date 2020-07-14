<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>编辑影视帖子《新发表或编辑已有的》</title>
</head>
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
<body>
<%--顶部导航--%>
<div class="admin-navbar">
<c:import url="../header.jsp"></c:import>
</div>
<!--主题内容-->
<div class="admin-mian">
<%--左侧菜单--%>
    <c:import url="left.jsp"></c:import>
    <!--iframe载入内容-->
    <!--全部主体内容-->
    <div class="list-content">
        <!--块元素-->
        <div class="block">
            <!--修饰块元素名称-->
            <div class="banner">
                <p class="tab fixed">发布</p>
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

                        <%--封面图--%>

                        <div class="unit clear">
                            <div class="left"><p class="subtitle">封面</p></div>
                            <div class="right">
                                <div id="container" class="file-container">
                                    <div class="cover">
                                        <!--如果不需要回显图片，src留空即可-->

                                        <c:if test="${! empty resource.cover}"> <img class="upload-img-cover" src="${resource.cover}"/> </c:if>
                                        <img class="upload-img-cover" src=""/>
                                        <%--
                                        //测试图片的地址
                                        https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=2656050137,2027935258&fm=58&bpow=802&bpoh=1203
                                        --%>
                                        <input type="file" class="file" id="upload" accept="image/gif, image/jpeg, image/jpg, image/png" />
                                            <%--隐藏---封面内容--%>
                                            <input type="hidden" id="cover" name="cover" value="${resource.cover}">
                                    </div>
                                </div>
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
                            <input type="button" id="returnBtn" class="button no" value="返回" />
                            <input type="button" id="save" class="button yes" value="保存" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<
<script type="text/javascript">
    var hightUrl = "xxxx";
    javaex.menu({
        id : "menu",
        isAutoSelected : true,
        key : "",
        url : hightUrl
    });

    $(function() {
        // 设置左侧菜单高度
        setMenuHeight();
    });

    /**
     * 设置左侧菜单高度
     */
    function setMenuHeight() {
        var height = document.documentElement.clientHeight - $("#admin-toc").offset().top;
        height = height - 10;
        $("#admin-toc").css("height", height+"px");
    }

    // 控制页面载入
    function page(url) {
        $("#page").attr("src", url);
    }

//    //一开始就加载iframe页面
//    $(function () {
//        var url='/portal/user/edit_resource.action';
//        page(url)
//    })
    javaex.select({
        id : "select",
        isSearch : false
    });
    javaex.select({
        id : "points_select",
        isSearch : false
    });

    javaex.upload({
        type : "image",
        url : "${pageContext.request.contextPath}/upload.json",	// 请求路径
        id : "upload",			// <input type="file" />的id
        containerId : "container",	// 容器id
        param : "file",			// 参数名称，Spring中与MultipartFile的参数名保持一致
        dataType : "url",		// 返回的数据类型：base64 或 url
        callback : function (rtn) {
            if (rtn.code==000){
                var imgUrl = rtn.data.imgUrl;
                console.log(imgUrl)
                $("#container img").attr("src",imgUrl);
                $("#cover").val(imgUrl);

            }else {
                javaex.optTip({
                    content : rtn.message,
                    type : "error"
                });
            }
        }
    });

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
//    点击保存时
    $("#save").click(function () {
        if (javaexVerify()){
            $.ajax({
                url : "/portal/user/save.json",
                type : "POST",
                dataType : "json",
                data : $("#resource_form").serialize(),
                success : function(rtn) {
                if (rtn.code=='000'){
                    javaex.optTip({
                        content : "操作成功~",
                        type : "success"
                    });
                    // 建议延迟加载
                    setTimeout(function() {
                        // 刷新页面
                        // window.location.reload();
                        // 跳转页面
//                        javaex.optTip({
//                            content : "操作成功",
//                            type : "success"
//                        });
                         window.location.href = "/portal/user/resource_manger.action";
                    }, 1000);
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
        }
    })
//返回上一步
    $("#returnBtn").click(function () {
        history.back()
    })
</script>
</html>
