<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버십 결제내역</title>

<link rel="stylesheet" href="./css/membership.css" />

<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/alert.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />

<!-- 달력 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>



</head>
<body>
	<my:layout>


		<my:breadcrumb
			items="멤버십 관리:/brand2/membership.jsp, 멤버십 결제:/brand2/membershipPay.jsp" />
		<!-- 멤버십 상태 영역 -->
		<div class="membership-status">
			<!-- 멤버십 없음 -->
			<div class="notice" id="noMembership" style="display: none;">
				보유한 멤버십이 없습니다. 새로운 멤버십을 구독해보세요!<br>
				<button class="btn btn-outline btn-sm" id="btnGoPay">멤버십 결제</button>
			</div>

			<!-- 현재 멤버십 -->
			<div class="current-membership" id="hasMembership">
				<span> 현재 이용 중 :<br> <strong id="planLabel">멤버십
						1개월</strong> <strong id="quotaLabel">10,000</strong>건 메일 발송 가능합니다.
				</span>
				<button class="btn btn-outline btn-sm" id="btnChangePlan">멤버십
					변경</button>
			</div>
		</div>


		<div class="membership-history">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox" class="form-check" /></th>
							<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
							<th>결제/취소일</th>
							<th>결제</th>
							<th>멤버십 기간</th>
							<th>멤버십</th>
							<th>결제수단</th>
							<th>다음결제일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="membership" items="${membershipList }">
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${membership.membershipId}</td>
								<td>결제/취소일</td>
								<td><my:tag color="green" size="sm" text="결제" /></td>
								<td><fmt:formatDate value="${membership.startDate}"
										pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
										value="${membership.endDate}" pattern="yyyy-MM-dd" /></td>
								<td>멤버십 1개월</td>
								<td>토스페이/취소</td>
								<td>정기결제인경우에만</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="page-pagination">
			<my:pagination currentPage="${currentPage}"
				totalPages="${totalPages}"
				baseUrl="/brand2/membership?${queryString}&page=" />
		</div>

		<!-- 정기결제 해지 / 멤버십 없음 버튼 -->
		<div class="btn-wrapper">
			<button type="button" class="btn btn-outline btn-sm" id="btnCancel">해지하기</button>
		</div>

		<%-- <!-- 멤버십 없음 alert -->
		<div class="alertBox" id="alertBox" style="display: none;">
			<my:alert type="error" message="멤버십을 보유하고 있지 않습니다." />
		</div> --%>

		<!-- 멤버십 있음 popup -->
		<div class="popup-overlay" id="popupOverlay" role="dialog"
			aria-modal="true" aria-labelledby="popupTitle">
			<div class="popup">
				<h3 id="popupTitle">정기 결제 해지</h3>
				<p>
					<span id="expireDate">2025-10-07</span>부터 효력이 발생합니다.<br> 그때까지는
					계속 이용할 수 있습니다.
				</p>
				<button class="btn btn-outline btn-sm" id="btnConfirmCancel">해지하기</button>
				<button class="btn btn-outline btn-sm" id="btnClose">닫기</button>
			</div>
		</div>
	</my:layout>
</body>
</html>