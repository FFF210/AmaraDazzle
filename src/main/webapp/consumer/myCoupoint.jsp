<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 쿠폰 / 포인트</title>>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/dateRangeFilterBox.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/coupon.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/mypageMenu.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/myCoupoint.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/userInfo.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
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
		
		<h3>마이 쿠폰 / 포인트</h3>

			<!-- user info -->
			<my:userInfo 
            userName="${memberInfo.name}"
            grade="${memberInfo.grade}" 
            points="${memberInfo.pointBalance}" 
            coupons="${couponCount}"  />

			<!-- 쿠폰 섹션 -->
			<section class="coupon-section">
				<!-- 보유 쿠폰 테이블 -->
				<div class="table-wrapper">
					<table class="table">
						<thead>
							<tr>
								<th style="width: 580px;">쿠폰명</th>
								<th style="width: 140px;">쿠폰사용조건</th>
								<th style="width: 140px;">사용가능기간</th>
							</tr>
						</thead>
						<tbody>
						<!-- 쿠폰이 없을 때 -->
                        <c:if test="${empty couponList}">
                            <tr>
                                <td colspan="3" style="text-align: center; padding: 40px;">
                                    보유한 쿠폰이 없습니다.
                                </td>
                            </tr>
                        </c:if>
							<!-- 쿠폰 목록 반복 출력 -->
                        <c:forEach var="coupon" items="${couponList}">
                            <tr>
                                <td class="coupon-name">
                                    ${coupon.cname}
                                </td>
                                <td>${coupon.amountCondition}</td>
                                <td>
                                    <fmt:formatDate value="${coupon.startDate}" pattern="yyyy.MM.dd"/> ~ 
                                    <fmt:formatDate value="${coupon.endDate}" pattern="yyyy.MM.dd"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="couponzone-button">
				<button class="btn btn-primary btn-md" 
                    onclick="location.href='<c:url value='/consumer/couponList'/>'">
                쿠폰존 바로가기
            </button>
            </div>
			</section>

			<!-- 포인트 섹션 -->
			<section class="point">
				<div class="middle-devider">
					<h2>사용 가능한 포인트 ${memberInfo.pointBalance} p</h2>
            </div>
				<div>
				<form action="<c:url value='/store/mypage/myCoupoint'/>" method="get">
					<my:dateRangeFilterBox periods="1,3,6,12" submitLabel="조회" size="sm" />
					</form>

					<!-- 포인트 내역 테이블 -->
					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th style="width: 140px;">일자</th>
									<th style="width: 580px;">내용</th>
									<th style="width: 140px;">적립/사용</th>
								</tr>
							</thead>
							<tbody>
								<!-- 포인트 내역이 없을 때 -->
                            <c:if test="${empty pointHistory}">
                                <tr>
                                    <td colspan="3" style="text-align: center; padding: 40px;">
                                        포인트 내역이 없습니다.
                                    </td>
                                </tr>
                            </c:if>
                            
                            <!-- 포인트 내역 반복 출력 -->
                            <c:forEach var="point" items="${pointHistory}">
                                <tr>
                                    <td>
                                        <fmt:formatDate value="${point.createdAt}" pattern="yyyy.MM.dd"/>
                                    </td>
                                    <td>
                                        ${point.pointHistory}
                                        <c:if test="${not empty point.orderId}">
                                            <br>주문번호: ${point.orderId}
                                        </c:if>
                                    </td>
                                    <td>
                                        <span class="${point.amount.startsWith('+') ? 'plus' : 'minus'}">
                                            ${point.amount}P
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
					</div>
				</div>
			</section>
		</main>
	</div>
	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>