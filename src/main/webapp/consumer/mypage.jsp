<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/mypageMenu.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/orderStatusCard.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/userInfo.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/mypage.css'/>">
</head>

<body>
	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>
	
	<div class="container">
	<!-- Sidebar -->
    <aside class="sidebar">
	<!-- 마이페이지 메뉴 -->
	<%@ include file="/consumer/mypageMenu.jsp"%> 
	</aside>
	
	<!-- Main Content -->
    <main class="main-content">
    
	<!-- user info -->
	<div class="user-wrapper">
    <my:userInfo
      userName="홍길동"
      points="903"
      coupons="0"
      notifications="2"/>
      </div>
	
	<!-- 주문 조회 배송 박스 -->
	 <my:orderStatusCard 
       title="주문/배송 조회"
       orderCount="0"
       paymentCount="1"
       shippingCount="0"
       deliveredCount="0"
       confirmedCount="0"
       activeStatus="payment" />
	
	<!-- 좋아요 섹션 -->
	<section class="product-section">
           <div class="section-header">
           <h3 class="section-title">좋아요</h3>
            <a href="/store/mypage/wishlist" class="more-link">더보기 ></a>                
           </div>
	
	    <div class="product-grid">
			<my:productCard brand="바이오던스" title="상품명1" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500">
			</my:productCard>
			<my:productCard brand="바이오던스" title="상품명2" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="상품명3" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
		</div>
    </section>
    
	<!-- 장바구니 섹션 -->
	<section class="product-section">
       <div class="section-header">
	    <h3 class="section-title">장바구니</h3>	
	     <a href="/store/mypage/cart" class="more-link">더보기 ></a>                
         </div>
	
	    <div class="product-grid">
			<my:productCard brand="바이오던스" title="상품명1" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500">
			</my:productCard>
			<my:productCard brand="바이오던스" title="상품명2" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="상품명3" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
		</div>
    </section>
   </main>
  </div>

    <!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>