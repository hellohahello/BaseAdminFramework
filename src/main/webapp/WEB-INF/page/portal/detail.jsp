
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>详情</title>
    <style type="text/css">
        a:hover{
            color: deepskyblue;
        }

    </style>
</head>
<body>
<!--顶部导航-->
<div class="admin-navbar">
    <c:import url="header.jsp"></c:import>
</div>

<!--主题内容-->
<div class="admin-mian">
    <!--iframe载入内容-->
    <div class="admin-markdown">
        <div  class="block" id="typeId" style="position:absolute; left:0px; top:3px;width: auto;height: auto">

        </div>

        <%--搜索框start--%>
        <div class="input-group">
            <input type="text" id="searchContent"  class="text" placeholder="提示信息" onkeydown="if (event.keyCode==13){doSearch(this.value)}"  style="margin-left: 800px;margin-top: 40px" />
            <input type="button" id="searchBtn" class="button blue" value="搜索" />
        </div>
        <!--主体内容-->



        <%--前台正文--%>
        <div class="list-content" style="position:absolute; left:0px; top:20px;height: auto; ">
            <div class="clear">
                <span class="icon-home2"><a href="/portal/index.action"><font color="#808080" size="4">首页&nbsp;</font></a></span>
                <span class="divider">></span>
                <span class="active">&nbsp;<a href="/portal/type.action?resCategoryId=${resource.resCategoryId}"><font color="#6495ed" size="4">${resource.categoryName}</font></a></span>
            </div><br/>
            <!--块元素-->
            <div class="block">
                <!--正文内容-->
                <div class="main" style="width: 1000px">
                   <h2><b>${resource.resourceName}</b></h2>
                    <br/>
                    <img style="height: 50px;width:50px; vertical-align: middle" src="${resource.avatar}"/>

                    <font color="red">${resource.userName}</font>&nbsp;&nbsp;<span style="margin-left: 50px">发表于</span><font color="#00bfff"> ${resource.createTimeStr}</font>
                    <span style="margin-left: 50px">
                        归类<a href="/portal/type.action?resCategoryId=${resource.resCategoryId}"><font color="#ff1493" style="margin-left: 10px">${resource.categoryName}</font></a>
                    </span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="margin-left: 50px" color="orange">${resource.points}积分</font>
                    <!--修改对应的class，可更换图标。不一定是 span 标签，也可以是 i 标签之类的-->
                    <span class="icon-eye" style="font-size:10px;color:inherit;margin-left: 360px">${resource.click}</span>
                    <br/>

                    <%----%>
                    <!--内容区域-->
                            <!--banner用来修饰块元素的名称-->
                            <!--正文内容-->
                            <div class="main" style="max-width: 85%">
                               <p> ${resource.content}</p>
                            </div>
                    <br/>
                    <div>
                       <font color="red"><h2><b>下载地址</b></h2></font>
                    </div>
                    <!--栅格系统 无缝演示-->
                    <!--grid-属性会为其子级div按比例分配宽度-->
                    <c:choose>
                        <c:when test="${resource.points==0||zero==0||sessionScope.user.itsVip==true||resource.userId==sessionScope.user.userId}">
                            <div class="grid-1">
                                <div style="margin-top:20px;max-width:75%;height:50px;background-color: white;border: dashed cadetblue">
                                    <span style="margin-left: 30px"><font color="green">链接：</font><a href="${resource.download}"><font style="margin-left: 10px">${resource.download}</font></a></span>
                                    <span style="margin-left: 70px"><font color="green">密码：</font><font color="red">${resource.passWord}</font></span>

                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="grid-1" id="isNotFree">
                                <div style="margin-top:20px;max-width: 70%;height:50px;background-color: white;border: dashed cadetblue">
                                    <span>本主题需要向作者支付&nbsp;<b>${resource.points}个积分</b>&nbsp;才能浏览</span>
                                    <%--<span style="margin-left: 15%">--%>
                                        <%--<i class="icon-star"></i>--%>
                                        <%--<a href="JavaScript:download()" style="color: red">vip免费下载</a>--%>
                                    <%--</span>--%>
                                    <span style="margin-left: 5%">
                                <a href="javascript:download()">
                                    <font color="blue">
                                <span class="icon-vpn_key" style="color: orange;margin-left: 30%">

                                </span>
                                    <font size="3">购买主题</font>
                                </font>
                            </a>
                            </span>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${collectionCount>0}">
                            <div id="collectDiv" style="margin-top: 20px"><button id="collectionBtn1" class="button yellow">收藏本帖&nbsp;<font color="#808080">${collectionCount}</font></button></div>
                        </c:when>
                        <c:otherwise>
                            <div style="margin-top: 20px"><button id="collectionBtn2" class="button yellow">收藏本帖</button></div>
                        </c:otherwise>
                    </c:choose>
                 <%--评论组件  start--%>
                    <div id="comment"  style="margin-top: 20px" class="comment"></div>
                <%--评论组件   end--%>
                </div>
            </div>

        </div>
        <%--正文end--%>

    </div>

