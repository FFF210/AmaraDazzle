<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 파라미터 기본값 처리 --%>
<c:set var="color"
	value="${param.color != null ? param.color : 'green'}" />
<c:set var="size" value="${param.size != null ? param.size : 'md'}" />
<c:set var="text" value="${param.text != null ? param.text : 'label'}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>테이블</title>
<link rel="stylesheet" href="../css/common/componant.css?v=3" />

<link rel="stylesheet" href="../css/componant/pagenation.css" />

<link rel="stylesheet" href="../css/user_seller.css" />

<!-- Bootstrap Icons CDN -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<!-- 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span>[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 5%" />
					<!-- 번호 -->
					<col style="width: 10%" />
					<!-- code -->
					<col style="width: 15%" />
					<!-- 날짜 -->
					<col style="width: 15%" />
					<!-- 포인트내역 -->
					<col style="width: 10%" />
					<!-- 금액 -->
					<col style="width: 10%" />
					<!-- 사용내역 -->
					<col style="width: 20%" />
					<!-- 주문번호 -->
					<col style="width: 10%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>code</th>
						<th>날짜</th>
						<th>포인트내역</th>
						<th>금액</th>
						<th>사용내역</th>
						<th>주문번호</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>P123456</td>
						<td>2025-09-02 11:12:13</td>
						<td>상품 구매 적립</td>
						<td class="price_cell">2,000</td>
						<td>적립</td>
						<td>20250902-0145874</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>P123456</td>
						<td>2025-09-02 11:12:13</td>
						<td>상품 구매 사용</td>
						<td class="price_cell">1,000</td>
						<td>사용</td>
						<td>20250902-014485</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>P123456</td>
						<td>2025-09-02 11:12:13</td>
						<td>리뷰 적립</td>
						<td class="price_cell">2,000</td>
						<td>적립</td>
						<td>20250902-014485</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 페이지네이션 -->
		<div class="pagination_wrap" id="paginationWrap">
			<!-- Prev button -->
			<button class="pg_nav" id="btnPrev">
				<i class="bi bi-chevron-left"></i>&nbsp;Prev&nbsp;
			</button>

			<!-- Pages container -->
			<div class="pages" id="pages">
				<button type="button" class="page_item active">1</button>
				<button type="button" class="page_item">2</button>
				<button type="button" class="page_item">12</button>
				<button type="button" class="page_item">13</button>
				<button type="button" class="page_item">111</button>
				<button type="button" class="page_item">158</button>
				<button type="button" class="page_item">1589</button>
			</div>

			<!-- Next button -->
			<button class="pg_nav" id="btnNext">
				&nbsp;Next&nbsp;<i class="bi bi-chevron-right"></i>
			</button>
		</div>
		<!-- 페이지네이션 end -->
	</div>
</body>
</html>
