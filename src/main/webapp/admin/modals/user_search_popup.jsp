<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 검색 팝업 -->
<div class="modal hidden modal_search_box">
	<div class="modal_title">
		<b>회원 검색</b>
	</div>
	<div class="search_container">
		<div class="filter">
			<div style="display: flex; align-items: center">
				<div class="answer_box" style="margin-right: 15px">
					<div class="filtering_title">
						<span class="searchbox_title">등급 : </span>
					</div>
					<div class="answer_body">
						<div class="choice ch">
							<input type="button" value="전체" />
						</div>
						<div class="choice ch">
							<input type="button" value="VIP" />
						</div>
						<div class="choice ch">
							<input type="button" value="GOLD" />
						</div>
						<div class="choice ch">
							<input type="button" value="SILVER" />
						</div>
						<div class="choice">
							<input type="button" value="일반" />
						</div>
					</div>
				</div>
				<div>
					<label><input type="checkbox" /> 모든 회원</label>
				</div>
			</div>
			<div class="totalSearch_box">
				<div class="searchType">
					<select>
						<option>검색유형</option>
						<option>검색유형</option>
						<option>검색유형</option>
						<option>검색유형</option>
					</select>
				</div>
				<div class="searchKeyword">
					<i class="bi bi-search"></i><input type="text" placeholder="Search" />
				</div>
			</div>
		</div>

		<div class="btn_box">
			<input type="submit" class="btn first_btn" value="검색" /> <input
				type="reset" class="btn second_btn" value="초기화" />
		</div>
	</div>

	<!-- 팝업테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span>[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 3%" />
					<!--체크박스-->
					<col style="width: 5%" />
					<!-- 번호 -->
					<col style="width: 20%" />
					<!-- 회원아이디 -->
					<col style="width: 10%" />
					<!-- 회원명 -->
					<col style="width: 10%" />
					<!-- 회원코드 -->
					<col style="width: 5%" />
					<!-- 등급 -->
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" /></th>
						<th>#</th>
						<th>회원아이디</th>
						<th>회원명</th>
						<th>code</th>
						<th>등급</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" /></td>
						<td>10</td>
						<td>abc123@naver.com</td>
						<td>정이현</td>
						<td>C123456</td>
						<td>VIP</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>10</td>
						<td>abc123@naver.com</td>
						<td>정이현</td>
						<td>C123456</td>
						<td>VIP</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>10</td>
						<td>abc123@naver.com</td>
						<td>정이현</td>
						<td>C123456</td>
						<td>VIP</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>10</td>
						<td>abc123@naver.com</td>
						<td>정이현</td>
						<td>C123456</td>
						<td>VIP</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>10</td>
						<td>abc123@naver.com</td>
						<td>정이현</td>
						<td>C123456</td>
						<td>VIP</td>
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
	<div class="button_box">
		<button type="button" class="btn first_btn search_btn"
			id="modal_selectBtn">선택</button>
	</div>
</div>
<!-- 검색 팝업 end -->