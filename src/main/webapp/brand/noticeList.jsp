<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>공지사항</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/dialog.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="./css/noticeList.css" />
</head>
<body>

	<my:layout>
		<div class="page-container">
			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="공지사항:" />
			</div>

			<!-- 총 건수 -->
			<div class="page-totalCount">
				<p>총 ${totalCount} 건</p>
			</div>

			<!-- 결과 테이블 -->
			<div class="page-table">
				<div class="table-wrapper">
					<table class="table">
						<thead>
							<tr>
								<th>번호</th>
								<th>공지유형</th>
								<th>제목</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="notice" items="${noticeList}" varStatus="loop">
								<tr class="notice-row" data-id="${notice.noticeId}"
									style="cursor: pointer;">
									<td style="width: 100px">${totalCount - ((currentPage - 1) * 7 + loop.index)}</td>
									<td style="width: 100px"><my:tag
											color="${notice.typeName eq '시스템' ? 'green' : (notice.typeName eq '이벤트' ? 'blue' : 'gray')}"
											size="sm" text="${notice.typeName}" /></td>
									<td>
										<div class="product-name">
											<p>${notice.title}</p>
										</div>
									</td>
									<td style="width: 160px"><fmt:formatDate value="${notice.createdAt}"
											pattern="yyyy-MM-dd" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<!-- 상세 영역 -->
			<div class="notice-detail-container" id="noticeDetail">
				<p class="text-muted"></p>
			</div>


			<c:set var="queryString"> page=</c:set>

			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}"
					baseUrl="/brand/noticeList?${queryString}" />
			</div>
		</div>
	</my:layout>

	<script>
	document.querySelectorAll(".notice-row").forEach(row => {
		  row.addEventListener("click", async () => {
		    const id = row.dataset.id;

		    // 선택된 행 하이라이트 효과 (선택사항)
		    document.querySelectorAll(".notice-row").forEach(r => r.classList.remove("selected"));
		    row.classList.add("selected");

		    // Ajax 요청
		    const response = await fetch(`/brand/noticeDetailFragment?noticeId=\${id}`);
		    if (!response.ok) {
		      document.getElementById("noticeDetail").innerHTML = "<p>상세 내용을 불러오지 못했습니다.</p>";
		      return;
		    }

		    // JSP fragment HTML 받아서 교체
		    const html = await response.text();
		    document.getElementById("noticeDetail").innerHTML = html;

		    // URL 파라미터 동기화 (새로고침 없이 주소만 변경)
		    const url = new URL(window.location);
		    url.searchParams.set("id", id);
		    window.history.pushState({}, "", url);
		  });
		});
	
  // 공지 행 클릭 시 상세 영역 업데이트
  document.querySelectorAll(".notice-row").forEach(row => {
    row.addEventListener("click", () => {
      const id = row.dataset.id;
      // 실제에선 Ajax 호출로 상세 불러오기
      document.getElementById("noticeDetail").innerHTML = `
        <div class="notice-detail-header">
          <span class="notice-tag">시스템</span>
          <span class="notice-title">공지 제목 ${id} 상세</span>
          <span class="notice-date">2025.09.10</span>
        </div>
        <div class="notice-detail-body">
          공지 ${id} 의 상세 내용이 여기에 표시됩니다.
        </div>
      `;
    });
  });
</script>
</body>
</html>