<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="./css/userInfo.css" />

<%-- ================================
UserInfo 컴포넌트 (JSP include용)

필요한 데이터 (request 또는 session에서 가져옴)
- memberInfo : Map (selectMemberInfo 결과)
- name : 회원 이름. 문자열 (예: "홍길동")
 - grade : 회원 등급 (NORMAL, SILVER, GOLD, VIP)
- pointBalance : 포인트 (예: "903")
- couponCount : Integer (사용 가능한 쿠폰 개수)
- highlightColor : 강조 보라 (#9C2EF5 기본)
- notificationCount : Integer (읽지 않은 알림 개수) - 현재는 0으로 고정
================================ --%>
<%-- 기본값 설정 --%>
<c:set var="memberName" value="${empty memberInfo.name ? '회원' : memberInfo.name}" />
<c:set var="memberGrade" value="${empty memberInfo.grade ? 'NORMAL' : memberInfo.grade}" />
<c:set var="points" value="${empty memberInfo.pointBalance ? 0 : memberInfo.pointBalance}" />
<c:set var="coupons" value="${empty couponCount ? 0 : couponCount}" />
<c:set var="notifications" value="${empty notificationCount ? 0 : notificationCount}" />

<%-- 등급별 한글 표시 --%>
<c:choose>
    <c:when test="${memberGrade eq 'VIP'}">
        <c:set var="gradeText" value="VIP" />
        <c:set var="gradeClass" value="vip" />
    </c:when>
    <c:when test="${memberGrade eq 'GOLD'}">
        <c:set var="gradeText" value="GOLD" />
        <c:set var="gradeClass" value="gold" />
    </c:when>
    <c:when test="${memberGrade eq 'SILVER'}">
        <c:set var="gradeText" value="SILVER" />
        <c:set var="gradeClass" value="silver" />
    </c:when>
    <c:otherwise>
        <c:set var="gradeText" value="일반" />
        <c:set var="gradeClass" value="normal" />
    </c:otherwise>
</c:choose>

<div class="user-info">
    <!-- 상단 영역 -->
    <div class="user-info__top">
        <p class="greeting">
            <span class="name">${memberName}</span>
            <span class="grade ${gradeClass}">${gradeText}</span>
            님 반갑습니다.
        </p>

        <button class="bell" type="button" aria-label="알림">
            <svg class="bell__icon" width="18" height="18" viewBox="0 0 24 24" aria-hidden="true">
                <path d="M12 22c1.1 0 2-.9 2-2h-4c0 1.1.9 2 2 2Zm6-6v-5c0-3.07-1.63-5.64-4.5-6.32V4a1.5 1.5 0 1 0-3 0v.68C7.63 5.36 6 7.92 6 11v5l-2 2v1h16v-1l-2-2Z" />
            </svg>
            <%-- 알림 개수가 0보다 크면 뱃지 표시 (현재는 항상 숨김) --%>
            <c:if test="${notifications gt 0}">
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