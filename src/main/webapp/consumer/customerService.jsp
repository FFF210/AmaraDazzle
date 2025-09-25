<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="stylesheet" href="./tagcss/reset.css" />
<link rel="stylesheet" href="./consumer/css/header.css" />
<link rel="stylesheet" href="./consumer/css/footer.css" />
<link rel="stylesheet" href="./consumer/css/tab.css" />
<link rel="stylesheet" href="./tagcss/tag.css" />
<link rel="stylesheet" href="./tagcss/table.css" />
<link rel="stylesheet" href="./tagcss/pageHeader.css" />
<link rel="stylesheet" href="./tagcss/pagination.css" />
<link rel="stylesheet" href="./consumer/css/customerService.css" />
</head>
<body>

	<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>
	<my:pageHeader hasButton="true" title="고객센터" description="무엇을 도와드릴까요" />

	<!-- Main Content -->
	<main class="main-content">
		<c:import url="/tab.jsp">
			<c:param name="tabs" value="공지사항,1:1 문의" />
			<c:param name="activeTab" value="0" />
			<c:param name="tabId" value="categoryTabs" />
		</c:import>

		<!-- 공지사항 섹션 -->
		<div id="notice-section" class="tab-content active">
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 80px;">번호</th>
							<th style="width: 100px;">유형</th>
							<th>제목</th>
							<th style="width: 120px;">등록일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>5</td>
							<td><my:tag color="green" size="md" text="일반" /></td>
							<td class="text-left">[공지] 개인정보 처리방침 개정 안내(v12.4)</td>
							<td>2025-08-10</td>
						</tr>
						<tr>
							<td>4</td>
							<td><my:tag color="yellow" size="md" text="이벤트" /></td>
							<td class="text-left">경은님 힘내기 이벤트(죄송함)(~09.01)</td>
							<td>2025-08-10</td>
						</tr>
						<tr>
							<td>3</td>
							<td><my:tag color="green" size="md" text="일반" /></td>
							<td class="text-left">[공지] 개인정보 처리방침 개정 안내(v12.4)</td>
							<td>2025-08-10</td>
						</tr>
						<tr>
							<td>2</td>
							<td><my:tag color="green" size="md" text="일반" /></td>
							<td class="text-left">[공지] 개인정보 처리방침 개정 안내(v12.4)</td>
							<td>2025-08-10</td>
						</tr>
						<tr>
							<td>1</td>
							<td><my:tag color="green" size="md" text="일반" /></td>
							<td class="text-left">[공지] 개인정보 처리방침 개정 안내(v12.4)</td>
							<td>2025-08-10</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<!-- 1:1 문의 섹션 -->
		<div id="inquiry-section" class="tab-content">
			<!-- 필터 섹션 -->
			<div class="filter-section">
				<div class="filter-group">
					<label class="filter-label">구매기간</label>
					<div class="period-buttons">
						<button class="period-btn active" data-period="1">1개월</button>
						<button class="period-btn" data-period="3">3개월</button>
						<button class="period-btn" data-period="6">6개월</button>
						<button class="period-btn" data-period="12">12개월</button>
					</div>
				</div>

				<div class="date-range-group">
					<div class="date-input-group">
						<select class="date-select">
							<option>2025</option>
							<option>2024</option>
						</select> <span class="date-separator">년</span> <select class="date-select">
							<option>8</option>
							<option>7</option>
							<option>6</option>
						</select> <span class="date-separator">월</span> <select class="date-select">
							<option>4</option>
							<option>3</option>
							<option>2</option>
							<option>1</option>
						</select> <span class="date-separator">일</span>
					</div>

					<span class="date-range-separator">~</span>

					<div class="date-input-group">
						<select class="date-select">
							<option>2025</option>
							<option>2024</option>
						</select> <span class="date-separator">년</span> <select class="date-select">
							<option>8</option>
							<option>7</option>
							<option>6</option>
						</select> <span class="date-separator">월</span> <select class="date-select">
							<option>4</option>
							<option>3</option>
							<option>2</option>
							<option>1</option>
						</select> <span class="date-separator">일</span>
					</div>
				</div>

				<button class="search-btn">조회</button>
			</div>

			<!-- 문의내역 테이블 -->
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 80px;">번호</th>
							<th style="width: 100px;">유형</th>
							<th>내용</th>
							<th style="width: 120px;">등록일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td><span class="status-badge status-일반">일반</span></td>
							<td class="text-left">일본 쇼핑 상인과의 사용할 수 있는 능동적 쇼핑은 어느 상품이어까요?</td>
							<td>2025-08-10</td>
						</tr>
						<tr>
							<td>1</td>
							<td><span class="status-badge status-이벤트">이벤트</span></td>
							<td class="text-left">배송이 안 왔어요ㅠㅠ</td>
							<td>2025-08-10</td>
						</tr>
						<tr>
							<td>1</td>
							<td><span class="status-badge status-일반">일반</span></td>
							<td class="text-left">한글게시는 논스 셀과 다른 검색 등록할 수 있나요?</td>
							<td>2025-08-10</td>
						</tr>
						<tr>
							<td>1</td>
							<td><span class="status-badge status-일반">일반</span></td>
							<td class="text-left">주문을 환경에서 처소건고 실어요.....</td>
							<td>2025-08-10</td>
						</tr>
						<tr>
							<td>1</td>
							<td><span class="status-badge status-일반">일반</span></td>
							<td class="text-left">사이트가 자꾸 멈어리 이성혜요..</td>
							<td>2025-08-10</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- 1:1 문의하기 버튼 -->
			<div class="inquiry-button-section">
				<button class="inquiry-btn" onclick="openInquiry()">1:1
					문의하기</button>
			</div>
		</div>

		<!-- pagination -->
		<my:pagination currentPage="1" totalPages="10" baseUrl="" />


	</main>


	<%-- footer --%>
	<%@ include file="/consumer/footer.jsp"%>

	<script>
// 탭 전환 기능
document.addEventListener('DOMContentLoaded', function() {
    // 탭 버튼 클릭 이벤트 (tab.jsp에서 생성된 탭 버튼들)
    const tabButtons = document.querySelectorAll('#categoryTabs .tab-button');
    const tabContents = document.querySelectorAll('.tab-content');
    
    tabButtons.forEach((button, index) => {
        button.addEventListener('click', function() {
            // 모든 탭 버튼 비활성화
            tabButtons.forEach(btn => btn.classList.remove('active'));
            // 모든 탭 컨텐츠 숨기기
            tabContents.forEach(content => content.classList.remove('active'));
            
            // 클릭된 탭 활성화
            button.classList.add('active');
            tabContents[index].classList.add('active');
        });
    });
    
    // 기간 버튼 클릭 이벤트
    const periodButtons = document.querySelectorAll('.period-btn');
    periodButtons.forEach(button => {
        button.addEventListener('click', function() {
            periodButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            
            // 날짜 자동 설정 로직 (선택사항)
            const period = parseInt(button.dataset.period);
            setDateRange(period);
        });
    });
});

function setDateRange(months) {
    // 현재 날짜에서 지정된 개월 수만큼 이전 날짜 설정
    const today = new Date();
    const startDate = new Date(today);
    startDate.setMonth(today.getMonth() - months);
    
    console.log(`${months}개월 기간 설정: ${startDate.toISOString().split('T')[0]} ~ ${today.toISOString().split('T')[0]}`);
}

function openInquiry() {
    // 1:1 문의하기 모달 또는 페이지로 이동
}
</script>

</body>
</html>