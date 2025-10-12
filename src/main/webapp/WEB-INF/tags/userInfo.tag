<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="./css/userInfo.css" />

<%-- ================================
UserInfo 커스텀 태그

Props
- userName : 문자열 (예: "홍길동")
- grade : 문자열 (예: "VIP", "GOLD", "SILVER", "NORMAL")
- points : 숫자/문자 (예: "903")
- coupons : 숫자/문자 (예: "0")
- highlightColor : 강조 보라 (#9C2EF5 기본)

사용예시:
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<my:userInfo
    userName="${memberInfo.name}"
    grade="${memberInfo.grade}"
    points="${memberInfo.pointBalance}"
    coupons="${couponCount}" />
================================ --%>
<%@ attribute name="userName" required="false"%>
<%@ attribute name="grade" required="false"%>
<%@ attribute name="points" required="false"%>
<%@ attribute name="coupons" required="false"%>
<%@ attribute name="highlightColor" required="false"%>

<c:set var="userName" value="${empty userName ? '홍길동' : userName}" />
<c:set var="grade" value="${empty grade ? 'NORMAL' : grade}" />
<c:set var="points" value="${empty points ? '0' : points}" />
<c:set var="coupons" value="${empty coupons ? '0' : coupons}" />
<c:set var="highlightColor" value="${empty highlightColor ? '#9C2EF5' : highlightColor}" />

<%-- 등급별 한글 표시 --%>
<c:choose>
    <c:when test="${grade eq 'VIP'}">
        <c:set var="gradeText" value="VIP" />
    </c:when>
    <c:when test="${grade eq 'GOLD'}">
        <c:set var="gradeText" value="GOLD" />
    </c:when>
    <c:when test="${grade eq 'SILVER'}">
        <c:set var="gradeText" value="SILVER" />
    </c:when>
    <c:otherwise>
        <c:set var="gradeText" value="일반" />
    </c:otherwise>
</c:choose>

<div class="user-info" style="--ui-accent:${highlightColor}">
    <!-- 상단 영역 -->
    <div class="user-info__top">
        <p class="greeting">
            <span class="name">${userName}</span> 님 반갑습니다.
        </p>
    </div>

    <!-- 하단 통계 영역 -->
    <div class="user-info__bottom">
        <div class="stat">
            <span class="label">등급</span> 
            <span class="value"><span class="em">${gradeText}</span></span>
        </div>
        <div class="stat">
            <span class="label">포인트</span> 
            <span class="value"><span class="em"><fmt:formatNumber value="${points}" pattern="#,###" /></span> p</span>
        </div>
        <div class="stat">
            <span class="label">쿠폰</span> 
            <span class="value"><span class="em">${coupons}</span> 개</span>
        </div>
    </div>
</div>