<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 리뷰</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./tagcss/reset.css" />
<link rel="stylesheet" href="./consumer/css/header.css" />
<link rel="stylesheet" href="./tagcss/productCard.css" />
<link rel="stylesheet" href="./consumer/css/mypageMenu.css" />
<link rel="stylesheet" href="./consumer/css/footer.css" />
<link rel="stylesheet" href="./consumer/css/tab.css" />
<link rel="stylesheet" href="./tagcss/table.css" />
<link rel="stylesheet" href="./consumer/css/myReview.css" />
<link rel="stylesheet" href="./tagcss/rating.css" />


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
			<my:userInfo userName="홍길동" points="903" coupons="0"
				notifications="2" />

			<!-- 리뷰 섹션 -->
			<section class="review-section">
				<h2>리뷰</h2>
				<div class="review-tabs-section">
					<c:import url="/tab.jsp">
						<c:param name="tabs" value="리뷰작성, 마이리뷰" />
						<c:param name="activeTab" value="0" />
						<c:param name="tabId" value="categoryTabs" />
						<c:param name="size" value="md" />
					</c:import>

					<!-- 탭 내용 -->
					<div class="tab-content">
						<div class="tab-panel active" data-tab="0">
							<div class="review-available-item">
								<!-- 구매한 내역 테이블 -->
								<div class="table-wrapper">
									<table class="table">
										<thead>
											<tr>
												<th style="width: 380px;">상품</th>
												<th style="width: 140px;">주문일자</th>
												<th style="width: 240px;">리뷰작성</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>상품 카드</td>
												<td>2025-08-14</td>
												<td><button class="btn btn-outline btn-md">리뷰작성</button></td>
											</tr>
											<tr>
												<td>상품 카드</td>
												<td>2025-08-14</td>
												<td><button class="btn btn-outline btn-md">리뷰작성</button></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="tab-panel" data-tab="1">
							<div class="my-review">
								<!-- 내가 쓴 리뷰 테이블 -->
								<div class="table-wrapper">
									<table class="table" id="my-review-table">
										<thead>
											<tr>
												<th style="width: 380px;">상품</th>
												<th style="width: 140px;">주문일자</th>
												<th style="width: 240px;">마이리뷰</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>상품 카드</td>
												<td>2025-08-14</td>
												<td><my:rating rating="5" readonly="true"
														noBackground="true" /><br>3일째 사용중 (민감성 건성피부 트러블
													자주올라옴) 거의 매일 선크림을 바르고 2중세안없이 닥토만 했더니 트러블이 자꾸올라와서 클렌징을 바꿔봤는데
													완전 뽀독 세안가능하고 신기하게 건조하진 않음 거품도 풍성해서 1차세안만으로 충분히 딥클렌징 가능</td>
											</tr>
											<tr>
												<td>상품 카드</td>
												<td>2025-08-14</td>
												<td><my:rating rating="5" readonly="true"
														noBackground="true" /><br>3일째 사용중 (민감성 건성피부 트러블
													자주올라옴) 거의 매일 선크림을 바르고 2중세안없이 닥토만 했더니 트러블이 자꾸올라와서 클렌징을 바꿔봤는데
													완전 뽀독 세안가능하고 신기하게 건조하진 않음 거품도 풍성해서 1차세안만으로 충분히 딥클렌징 가능</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</main>
	</div>

	<%-- 푸터 --%>
	<%@ include file="/consumer/footer.jsp"%>
	<script src="<c:url value='/js/tab.js'/>"></script>
</body>
</html>