<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너광고 조회</title>

<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/header.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
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
			items="배너광고 관리:/miniProj2/brand2/adbannerList.jsp" />

		<div class="filter">
			<my:tableFilter filters="진행 상황:전체|대기|진행 중|완료" searchItems="광고명,광고담당자" />
		</div>

		<div class="tcontainer">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th><input type="checkbox" class="form-check" /></th>
							<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
							<th>신청일</th>
							<th>광고 기간</th>
							<th>광고명</th>
							<th>진행 상황</th>
							<th>광고 담당자</th>
							<th>결제 금액</th>
							<th>담당 연락처</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="i" begin="1" end="10">
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td>2025-09-07~2025-09-14</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="green" size="sm" text="진행 중" /></td>
								<td>홍길동 팀장</td>
								<td>980,000</td>
								<td>010-1234-5678</td>
								<td><div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/miniProj2/brand2/eventForm.jsp'">상세보기</button>
									</div></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td>2025-09-07~2025-09-14</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="blue" size="sm" text="대기" /></td>
								<td>홍길동 팀장</td>
								<td>980,000</td>
								<td>010-1234-5678</td>
								<td><div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/miniProj2/brand2/eventForm.jsp'">수정</button>
										<button type="button" class="btn btn-outline btn-sm">취소</button>
									</div></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td>2025-09-07~2025-09-14</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="red" size="sm" text="취소" /></td>
								<td>홍길동 팀장</td>
								<td>980,000</td>
								<td>010-1234-5678</td>
								<td><div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/miniProj2/brand2/eventForm.jsp'">상세보기</button>
									</div></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td>2025-09-07~2025-09-14</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="blue" size="sm" text="대기" /></td>
								<td>홍길동 팀장</td>
								<td>980,000</td>
								<td>010-1234-5678</td>
								<td><div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/miniProj2/brand2/eventForm.jsp'">수정</button>
										<button type="button" class="btn btn-outline btn-sm">취소</button>
									</div></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td>2025-09-07~2025-09-14</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="green" size="sm" text="진행 중" /></td>
								<td>홍길동 팀장</td>
								<td>980,000</td>
								<td>010-1234-5678</td>
								<td><div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/miniProj2/brand2/eventForm.jsp'">상세보기</button>
									</div></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td>2025-09-07~2025-09-14</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="green" size="sm" text="진행 중" /></td>
								<td>홍길동 팀장</td>
								<td>980,000</td>
								<td>010-1234-5678</td>
								<td><div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/miniProj2/brand2/eventForm.jsp'">상세보기</button>
									</div></td>
							</tr>
							<tr>
								<td><input type="checkbox" class="form-check" /></td>
								<td>${i}</td>
								<td>2025-09-07</td>
								<td>2025-09-07~2025-09-14</td>
								<td>
									<p class="product-name">[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트
										EX 320ml 더블/듀오 한정기획 4종 택1</p>
								</td>
								<td><my:tag color="green" size="sm" text="진행 중" /></td>
								<td>홍길동 팀장</td>
								<td>980,000</td>
								<td>010-1234-5678</td>
								<td><div class="actions">
										<button type="button" class="btn btn-outline btn-sm" onclick="location.href='/miniProj2/brand2/eventForm.jsp'">상세보기</button>
									</div></td>
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

	<script>
	// 검색 버튼
	const submitBtn = container.querySelector(".filter-submit");
	if(submitBtn){
	  submitBtn.addEventListener("click", () => {
	    dispatch(true);
	  });
	}

	// 초기화 버튼
	const resetBtn = container.querySelector(".filter-reset");
	if(resetBtn){
	  resetBtn.addEventListener("click", () => {
	    container.querySelectorAll("input, .active").forEach(el => {
	      if(el.tagName === "INPUT") el.value = "";
	      el.classList.remove("active");
	    });
	    state.dateStart = "";
	    state.dateEnd = "";
	    state.quickRange = "";
	    state.filters = {};
	    state.searchField = "";
	    state.searchKeyword = "";
	    dispatch();
	  });
	}

	</script>
</body>
</html>