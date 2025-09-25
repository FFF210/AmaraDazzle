<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>이벤트 조회</title>

<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/header.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<style>
.pagination {
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	margin: 20px 0; /* 위아래 여백 */
}

.breadcrumb {
	margin-top: 8px;
	margin-left: 24px;
}

.filter {
	margin: 24px 24px 24px 24px;
}

.tcontainer {
	margin: 0px 24px 24px 24px;
}
</style>

</head>
<body>
	<my:layout>
		<my:breadcrumb
			items="이벤트 관리:/brand2/eventList.jsp" />
		<div class="filter">
			<my:tableFilter filters="진행 상황:전체|모집 중|진행 중|완료"
				searchItems="이벤트 종류,이벤트 담당자" />
		</div>
		<div class="tcontainer">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox" class="form-check" /></th>
							<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
							<th>신청일</th>
							<th>이벤트 기간</th>
							<th>이벤트 종류</th>
							<th>이벤트 진행</th>
							<th>이벤트 담당자</th>
							<th>참여 여부</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="i" begin="1" end="10">
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07${i}</td>
								<td>2025-09-07~2025-09-30${i}</td>
								<td>수분 광채템 기획전</td>
								<td><my:tag color="green" size="sm" text="진행중" /></td>
								<td>박길동 대리</td>
								<td><my:tag color="blue" size="sm" text="참여" /></td>
								<td>
									<div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/brand2/eventForm.jsp'">상세보기</button>
									</div>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07${i}</td>
								<td>2025-09-07~2025-09-30${i}</td>
								<td>수분 광채템 기획전</td>
								<td><my:tag color="green" size="sm" text="진행중" /></td>
								<td>-</td>
								<td><my:tag color="gray" size="sm" text="미참여" /></td>
								<td>
									<div class="actions">-</div>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07${i}</td>
								<td>2025-09-07~2025-09-30${i}</td>
								<td>수분 광채템 기획전</td>
								<td><my:tag color="gray" size="sm" text="완료" /></td>
								<td>-</td>
								<td><my:tag color="gray" size="sm" text="미참여" /></td>
								<td>
									<div class="actions">-</div>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07${i}</td>
								<td>2025-09-07~2025-09-30${i}</td>
								<td>수분 광채템 기획전</td>
								<td><my:tag color="gray" size="sm" text="완료" /></td>
								<td>박길동 대리</td>
								<td><my:tag color="blue" size="sm" text="참여" /></td>
								<td>
									<div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/brand2/eventForm.jsp'">상세보기</button>
									</div>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07${i}</td>
								<td>2025-09-07~2025-09-30${i}</td>
								<td>수분 광채템 기획전</td>
								<td><my:tag color="green" size="sm" text="모집중" /></td>
								<td>박길동 대리</td>
								<td><my:tag color="blue" size="sm" text="참여" /></td>
								<td>
									<div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/brand2/eventForm.jsp'">수정</button>
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/brand2/eventForm.jsp'">상세보기</button>
									</div>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07${i}</td>
								<td>2025-09-07~2025-09-30${i}</td>
								<td>수분 광채템 기획전</td>
								<td><my:tag color="gray" size="sm" text="미참여" /></td>
								<td>-</td>
								<td><my:tag color="gray" size="sm" text="미참여" /></td>
								<td>
									<div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/brand2/eventForm.jsp'">신청하기</button>
									</div>
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07${i}</td>
								<td>2025-09-07~2025-09-30${i}</td>
								<td>수분 광채템 기획전</td>
								<td><my:tag color="blue" size="sm" text="모집중" /></td>
								<td>-</td>
								<td><my:tag color="gray" size="sm" text="미참여" /></td>
								<td>
									<div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/brand2/eventForm.jsp'">신청하기</button>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="pagination">
			<my:pagination currentPage="1" totalPages="10"
				baseUrl="/products?page=" />
		</div>
	</my:layout>

</body>

</html>