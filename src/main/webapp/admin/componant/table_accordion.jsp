<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>테이블 밑으로 내용열리는 형식</title>
<link rel="stylesheet" href="../css/common/componant.css?v=3" />

<link rel="stylesheet" href="../css/componant/pagenation.css" />

<link rel="stylesheet" href="../css/user_seller.css" />

<!-- Bootstrap Icons CDN -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<!-- 문의 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span>[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 6%" />
					<!-- 번호 -->
					<col style="width: 8%" />
					<!-- 답변주체 -->
					<col style="width: 7%" />
					<!-- 문의유형 -->
					<col style="width: 7%" />
					<!-- code -->
					<col style="width: 4%" />
					<!-- 첨부유무 -->
					<col style="width: 30%" />
					<!-- 내용 -->
					<col style="width: 12%" />
					<!-- 작성일 -->
					<col style="width: 7%" />
					<!-- 답변여부 -->
					<col style="width: 12%" />
					<!-- 최종답변일 -->
					<col style="width: 7%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>답변주체</th>
						<th>문의유형</th>
						<th>code</th>
						<th>첨부</th>
						<th>내용</th>
						<th>작성일</th>
						<th>답변여부</th>
						<th>최종답변일</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr data-group="1" data-main="true">
						<td>112525</td>
						<td>판매자문의</td>
						<td>상품문의</td>
						<td>Q123456</td>
						<td><i class="bi bi-paperclip"></i></td>
						<td class="title_cell">[유혜주PICK/리뷰이벤트] 메디큐브 PDRN 젤리 미스트 세럼
							100ml 기획</td>
						<td>2025-09-18 11:20:30</td>
						<td>Y</td>
						<td>2025-09-18 11:30:30</td>
						<td class="detail_cell reply_view"><i
							class="bi bi-chevron-compact-down"></i></td>
					</tr>
					<!-- 문의 내용 보기 -->
					<tr class="question_detail" data-group="1" style="display: none">
						<td class="detail_icon"><i class="bi bi-caret-right-fill"></i></td>
						<td class="detail_body" colspan="9">
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
						<td class="reply_body" colspan="7">
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
						<td class="reply_body" colspan="8">
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
					<tr>
						<td>9</td>
						<td>플랫폼문의</td>
						<td>결제문의</td>
						<td>Q123456</td>
						<td></td>
						<td class="title_cell">[유혜주PICK/리뷰이벤트] 메디큐브 PDRN 젤리 미스트 세럼
							100ml 기획</td>
						<td>2025-09-18 11:20:30</td>
						<td>N</td>
						<td>-</td>
						<td class="detail_cell reply_view"><i
							class="bi bi-chevron-compact-down"></i></td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 페이지네이션 -->
		<div class="pagination_wrap" id="paginationWrap">
			<!-- Prev button -->
			<button class="pg_nav" id="btnPrev">
				<i class="bi bi-chevron-left"></i>&nbsp;Prev&nbsp;
			</button>

			<!-- Pages container -->
			<div class="pages" id="pages">
				<button type="button" class="page_item active">1</button>
				<button type="button" class="page_item">2</button>
				<button type="button" class="page_item">12</button>
				<button type="button" class="page_item">13</button>
				<button type="button" class="page_item">111</button>
				<button type="button" class="page_item">158</button>
				<button type="button" class="page_item">1589</button>
			</div>

			<!-- Next button -->
			<button class="pg_nav" id="btnNext">
				&nbsp;Next&nbsp;<i class="bi bi-chevron-right"></i>
			</button>
		</div>
		<!-- 페이지네이션 end -->
	</div>

	<script src="../js/componant/table.js"></script>
</body>
</html>
