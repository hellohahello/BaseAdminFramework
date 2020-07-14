<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wengyouhan
  Date: 2020/4/4
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    <link href="/assets/css/main.css" rel="stylesheet" />
    <title>开通vip</title>
</head>
<body>
<div class="wrap product-container" style="margin-top: 20px">
    <div class="container clear">

        <div class="vipgrch-intro">
            <div class="intro-tit">全站VIP
            <a style="margin-left: 50px" href="/portal/index.action"><font color="#00bfff">首页</font>
            </a>
            </div>
            <div class="intro-bod clear">
                <div class="bod-l fl d-bodOfi">
                    <div class="top">
                        <i class="global-vip-icon"></i>
                        <p class="global-vip-tit">全站VIP</p>
                    </div>
                    <div class="btm">
                        <p class="global-vip-price"><b>360<span>元/年</span></b>（￥<em>499</em>）</p>
                        <p class="global-vip-include">（会员视频+课件+独家文档+付费帖优惠价）</p>
                    </div>
                    <span class="flash-sales"></span>
                    <span class="recommend-buy"></span>
                </div>
                <div class="bod-r fr">
                    <h4>VIP全站会员无限学习！</h4>
                    <ul>
                        <li class="hook-long"><i class="hook"></i>会员视频任性看</li>
                        <li><i class="hook"></i>付费帖 <span>免积分</span> 观看</li>
                        <li><i class="hook"></i>课件资料下载无限制</li>
                        <li><i class="hook"></i>独家技术文档浏览权限</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="vipgrch-pay">
            <div class="pay-tit">
                <span class="tit-span">选择充值方式</span>
                <p class="price-html">付款金额：<em>360元/年</em>&nbsp;&nbsp;&nbsp; 每天不足<em>1</em>元</p>
            </div>
            <div class="pay-bod">
                <dl class="wx-pay">
                    <dt id="wxpay">
                        <div class="no-pay-pic">暂不支持</div>
                    </dt>
                    <dd>
                        <p><i class="icon-wechat" style="color: green"></i>使用微信支付</p>
                    </dd>
                </dl>
                <dl id="alipay">
                    <dt>
                        <div class="no-pay-pic">暂不支持</div>
                    </dt>
                    <dd><a href="javascript:;" class="al-pay-btn">支付宝支付</a></dd>
                </dl>
                <dl id="yuepay">
                    <dt>
                        <div class="no-pay-pic">余额支付</div>
                    </dt>
                    <dd><a href="javascript:;" onclick="payByBalance()" class="al-pay-btn">余额支付</a></dd>
                </dl>
            </div>
        </div>

        <p style="text-align: center; margin-top: 20px; font-size: 18px; color: #666;">充值余额请联系<font color="red">微信li1291482971</font>，注明来意</p>
    </div>
</div>
</div>
</div>
</body>
</html>
