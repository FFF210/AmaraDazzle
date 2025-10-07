<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- ========== 내용(일대일문의) ========== -->
<div id="question" class="tab_content" style="display: none">
	<!-- 필터 -->
	<form id="sellerPchForm" class="search_form">
		<my:adminTableFilter>
			<my:adminFilterPeriod title="작성일" />
			<my:adminFilterMiddle filters="답변상태:ALL=전체|SALE=미답변|SOLD_OUT=답변" name="" />
			<my:adminFilterType optList="시스템,이벤트,기타" initial="문의 유형" name="q_select" />
			<my:adminFilterTotal searchItems="내용,답변" />
		</my:adminTableFilter>
	</form>
	<!-- 필터 end -->
	
	<!-- 일대일문의 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span class="list_count"> 
			<c:if test="${not empty searchContent}">
				[ 검색 결과 ]
			</c:if> &nbsp; 총 ${sellerCnt}건 중 
			<c:choose>
				<c:when test="${sellerCnt == 0}">
   					0 건
   				</c:when>
				<c:otherwise>
    				${postNo + 1}
 					<c:choose>
						<c:when test="${paging.pageno == paging.end_pg && paging.final_post_ea < 10 && paging.final_post_ea != 0}">
            				- ${postNo + paging.final_post_ea}
        				</c:when>
						<c:otherwise>
                 			- ${postNo + 10}
            			</c:otherwise>
					</c:choose>
       				건
    			</c:otherwise>
			</c:choose>
			</span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 5%" />
					<!-- 번호 -->
					<col style="width: 10%" />
					<!-- 문의유형 -->
					<col style="width: 31%" />
					<!-- 내용 -->
					<col style="width: 15%" />
					<!-- 작성일 -->
					<col style="width: 7%" />
					<!-- 답변여부 -->
					<col style="width: 15%" />
					<!-- 최종답변일 -->
					<col style="width: 6%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>문의유형</th>
						<th>내용</th>
						<th>작성일</th>
						<th>답변여부</th>
						<th>답변일</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>S124567</td>
						<td class="title_cell">데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td class="detail_cell reply_view">
							<i class="bi bi-chevron-compact-down"></i></td>
					</tr>
					<!-- 문의 내용 보기 -->
					<tr class="question_detail" data-group="1" style="display: none">
						<td class="detail_icon"><i class="bi bi-caret-right-fill"></i></td>
						<td class="detail_body" colspan="6">
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
						<td class="reply_body" colspan="4">
							<div id="replyDetail-1" class="replyDetail-panel">
								월별 판매 리포트에 카테고리별 비교 그래프 추가 요청 답변. <br /> 데이터 파이프라인 검토 필요. 월별
								판매 리포트에 카테고리별 비교 그래프 추가 요청 답변. <br />
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
						<td class="reply_body" colspan="5">
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
					<tr data-group="3" data-main="true">
						<td>8</td>
						<td>데이터 4-2</td>
						<td class="title_cell">데이터 4-3</td>
						<td>데이터 4-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td class="detail_cell reply_view"><i
							class="bi bi-chevron-compact-down"></i></td>
					</tr>
					<!-- 문의 내용 보기 -->
					<tr class="question_detail" data-group="3" style="display: none">
						<td class="detail_icon"><i class="bi bi-caret-right-fill"></i></td>
						<td class="detail_body" colspan="6">
							<div id="detail-3" class="detail-panel">
								월별 판매 리포트에 카테고리별 비교 그래프 추가 요청. <br /> 데이터 파이프라인 검토 필요. 월별 판매
								리포트에 카테고리별 비교 그래프 추가 요청. <br /> 월별 판매 리포트에 카테고리별 비교 그래프 추가 요청.
								<br /> 월별 판매 리포트에 카테고리별 비교 그래프 추가 요청. <br />
							</div>
						</td>
					</tr>
					<!-- 문의 내용 보기 end -->
					<!-- 답글 내용보기 -->
					<tr class="reply_detail" data-group="3" style="display: none">
						<td class="reply_icon"><i class="bi bi-arrow-return-right"></i></td>
						<td class="reply_body" colspan="4">
							<div id="replyDetail-3" class="replyDetail-panel">
								월별 판매 리포트에 카테고리별 비교 그래프 추가 요청 답변. <br /> 데이터 파이프라인 검토 필요. 월별
								판매 리포트에 카테고리별 비교 그래프 추가 요청 답변. <br />
							</div>
						</td>
						<td class="replyed_date" colspan="2">
							<div>2025-09-17 03:58:58</div>
							<div>홍길동</div>
						</td>
					</tr>
					<!-- 답글 내용보기 end -->
					<!-- 답글 달기 -->
					<tr class="question_reply" data-group="3" style="display: none">
						<td class="reply_icon"><i class="bi bi-arrow-return-right"></i></td>
						<td class="reply_body" colspan="5">
							<div class="reply_panel" id="reply-3">
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
<%-- 			<my:adminPagination currentPage="1" totalPages="10" baseUrl="/products?page=" /> --%>
	</div>
	<!-- 페이지네이션 end -->
	</div>
</div>
