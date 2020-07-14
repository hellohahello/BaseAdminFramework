<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>我的头像</title>
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
</head>
<body>
<%--顶部导航--%>
<div class="admin-navbar">
    <c:import url="../header.jsp"></c:import>
</div>

<div class="admin-mian">
    <!--左侧菜单-->
    <c:import url="user_center_left.jsp"/>
    <!--内容区域-->
    <div class="list-content">
        <!--块元素-->
        <div class="block">
            <!--块元素标题-->
            <div class="banner">
                <p class="tab fixed">修改头像</p>
            </div>
            <!--正文内容-->
            <div class="main">
                <!--静态提示-->
                <p class="tip warning">请勿使用包含不良信息或敏感内容的图片作为用户头像。</p>
                <!--分割线-->
                <p class="divider"></p>
                <!--上传组件区域-->
                <div class="unit clear">
                    <a href="javascript:;" class="file-container button indigo">
                        点击这里上传图片
                        <input type="file" class="file" id="upload-avatar" accept="image/gif, image/jpeg, image/jpg, image/png" />
                    </a>
                    <p class="hint">支持JPG、GIF、PNG格式，文件应小于5M，文件太大将导致无法读取</p>
                </div>
                <!--分割线-->
                <p class="divider"></p>
                <!--头像上传预览区域-->
                <div class="unit clear">
                    <div class="avatar-original">
                        <div id="image-box" class="image-box">
                            <!--裁剪层-->
                            <div id="cut-box" class="cut-box"></div>
                            <!--背景层（可移动图片）-->
                            <div id="move-box" class="move-box"></div>
                        </div>
                        <!--放大、缩小-->
                        <span id="narrow" class="icon-zoom-out" style="color: #666;font-size: 20px;"></span>
                        <span id="enlarge" class="icon-zoom-in" style="color: #666;font-size: 20px;float: right;"></span>
                    </div>
                    <!--裁剪后的预览区域-->
                    <div class="avatar-preview">
                        <!--静态提示-->
                        <p class="tip">
                            您上传的头像会自动生成3种尺寸，请注意中、小尺寸的头像是否清晰。
                        </p>
                        <div class="view">
                            <div class="view-avatar180">
                                <div class="avatar180"></div>
                                <p class="hint">大尺寸头像，180像素X180像素</p>
                            </div>
                            <div class="view-avatar50">
                                <div class="avatar50"></div>
                                <p class="hint">中尺寸头像，50像素X50像素</p>
                            </div>
                            <div class="view-avatar30">
                                <div class="avatar30"></div>
                                <p class="hint">小尺寸头像，30像素X30像素</p>
                            </div>
                        </div>
                    </div>
                    <!--自动返回裁剪后的图片地址-->
                    <input type="hidden" id="data-url" value="" />
                </div>
                <!--分割线-->
                <p class="divider"></p>
                <!--保存头像区域-->
                <div class="unit clear">
                    <a href="javascript:;" onclick="saveAvatar()" class="button navy">保存头像</a>
                </div>
            </div>
        </div>

        <script>
            // 点击上传（必须用change）
            $("#upload-avatar").change(function() {
                javaex.uploadAvatar(
                    this,	// 必填
                    {
                        imgDivId : "image-box",	// 本地上传的图片区域id
                        cutBox : "cut-box",		// 裁剪区域id
                        moveBox : "move-box",	// 背景区域id，可拖动
                        dataUrl : "data-url",	// 最终将图片地址返回给哪个input存储
                        type : "base64"			// 图片地址类型，目前仅支持base64
                    }
                );
            });
        </script>
    </div>

</div>
</body>
<script type="text/javascript">

    /**
     * 更新用户头像
     */
    function saveAvatar() {
        $.ajax({
            url : "/portal/user/avatar/update.json",
            type : "POST",
            dataType : "json",
            data : {
                "base64Image" : $("#data-url").val()
            },
            success : function(rtn) {
                if (rtn.code=="000") {
                    javaex.message({
                        content : "修改成功",
                        type : "success"
                    });
//                    $("#headImg").attr("src",rtn.data.base64Image);
                    $("#headImg").remove();
                    var html='<img src="'+rtn.data.base64Image+'" style="width:50px;height: 45px;margin-top: 12px">';
                    $("#imgHref").append(html);
//                    setTimeout(function() {
//                        parent.location.reload();
//                    }, 2000);
                } else {
                    javaex.message({
                        content : rtn.message,
                        type : "error"
                    });
                }
            }
        });
    }
</script>
</html>
