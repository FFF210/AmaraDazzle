<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./tagcss/reset.css" />
<link rel="stylesheet" href="./consumer/css/header.css" />
<link rel="stylesheet" href="./consumer/css/cart.css" />
<link rel="stylesheet" href="./tagcss/productCard.css" />
<link rel="stylesheet" href="./consumer/css/footer.css" />
<link rel="stylesheet" href="./tagcss/table.css" />
<link rel="stylesheet" href="./tagcss/button.css" />
<link rel="stylesheet" href="./tagcss/pageHeader.css" />
</head>
<body>
    <!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>
	
	<!-- 페이지 헤더 -->
	<div class="pageHeader">
	<my:pageHeader 
       hasButton="false"
       title="장바구니" />
     </div>

    <!-- 장바구니에 담은 상품 정보 테이블 -->
    <div class="table-wrapper">
        <table class="table">
            <thead>
                <tr>
                    <th style="width: 50px;">선택</th>
                    <th style="width: 80px;">상품정보</th>
                    <th style="width: 300px;">상품명</th>
                    <th style="width: 120px;">수량</th>
                    <th style="width: 120px;">구매가격</th>
                    <th style="width: 80px;">적립금</th>
                    <th style="width: 100px;">관리</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <input type="checkbox" class="form-check" />
                    </td>
                    <td>
                        <img src="/images/product-placeholder.jpg" alt="상품이미지" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                    </td>
                    <td class="product-name">
                        토니모리 이러다죽겠네 무지개다리건너 12색 팔레트
                    </td>
                    <td>
                        <input type="number" value="1" min="1" class="quantity-input">
                    </td>
                    <td>
                        <div class="price">19,000원</div>
                    </td>
   
                    <td>
                        <div class="action-buttons">
                            <button class="btn btn-outline btn-sm">바로구매</button>
                            <button class="btn btn-outline btn-sm">찜 등록</button>
                            <button class="btn btn-danger btn-sm">삭제</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" class="form-check" />
                    </td>
                    <td>
                        <img src="/images/product-placeholder.jpg" alt="상품이미지" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                    </td>
                    <td class="product-name">
                         토니모리 이러다죽겠네 무지개다리건너 12색 팔레트
                    </td>
                    <td>
                        <input type="number" value="1" min="1" class="quantity-input">
                    </td>
                    <td>
                        <div class="price">19,000원</div>
                    </td>

                    <td>
                        <div class="action-buttons">
                            <button class="btn btn-outline btn-sm">바로구매</button>
                            <button class="btn btn-outline btn-sm">찜 등록</button>
                            <button class="btn btn-danger btn-sm">삭제</button>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <!-- 선택/삭제 버튼 -->
    <div class="select-all-container">
        <button type="button">전체선택 해제</button>
        <button type="button">선택상품 삭제</button>
    </div>

    <!-- 총 결제 예상 정보 -->
    <div class="cart-summary">
        <div class="total-amount">
            총 결제예상금액 38,000원
        </div>
    </div>

    <!-- 버튼 -->
    <div class="button-container">
        <button class="btn btn-outline btn-lg">선택 주문</button>
        <button class="btn btn-primary btn-lg">전체 주문</button>
    </div>
</div>
	
	
	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>