<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/3/21
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<head>
    <title>后台首页</title>
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
        <%--栅格系统--%>
        <!--grid-属性会为其子级div按比例分配宽度-->
        <!--spacing-属性会为其本身添加下外边距，也会为其子级div俩俩间添加间距-->
        <span>
                <font size="6">首页</font>
                &nbsp;&nbsp;&nbsp;
                <font color="#808080">仪表盘</font>
            <!--修改对应的class，可更换图标。不一定是 span 标签，也可以是 i 标签之类的-->
            <span class="icon-home2" style="margin-left: 1000px"><a href="javascript:window.location.reload()">首页</a></span>
            <font color="#808080" style="margin-left: 12px"> > </font>
            <font color="#808080"style="margin-left:3px">仪表盘</font>
        </span>
        <div class="grid-1-1-1-1 spacing-20" style="margin-top: 55px">
            <%--用户数--%>
            <div style="background-color:#209cee; height:150px;">
                <br>
                <br>
                <font style="margin-left: 140px"><b
                        style="font-size:1cm;  color: white">${todayNewAddUserCount}</b></font>
                <br>
                <br>
                <font size="4" style="margin-left: 85px">今日新增用户数</font>
            </div>
            <%--帖子数--%>
            <div style="height:150px;background-color:#ff3860;">
                <br>
                <br>
                <font style="margin-left: 140px"><b style="font-size:1cm;  color: white">${todayNewAddResourceCount}</b></font>
                <br>
                <br>
                <font size="4" style="margin-left: 85px">今日新增帖子数</font>
            </div>
            <%--评论数--%>
            <div style="height:150px;background-color:#23d160;">
                <br>
                <br>
                <font style="margin-left: 140px"><b style="font-size:1cm;  color: white">${todayNewAddCommentCount}</b></font>
                <br>
                <br>
                <font size="4" style="margin-left: 85px">今日新增评论数</font>
            </div>
            <%--待审核帖子--%>
            <div style="height:150px;background-color: orange;">
                <br>
                <br>
                <font style="margin-left: 140px"><b
                        style="font-size:1cm;  color: white">${notJudgeResourceCount}</b></font>
                <br>
                <br>
                <font size="4" style="margin-left: 100px">待审核帖子数</font>
            </div>
        </div>
          <div style="margin-top: 100px">
              <font size="5" color="#8b0000">静态提示</font>
              <br/>
              <br/>
              <table id="table" class="table unhover" style="max-width: 30%">
                 <tr>
                     <th style="font-weight: 800"><font size="4">当前IP</font></th>
                     <td><font size="3" color="orange">${ipAddress}</font></td>
                 </tr>
                  <tr>
                      <th style="font-weight: 800"><font size="4">版权</font></th>
                      <td><font size="3" color="red">翁莜寒</font></td>
                  </tr>
              </table>
          </div>
    </div>
    <%--至上一个div,iframe结束--%>

</div>
</body>

<script>
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
</script>
</html>
