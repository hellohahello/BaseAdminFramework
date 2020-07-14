<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/3/31
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>角色设置</title>
    <!--字体图标-->
    <link href="/javaex/pc/css/icomoon.css" rel="stylesheet"/>
    <!--动画-->
    <link href="/javaex/pc/css/animate.css" rel="stylesheet"/>
    <!--骨架样式-->
    <link href="/javaex/pc/css/common.css" rel="stylesheet"/>
    <!--皮肤（缇娜）-->
    <link href="/javaex/pc/css/skin/tina.css" rel="stylesheet"/>
    <!--jquery-->
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

<div style="margin-top: 27%;margin-left: 40%"><font size="5" color="#ff4500">角色设置</font></div>
<div style="margin-top: 30px;margin-left: 120px">
    <select id="role_select">
        <option value="">请选择</option>
        <option value="administrator">管理员</option>
        <option value="member" >会员</option>
    </select>
</div>
<div style="margin-top: 40px">
    &nbsp; &nbsp; &nbsp;
    <button onclick="roleNameSet(${userId})" style="margin-left: 100px;width: 180px" id="confirm" class="button blue"><span class="icon-check2"></span> 确定</button>
</div>
</body>
<script>
    var roleName='';
    javaex.select({
        id : "role_select",
        isSearch : false,
        // 回调函数
        callback: function (rtn) {
            roleName=rtn.selectName;
        }
    });

    /**
     * 更新角色
     * @param userId
     */
    function roleNameSet(userId) {

        if (roleName==''){
            javaex.optTip({
                content : "设置失败，请选择正确的角色名称",
                type : "error"
            });
            return false;
        }
        $.ajax({
            url : "${pageContext.request.contextPath}/administrator/user/role_set.json",
            type : "POST",
            dataType : "json",
            data : {
                "userId" : userId,
                "roleName" : roleName
            },
            success : function(rtn) {
                if (rtn.code=='000'){
                    javaex.optTip({
                        content : "设置成功",
                        type : "success"
                    });
                    // 建议延迟加载
                    setTimeout(function() {
                        // 刷新页面
                         window.location.reload();
                    }, 1000);

                }            },
            error : function(rtn) {

            }
        });
}
</script>
</html>
