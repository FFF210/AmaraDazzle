<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 상세 페이지</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./tagcss/reset.css" />
<link rel="stylesheet" href="./consumer/css/header.css" />
<link rel="stylesheet" href="./tagcss/productCard.css" />
<link rel="stylesheet" href="./tagcss/tag.css" />
<link rel="stylesheet" href="./tagcss/coupon.css" />
<link rel="stylesheet" href="./tagcss/eventCard.css" />
<link rel="stylesheet" href="./consumer/css/footer.css" />
<link rel="stylesheet" href="./tagcss/categoryFilter.css" />
<link rel="stylesheet" href="./tagcss/sortList.css" />
<link rel="stylesheet" href="./tagcss/brandDetail.css" />
<link rel="stylesheet" href="./tagcss/pagination.css" />
<link rel="stylesheet" href="./tagcss/button.css" />


</head>
<body>
    <!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>
	
	<!-- 상단 영역 -->
	<div class="main-container">
	
	<!-- 브랜드 헤더 -->
    <div class="brand-header">
	<h1>아비브</h1>
	
	<!-- 브랜드 대표 이미지가 와야함...  w:980px h:320px -->
		
	<!-- 하트버튼 -->
	<div class="brand-favorite">
	<my:heartBtn 
       state="active" 
       onlyIcon="true" 
       hasCount="true" 
       count="45342" />
       <span>명이 이 브랜드를 좋아합니다.</span>
       </div>
    </div>
    <span>브랜드에 대한 간단 소개 <br> 깨끗하고 건강한 피부를 생각합니다. </span>
    </div> 

	
	<!-- 이벤트 & 브랜드 쿠폰 -->
	<div class="brand-promotion">
	<my:eventCard imageUrl="https://placehold.co/320x160"
				title="올영 뷰티 구매인증 리뷰 이벤트" startDate="2025-09-01"
				endDate="2025-09-31" />
	
	<!-- 쿠폰 다운 -->
	<div class="coupon-download">			
	<my:coupon 
                amount="2,000" 
                startDate="2025.09.01" 
                endDate="2025.12.31" 
                label="신규 가입 혜택" />
      <button class="btn btn-primary btn-md">관심 브랜드 등록하고 쿠폰 받기</button>           
      </div>	
	</div>
	
	
	<!-- 브랜드 상품존 -->
	<div class="product-section">
	<my:categoryFilter 
       categories="스킨케어,메이크업,헤어,바디,향수,남성"
       columns="6" />
     <my:sortList hasSelect="false" />
     
       <div class="product-grid">
			<my:productCard brand="바이오던스" title="신상품1" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="신상품2" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="신상품3" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
		</div>		
		<div class="product-grid">
			<my:productCard brand="바이오던스" title="신상품1" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="신상품2" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="신상품3" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			
			<div class="pagination-wrapper">	
			<my:pagination currentPage="1" baseUrl="" totalPages="3"/>
		</div>
		</div>
	
	  </div>
	
<!-- 하단 푸터 -->
<%@ include file="/consumer/footer.jsp"%>

</body>
</html>