<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- ========== 내용(리뷰) ========== -->
<div id="review" class="tab_content" style="display: none">
	<!-- 필터 -->
	<form id="sellerSettleForm" class="search_form">
		<my:adminTableFilter>
			<my:adminFilterPeriod title="작성일" />
			<my:adminFilterCate />
			<my:adminFilterTotal searchItems="주문번호,상품명,브랜드명" />
		</my:adminTableFilter>
	</form>
	<!-- 필터 end -->
	
	<!-- 리뷰 테이블 -->
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
					<col style="width: 6%" />
					<!-- code -->
					<col style="width: 3%" />
					<col style="width: 11%" />
					<!-- img + 상품명 -->
					<col style="width: 17%" />
					<!-- 카테고리 -->
					<col style="width: 20%" />
					<!-- 내용 -->
					<col style="width: 10%" />
					<!-- 주문번호 -->
					<col style="width: 11%" />
					<!-- 작성일 -->
					<col style="width: 10%" />
					<!-- 별점 -->
					<col style="width: 7%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>code</th>
						<th colspan="2">상품명</th>
						<!-- <th></th> -->
						<th>카테고리</th>
						<th>내용</th>
						<th>주문번호</th>
						<th>작성일</th>
						<th>별점</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody id="conRvTbl">
					<tr data-group="cq-1" data-main="true">
						<td>112525</td>
						<td>R123456</td>
						<td class="img_cell coll"
							style="border-right: none; justify-content: flex-start"><img
							src="./image/no-image.svg" /></td>
						<td class="title_cell" style="padding-left: 3px">쏘내추럴 올 데이
							메이크업 픽서 120ml (안개분사 캔타입)</td>
						<td>뷰티소품 > 네일/바디소품 > 바디용품</td>
						<td class="title_cell">쏘내추럴 올 데이 메이크업 픽서 120ml (안개분사 캔타입)쏘내추럴
							올 데이 메이크업 픽서 120ml (안개분사 캔타입)쏘내추럴 올 데이 메이크업 픽서 120ml (안개분사
							캔타입)쏘내추럴 올 데이 메이크업 픽서 120ml (안개분사 캔타입)</td>
						<td>20250907-12345</td>
						<td>2025-09-11 11:12:13</td>
						<td>[별점]</td>
						<td class="detail_cell reply_view"><i
							class="bi bi-chevron-compact-down"></i></td>
					</tr>
					<!-- 문의 내용 보기 -->
					<tr class="question_detail" data-group="cq-1"
						style="display: none; border-top: none">
						<td class="detail_icon"><i class="bi bi-caret-right-fill"></i></td>
						<td class="detail_body" colspan="9">
							<div id="detail-1" class="pd_info">
								<div class="pd_img">
									<img src="" />
								</div>
								<div>
									<div>[스테디셀러특가/3년연속1위] 어노브 딥 데미지 헤어 트리트먼트 EX 320ml 더블/듀오
										한정기획 4종 택1</div>
									<div>[태그]</div>
								</div>
							</div>
							<div class="detail-panel">
								월별 판매 리포트에 카테고리별 비교 그래프 추가 요청. <br /> 데이터 파이프라인 검토 필요. 월별 판매
								리포트에 카테고리별 비교 그래프 추가 요청. <br /> 월별 판매 리포트에 카테고리별 비교 그래프 추가 요청.
								<br /> 월별 판매 리포트에 카테고리별 비교 그래프 추가 요청. <br />
							</div>
						</td>
					</tr>
					<!-- 문의 내용 보기 end -->
					<!-- 답글 내용보기 -->
					<tr class="reply_detail" data-group="cq-1" style="display: none">
						<td class="reply_icon"><i class="bi bi-arrow-return-right"></i></td>
						<td class="reply_body" colspan="7">
							<div id="replyDetail-1" class="replyDetail-panel">
								월별 판매 리포트에 카테고리별 비교 그래프 추가 요청 답변. <br /> 데이터 파이프라인 검토 필요. 월별 판매
								리포트에 카테고리별 비교 그래프 추가 요청 답변. <br />
							</div>
						</td>
						<td class="replyed_date" colspan="2">
							<div>2025-09-17 03:58:58</div>
							<div>브랜드명</div>
						</td>
					</tr>
					<!-- 답글 내용보기 end -->
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