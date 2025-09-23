<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>


<!-- 메인부분 -->
<!-- 탭 -->
<div class="tabs">
	<div class="tab active" onclick="showTab('seller')">판매자문의</div>
	<div class="tab" onclick="showTab('consumer')">일반회원문의</div>
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

				<div class="answer_box">
					<div class="filtering_title">
						<span class="searchbox_title">답변상태 : </span>
					</div>
					<div class="answer_body">
						<div class="choice ch">
							<input type="button" value="전체" />
						</div>
						<div class="choice ch">
							<input type="button" value="미답변" />
						</div>
						<div class="choice">
							<input type="button" value="답변완료" />
						</div>
					</div>
				</div>

				<div class="questionType_box">
					<div class="filtering_title">
						<span class="searchbox_title">문의유형 : </span>
					</div>
					<div>
						<select class="">
							<option>문의유형1</option>
							<option>문의유형2</option>
							<option>문의유형3</option>
							<option>문의유형4</option>
						</select>
					</div>
				</div>

				<div class="totalSearch_box">
					<div class="searchType">
						<select>
							<option>브랜드명</option>
							<option>code</option>
							<option>담당자명</option>
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

	<!-- 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span class="list_count">[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 5%" />
					<col style="width: 7%" />
					<col style="width: 7%" />
					<col style="width: 4%" />
					<col style="width: 21%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 8%" />
					<col style="width: 10%" />
					<col style="width: 8%" />
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>문의유형</th>
						<th>code</th>
						<th>첨부</th>
						<th>내용</th>
						<th>브랜드명</th>
						<th>code</th>
						<th>작성일</th>
						<th>답변여부</th>
						<th>최종답변일</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>[문의유형]</td>
						<td>Q123456</td>
						<td><i class="bi bi-paperclip"></i></td>
						<td class="title_cell">문의글 문의글 문의글 문의글</td>
						<td>아비브</td>
						<td>S123456</td>
						<td>2025-09-19 12:33:45</td>
						<td>[Y]</td>
						<td>2025-09-19 12:45:41</td>
						<td class="detail_cell reply_view"><i
							class="bi bi-chevron-compact-down"></i></td>
					</tr>
					<!-- 문의 내용 보기 -->
					<tr class="question_detail" data-group="1" style="display: none">
						<td class="detail_icon"><i class="bi bi-caret-right-fill"></i></td>
						<td class="detail_body" colspan="10">
							<div id="detail-1" class="detail-panel">
								월별 판매 리포트에 카테고리별 비교 그래프 추가 요청. <br /> 데이터 파이프라인 검토 필요. 월별 판매
								리포트에 카테고리별 비교 그래프 추가 요청. <br /> 월별 판매 리포트에 카테고리별 비교 그래프 추가 요청.
								<br /> 월별 판매 리포트에 카테고리별 비교 그래프 추가 요청. <br />
							</div>
						</td>
					</tr>
					<!-- 문의 내용 보기 end -->
					<!-- 답글 내용보기 -->
					<tr class="reply_detail" data-group="1" style="display: none">
						<td class="reply_icon"><i class="bi bi-arrow-return-right"></i></td>
						<td class="reply_body" colspan="8">
							<div id="replyDetail-1" class="replyDetail-panel">
								월별 판매 리포트에 카테고리별 비교 그래프 추가 요청 답변. <br /> 데이터 파이프라인 검토 필요. 월별 판매
								리포트에 카테고리별 비교 그래프 추가 요청 답변. <br />
							</div>
						</td>
						<td class="replyed_date" colspan="2">
							<div>2025-09-17 03:58:58</div>
							<div>홍길동</div>
						</td>
					</tr>
					<!-- 답글 내용보기 end -->
					<!-- 답글 달기 -->
					<tr class="question_reply" data-group="1" style="display: none">
						<td class="reply_icon"><i class="bi bi-arrow-return-right"></i></td>
						<td class="reply_body" colspan="9">
							<div class="reply_panel" id="reply-1">
								<textarea name="reply_write"></textarea>
							</div>
						</td>
						<td class="reply_send">
							<!-- <button type="button" class="btn"><i class="bi bi-send"></i></button> -->
							<button type="button" class="btn">답글달기</button>
						</td>
					</tr>
					<!-- 답글 달기 end -->
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