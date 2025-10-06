<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="./css/userInfo.css" />

<%-- ================================
UserInfo 커스텀 태그

Props
- userName : 문자열 (예: "홍길동")
- grade : 문자열 (예: "VIP", "GOLD", "SILVER", "NORMAL")
- points : 숫자/문자 (예: "903")
- coupons : 숫자/문자 (예: "0")
- notifications : 숫자/문자 (예: "3") // 0이면 뱃지 숨김
- highlightColor : 강조 보라 (#9C2EF5 기본)
================================ --%>

<%@ attribute name="userName" required="false"%>
<%@ attribute name="grade" required="false"%>
<%@ attribute name="points" required="false"%>
<%@ attribute name="coupons" required="false"%>
<%@ attribute name="notifications" required="false"%>
<%@ attribute name="highlightColor" required="false"%>

<c:set var="userName" value="${empty userName ? '홍길동' : userName}" />
<c:set var="grade" value="${empty grade ? 'NORMAL' : grade}" />
<c:set var="points" value="${empty points ? '0' : points}" />
<c:set var="coupons" value="${empty coupons ? '0' : coupons}" />
<c:set var="notifications" value="${empty notifications ? '0' : notifications}" />
<c:set var="highlightColor" value="${empty highlightColor ? '#9C2EF5' : highlightColor}" />

<%-- 등급별 한글 표시 및 CSS 클래스 --%>
<c:choose>
    <c:when test="${grade eq 'VIP'}">
        <c:set var="gradeText" value="VIP" />
        <c:set var="gradeClass" value="vip" />
    </c:when>
    <c:when test="${grade eq 'GOLD'}">
        <c:set var="gradeText" value="GOLD" />
        <c:set var="gradeClass" value="gold" />
    </c:when>
    <c:when test="${grade eq 'SILVER'}">
        <c:set var="gradeText" value="SILVER" />
        <c:set var="gradeClass" value="silver" />
    </c:when>
    <c:otherwise>
        <c:set var="gradeText" value="일반" />
        <c:set var="gradeClass" value="normal" />
    </c:otherwise>
</c:choose>

<div class="user-info" style="--ui-accent:${highlightColor}">
    <!-- 상단 영역 -->
    <div class="user-info__top">
        <p class="greeting">
            <span class="name">${userName}</span>
            <span class="grade ${gradeClass}">${gradeText}</span>
            님 반갑습니다.
        </p>

        <button class="bell" type="button" aria-label="알림">
            <svg class="bell__icon" width="18" height="18" viewBox="0 0 24 24" aria-hidden="true">
                <path d="M12 22c1.1 0 2-.9 2-2h-4c0 1.1.9 2 2 2Zm6-6v-5c0-3.07-1.63-5.64-4.5-6.32V4a1.5 1.5 0 1 0-3 0v.68C7.63 5.36 6 7.92 6 11v5l-2 2v1h16v-1l-2-2Z" />
            </svg>
            <c:if test="${notifications ne '0' and notifications ne 0}">
                <span class="bell__badge" aria-label="${notifications}개의 새 알림">
                    <c:choose>
                        <c:when test="${notifications gt 99}">99+</c:when>
                        <c:otherwise>${notifications}</c:otherwise>
                    </c:choose>
                </span>
            </c:if>
        </button>
    </div>

    <!-- 하단 통계 영역 -->
    <div class="user-info__bottom">
        <div class="stat">
            <span class="label">포인트</span> 
            <span class="value"><span class="em">${points}</span> p</span>
        </div>
        <div class="stat">
            <span class="label">쿠폰</span> 
            <span class="value"><span class="em">${coupons}</span> 개</span>
        </div>
    </div>
</div>