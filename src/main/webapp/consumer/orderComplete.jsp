<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

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
        
        <div class="order-number" 
             onclick="location.href='${pageContext.request.contextPath}/store/orderDetail?orderId=${orderId}'"
             style="cursor: pointer;">
            주문번호 ${orderInfo.order.orderCode}
        </div>
    
    <!-- ✅ 주문 정보 요약 -->
        <div class="order-summary" style="margin-top: 30px; padding: 20px; background: #f8f8f8; border-radius: 8px;">
            <h3 style="margin-bottom: 15px;">주문 상품</h3>
            <c:forEach var="item" items="${orderInfo.orderItems}">
                <div style="margin-bottom: 10px;">
                    <strong>${item.brandName}</strong> ${item.productName}
                    <c:if test="${not empty item.optionValue}">
                        (옵션: ${item.optionValue})
                    </c:if>
                    - ${item.quantity}개
                </div>
            </c:forEach>
            
            <div style="margin-top: 20px; padding-top: 15px; border-top: 1px solid #ddd;">
                <strong>최종 결제 금액: 
                    <fmt:formatNumber value="${orderInfo.order.totalAmount}" pattern="#,###"/>원
                </strong>
            </div>
        </div>
        
        <!-- 버튼 -->
        <div style="margin-top: 30px; display: flex; gap: 10px; justify-content: center;">
            <button onclick="location.href='${pageContext.request.contextPath}/store/mypage/orderDetail?orderId=${orderId}'" 
                    class="btn btn-primary btn-lg">
                주문 상세보기
            </button>
            <button onclick="location.href='${pageContext.request.contextPath}/store/mypage/orderList'" 
                    class="btn btn-outline btn-lg">
                주문 목록
            </button>
            <button onclick="location.href='${pageContext.request.contextPath}/store/main'" 
                    class="btn btn-outline btn-lg">
                쇼핑 계속하기
            </button>
        </div>
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