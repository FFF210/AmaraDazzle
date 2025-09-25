<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>공지사항</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/form-controls.css" />
<link rel="stylesheet" href="./css/layout.css" />
<link rel="stylesheet" href="./css/sidebar.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/table.css" />
<link rel="stylesheet" href="./css/dialog.css" />
<link rel="stylesheet" href="./css/tag.css" />
<link rel="stylesheet" href="./css/selectbox.css" />
<link rel="stylesheet" href="./css/dateInput.css" />
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/productList.css" />
<link rel="stylesheet" href="./css/breadcrumb.css" />
<link rel="stylesheet" href="./css/pagination.css" />
<link rel="stylesheet" href="./css/tableFilter.css" />
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
				<p>총 200 건</p>
			</div>

			<!-- 결과 테이블 -->
			<div class="page-table">
				<div class="table-wrapper">
					<table class="table">
						<thead>
							<tr>
								<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>작성일</th>
								<th>공지유형</th>
								<th>제목</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="i" begin="1" end="5">
								<tr>
									<td>1</td>
									<td>2025-09-10</td>
									<td><my:tag color="green" size="sm" text="label" /></td>
									<td>
										<div class="product-name">
											<p>공지 제목이 들어갑니다.</p>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<!-- 상세 영역 -->
			<div class="notice-detail-container" id="noticeDetail">
				<div class="notice-detail-header">
					<my:tag color="green" size="sm" text="시스템" />
					<span class="notice-title">공지사항입니다. 필독</span> <span
						class="notice-date">2025.09.04</span>
				</div>
				<div class="notice-detail-body">여기는 공지사항 내용이 작성됩니다. 선택된 공지의 상세
					본문이 이곳에 표시됩니다.</div>

				<!-- 첨부파일 -->
				<div class="notice-attachments">
					<ul>
						<li><a href="/files/manual.pdf" download>매뉴얼.pdf</a></li>
						<li><a href="/files/guide.docx" download>사용자_가이드.docx</a></li>
					</ul>
				</div>
			</div>

			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="1" totalPages="5"
					baseUrl="/products?page=" />
			</div>
		</div>
	</my:layout>

	<script>
  // 테이블 정렬
  document.querySelectorAll(".table th.sortable").forEach(th => {
	  th.addEventListener("click", () => {
	    document.querySelectorAll(".table th.sortable").forEach(other => {
	      if (other !== th) {
	        other.classList.remove("asc", "desc");
	        other.querySelector(".sort-icon").className = "bi bi-dash-lg sort-icon";
	      }
	    });

	    const icon = th.querySelector(".sort-icon");

	    if (th.classList.contains("asc")) {
	      th.classList.remove("asc");
	      th.classList.add("desc");
	      icon.className = "bi bi-caret-down-fill sort-icon";
	    } else if (th.classList.contains("desc")) {
	      th.classList.remove("desc");
	      icon.className = "bi bi-dash-lg sort-icon";
	    } else {
	      th.classList.add("asc");
	      icon.className = "bi bi-caret-up-fill sort-icon";
	    }
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