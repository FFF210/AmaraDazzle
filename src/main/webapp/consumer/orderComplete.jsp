<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>    

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문완료</title>
 <link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
    <link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
    <link rel="stylesheet" href="<c:url value='/consumer/css/pageHeader.css'/>">    
    <link rel="stylesheet" href="<c:url value='/consumer/css/tab.css'/>">
    <link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
    <link rel="stylesheet" href="<c:url value='/consumer/css/orderComplete.css'/>">
    <link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
    
</head>
<body>
    <!-- 헤더 include -->
    <%@ include file="/consumer/header.jsp" %>
    
<!-- 페이지 헤더 (주문완료 타이틀) -->
<div class="page-header">
    <div class="container">
        <my:pageHeader
        hasButton="false"
        title="주문완료" />
    </div>
</div>

<!-- 주문완료 메인 컨텐츠 -->
<div class="order-completion-content">
    <!-- 메인 주문완료 섹션 -->
    <div class="main-section">
        <h1 class="completion-message">주문이 완료되었습니다.</h1>
        <div class="order-number">주문번호 Y2344352234 ${orderNumber}</div>
    </div>
    
    <!-- 안내사항 섹션 -->
    <div class="info-section">
        <ul class="info-list">
            <li>본 브랜드 배송상품은 [결제완료] 상태까지 주문 취소가 가능하며, [배송준비중]일 때는 고객센터를 통해 취소 요청할 수 있습니다.</li>
            <li>이미 발송이 시작된 경우에는 취소가 불가할 수 있으며, 상품 수령 후 반품 요청 부탁드립니다.</li>
        </ul>
    </div>
    </div>

<!-- 푸터 include -->
<%@ include file="/consumer/footer.jsp" %>
</body>
</html>