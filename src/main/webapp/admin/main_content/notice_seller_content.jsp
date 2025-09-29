<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- 메인부분 -->
<!-- 탭 -->
<div class="tabs">
	<div class="tab active" onclick="showTab('seller')">판매자</div>
	<div class="tab" onclick="showTab('platform')">플랫폼</div>
</div>

<!-- ************************* 판매자 탭 ************************* -->
<div id="seller" class="tab_content">
	<!-- 필터 -->
	<form class="search_form">
		<div class="search_container">
			<div class="filter">
				<div class="period_box">
					<div class="filtering_title">
						<span class="searchbox_title">작성일 : </span>
					</div>
					<div class="period_body">
						<div>
							<input type="date" class="btn start_date" /> <span> - </span> <input
								type="date" class="btn end_date" />
						</div>

						<div class="p_choice">
							<input type="button" class="btn" value="오늘" /> <input
								type="button" class="btn" value="어제" /> <input type="button"
								class="btn" value="최근7일" /> <input type="button" class="btn"
								value="최근30일" />
						</div>
					</div>
				</div>

				<div class="questionType_box">
					<div class="filtering_title">
						<span class="searchbox_title">카테고리 : </span>
					</div>
					<div>
						<select class="">
							<option>공지카테1</option>
							<option>공지카테2</option>
							<option>공지카테3</option>
							<option>공지카테4</option>
						</select>
					</div>
				</div>

				<div class="totalSearch_box">
					<div class="searchType">
						<select>
							<option>내용</option>
							<option>제목</option>
							<option>code</option>
							<option>작성자</option>
						</select>
					</div>
					<div class="searchKeyword">
						<i class="bi bi-search"></i><input type="text" />
					</div>
				</div>
			</div>

			<div class="btn_box">
				<input type="submit" class="btn first_btn" value="검색" /> <input
					type="reset" class="btn second_btn" value="초기화" />
			</div>
		</div>
	</form>
	<!-- 필터 end -->

	<!-- 버튼 -->
	<div class="button_wrap">
		<div>
			<button type="button" class="btn first_btn action_btn" onclick="goWriteNoticeSeller()">글쓰기</button>
		</div>
		<div>
			<button type="button" class="btn second_btn action_btn">삭제</button>
		</div>
	</div>
	<!-- 버튼 end -->

	<!-- 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span class="list_count">
				<c:if test="">
					[ 검색 결과 ]
				</c:if>
				 &nbsp; 총 ${noticeCnt}건 중 1 - 10 건 
			</span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 6%" />
					<!-- 체크박스 -->
					<col style="width: 7%" />
					<!-- 번호 -->
					<col style="width: 10%" />
					<!-- 카테고리 -->
					<col style="width: 30%" />
					<!-- 제목 -->
					<col style="width: 9%" />
					<!-- 작성자 -->
					<col style="width: 15%" />
					<!-- 작성일 -->
					<col style="width: 7%" />
					<!-- 조회수 -->
					<col style="width: 8%" />
					<!-- 노출여부 -->
					<col style="width: 8%" />
					<!-- 상세보기-->
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" /></th>
						<th>#</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>노출여부</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<!-- 게시물 개수가 0일 경우 -->
					<c:if test="${fn:length(noticeList)==0}">
						<tr>
							<td colspan="9">등록된 게시물이 없습니다.</td>
						</tr>
					</c:if>
					
					<c:set var="no" value="${noticeCnt-clickPage}" />
					<c:forEach items="${noticeList}" var="noticeList" varStatus="idx">
						<tr>
							<td><input type="checkbox" /></td>
							<td>${no-idx.index}</td>
							<td>
								<c:choose>
									<c:when test="${noticeList.typeId == '25' || noticeList.typeId == '29'}">  <!-- 카테고리 : 이벤트 -->
										<my:tag color="pink" size="md" text="${noticeList.name}" />
									</c:when>
									<c:when test="${noticeList.typeId == '26' || noticeList.typeId == '28'}">	 <!-- 카테고리 : 점검 / 시스템 -->
										<my:tag color="green" size="md" text="${noticeList.name}" />
									</c:when>
									<c:when test="${noticeList.typeId == '27' || noticeList.typeId == '30'}">	<!-- 카테고리 : 기타 -->
										<my:tag color="blue" size="md" text="${noticeList.name}" />	
									</c:when>
								</c:choose>
							</td>
							<td class="title_cell">
								<c:if test="${fn:length(noticeList.imageFileIds)!=0}">
									<i class="bi bi-paperclip"></i>
								</c:if>
								${noticeList.title}
								
							</td>
							<td>${noticeList.writer}</td>
							<td>
								<c:set var="createDate" value="${noticeList.createdAt}"/>
								&nbsp; ${fn:substring(createDate,0,19)}
							</td>
							<td>조회수</td>
							<td>
								<c:choose>
									<c:when test="${noticeList.isExposed == '1' }">  <!-- 게시여부 : 게시중 -->
										<my:tag color="yellow" size="md" text="게시중" />
									</c:when>
									<c:when test="${noticeList.isExposed == '0'}">	 <!-- 게시여부 : 노게시 -->
										<my:tag color="gray" size="md" text="비공개" />
									</c:when>
								</c:choose>
							</td>
							<td class="detail_cell" onclick="goNoticeDetail('${noticeList.noticeId}','${noticeList.targetTypeId}');"><i class="bi bi-three-dots-vertical" ></i></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- 페이지네이션 -->
		<div class="pagination_wrap" id="paginationWrap">
			<my:adminPagination currentPage="1" totalPages="10" baseUrl="/products?page=" />
		</div>
		<!-- 페이지네이션 end -->
	</div>
</div>
<!-- 메인부분 -->

<script src="./js/boardNotice.js"></script>