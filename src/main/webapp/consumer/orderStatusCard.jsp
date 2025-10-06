<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="./css/orderStatusCard.css" />

<%-- ================================
OrderStatusCard 컴포넌트 (JSP include용)

필요한 데이터 (request 또는 session에서 가져옴)
- title : 문자열 (제목, 기본값: "주문/배송 조회")
- orderCount : 숫자 (주문접수 건수)
- paymentCount : 숫자 (결제완료 건수)
- shippingCount : 숫자 (배송준비중 건수)
- deliveredCount : 숫자 (배송중 건수)
- confirmedCount : 숫자 (배송완료 건수)
- activeStatus : 문자열 (활성화할 상태: order|payment|shipping|delivered|confirmed)

사용법 예시
<%@ include file="/WEB-INF/components/orderStatusCard.jsp" %>
================================ --%>

<%-- 기본값 설정 --%>
<c:set var="title" value="${empty title ? '주문/배송 조회' : title}" />
<c:set var="orderCount" value="${empty orderCount ? '0' : orderCount}" />
<c:set var="paymentCount" value="${empty paymentCount ? '0' : paymentCount}" />
<c:set var="shippingCount" value="${empty shippingCount ? '0' : shippingCount}" />
<c:set var="deliveredCount" value="${empty deliveredCount ? '0' : deliveredCount}" />
<c:set var="confirmedCount" value="${empty confirmedCount ? '0' : confirmedCount}" />
<c:set var="activeStatus" value="${empty activeStatus ? '' : activeStatus}" />

<div class="order-status-card">
    <!-- 헤더 -->
    <div class="order-status-header">
        <h3 class="order-status-title">${title}</h3>
        <button class="more-btn" type="button">
            <span class="more-text">더보기</span>
            <span class="more-icon">›</span>
        </button>
    </div>

    <!-- 상태별 카운트 -->
    <div class="order-status-box">
        <div class="status-item ${activeStatus eq 'order' ? 'active' : ''}">
            <div class="status-count">${orderCount}</div>
            <div class="status-label">주문접수</div>
        </div>

        <div class="status-item ${activeStatus eq 'payment' ? 'active' : ''}">
            <div class="status-count">${paymentCount}</div>
            <div class="status-label">결제완료</div>
        </div>

        <div class="status-item ${activeStatus eq 'shipping' ? 'active' : ''}">
            <div class="status-count">${shippingCount}</div>
            <div class="status-label">배송준비중</div>
        </div>

        <div class="status-item ${activeStatus eq 'delivered' ? 'active' : ''}">
            <div class="status-count">${deliveredCount}</div>
            <div class="status-label">배송중</div>
        </div>

        <div class="status-item ${activeStatus eq 'confirmed' ? 'active' : ''}">
            <div class="status-count">${confirmedCount}</div>
            <div class="status-label">배송완료</div>
        </div>
    </div>
</div>