</div>
</body>
</html>

<script type="text/javascript">
    <%--下载--%>
    function downloadCallback() {
        var resourceId='${resource.resourceId}';
        $.ajax({
            url : "${pageContext.request.contextPath}/portal/resource/download.json",
            type : "POST",
            dataType : "json",
            data : {
                "resourceId" : resourceId
            },
            success : function(rtn) {
                if (rtn.code=='000'){
                    javaex.optTip({
                        content : "下载成功",
                        type : "success"
                    });
                    setTimeout(
                        function () {
                        window.location.reload()
                    },2000
                    )
                }
                else {
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
    //点击下载
    function download() {
//        判断是否登录
        if (${ empty sessionScope.user}){
            javaex.message({
                content : "登陆后才能下载哦，请点击右上角登录/注册",
                type : "error"
            });
            return;
        }
        else {
            <c:choose>
            <c:when test="${resource.points!=0}">
            <c:if test="${sessionScope.user.itsVip}">
            javaex.confirm({
                content : "本次下载将不会扣积分，确认下载？",
                callback : "downloadCallback()"
            });
            return;
            </c:if>
            javaex.confirm({
                content : "确定花费<font color='red'>${resource.points}</font>个积分下载该主题？",
                callback : "downloadCallback()"
            });
            </c:when>
            <c:otherwise>

            </c:otherwise>
            </c:choose>

        }
    }
    //    页面一加载，就向后台请求类型数据
    var commentList='';
    $(function () {

//                请求评论组件
                $.ajax({
                    url : "${pageContext.request.contextPath}/portal/comment/list.json",
                    type : "POST",
                    dataType : "json",
                    data : {
                        "resourceId": '${resource.resourceId}'
                    },
                    success : function(rtn) {
                        if (rtn.code=='000'){
                            commentList=rtn.data.commentList;
                            var count=commentList.length;
                            commentTools(count)

                        }
                    },
                    error : function(rtn) {

                    }
                });

//
    })
    $("#searchBtn").click(function () {
        doSearch($("#searchContent").val());
        console.log($("#searchContent").val());
    })
    //    搜索
    function  doSearch(keyWord){
// 判断关键字是否为空
        keyWord = keyWord.replace(/(^\s*)|(\s*$)/g, "");
        if (keyWord!="") {
            window.location.href = "${pageContext.request.contextPath}/portal/search.action?keyWord="+keyWord;
        }
    }


//    评论组件
    function commentTools() {
        var userId='${sessionScope.user.userId}';
        var avatar='${sessionScope.user.avatar}';

        javaex.comment({
            id : "comment",		// 评论列表的承载主键
            avatar : "avatar", 	// 默认头像地址
            url : "http://www.m173.cc/?UID=", // 用户信息页面的请求地址
            isChangeTimeText : true,	// 修改时间显示文本
            commentCount : commentList.length,	// 评论+回复的总条数
            list : commentList,		// 评论+回复的数据
            commentMapping : {	// 评论字段映射
                commentId : "commentId",	// 评论表的主键
                userId : "userId",	// 评论用户的id
                userName : "commentOwnName",	// 评论用户的名称（一般为登录名或昵称）
                avatar : "avatar",	// 评论用户的头像
                content : "content",	// 评论内容
                time : "commentTimeStr",	// 评论时间
                replyList : "replyList" // 该条评论下的回复数据
            },
            replyMapping : {	// 回复字段映射
                userId : userId,	// 回复用户的id
                userName : "replyUserName",	// 回复用户的名称（一般为登录名或昵称）
                avatar : "avatar",	// 回复用户的头像
                toUserId : "toUid",	// 被回复用户的id
                toUserName : "toUserName",	// 被回复用户的名称（一般为登录名或昵称）
                content : "content",	// 回复内容
                time : "commentTimeStr"	// 回复时间
            },
            callback : function(rtn) {	// 用户评论后的回调函数

                //如果未登录，return false
                if(${ empty sessionScope.user}){
                    javaex.optTip({
                        content : "登录后才能评论",
                        type : "error"
                    });
//                   var url=window.location.href;
//                    window.location.href="/login.action?returnUrl="+url;
//                    return false;
                }
                //
                if (rtn.type=="comment") {
                    var content=rtn.content;  //评论内容
                    var commentTime=new Date();
                    var userId='${sessionScope.user.userId}';
                    var resourceId='${resource.resourceId}';
                    var avatar='${sessionScope.user.avatar}';

                    $.ajax({
                        url : "${pageContext.request.contextPath}/portal/comment/save.json",
                        type : "POST",
                        dataType : "json",
                        data : {
                            "avatar":avatar,
                            "content" : content,
                            "commentTime": commentTime,
                            "userId":userId,
                            "resourceId": resourceId
                        },
                        success : function(rtn) {
                        if (rtn.code=='000'){
                            window.location.reload()
                        }
                        },
                        error : function(rtn) {

                        }
                    });
                    console.log(rtn.content);
                } else if (rtn.type=="reply") {
                    // 对评论的回复
                    console.log("评论id："+rtn.commentId);	// 返回评论的主键
                    console.log("回复对象的用户id："+rtn.toUserId);	// 返回回复对象的userId
                    console.log("回复给谁："+rtn.toUserName);	// 返回回复对象的名称
                    console.log("回复内容："+rtn.content);	// 返回回复内容
                    var content=rtn.content;  //评论内容
                    var commentTime=new Date();
                    var toUserId=rtn.toUserId;
                    var resourceId='${resource.resourceId}';
                    var commentId=rtn.commentId;
                    var userId='${sessionScope.user.userId}';
                    var avatar='${sessionScope.user.avatar}';



                    $.ajax({
                        url : "${pageContext.request.contextPath}/portal/comment/reply.json",
                        type : "POST",
                        dataType : "json",
                        data : {
                            "content" : content,
                            "commentTime": commentTime,
                            "toUserId":toUserId,
                            "resourceId": resourceId,
                            "commentId": commentId,
                            "userId": userId,
                            "avatar": avatar



                        },
                        success : function(rtn) {
                            if (rtn.code=='000'){
                                javaex.optTip({
                                    content : "已发表",
                                    type : "success"
                                });
                            }
                        },
                        error : function(rtn) {

                        }
                    });

                }
            }
        });


    }
//点击收藏时
    var currentUser='${sessionScope.user.userId}';
    var id="${resource.resourceId}";
//    点击收藏时
    $("#collectionBtn1").click(
        function () {
            //登录后才能收藏
            if (currentUser==null||currentUser==''){
                javaex.optTip({
                    content : "登陆后才能收藏哦",
                    type : "error"
                });
                return false;
            }

            $.ajax({
                url : "${pageContext.request.contextPath}/portal/resource/collection.json",
                type : "POST",
                dataType : "json",
                data : {
                    "resourceId" : id,
                    "userId" : currentUser
                },
                success : function(rtn) {
//                收藏成功
                    if (rtn.code=='000'){
                        javaex.optTip({
                            content : "已收藏",
                            type : "success"
                        });
                    }
                    //如果已经收藏过了
                    else {
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
        )

    $("#collectionBtn2").click(
      function () {
          //登录后才能收藏
          if (currentUser==null||currentUser==''){
              javaex.optTip({
                  content : "登陆后才能收藏哦",
                  type : "error"
              });
              return false;
          }

          $.ajax({
              url : "${pageContext.request.contextPath}/portal/resource/collection.json",
              type : "POST",
              dataType : "json",
              data : {
                  "resourceId" : id,
                  "userId" : currentUser
              },
              success : function(rtn) {
//                收藏成功
                  if (rtn.code=='000'){
                      javaex.optTip({
                          content : "已收藏",
                          type : "success"
                      });
                  }
                  //如果已经收藏过了
                  else {
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
    )
</script>
