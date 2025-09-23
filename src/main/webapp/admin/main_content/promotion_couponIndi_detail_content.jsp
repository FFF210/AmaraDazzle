<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- 메인부분 -->
<section class="main_content">
	<!-- 회원정보 테이블 -->
	<div class="info_table" style="margin: 50px auto">
		<div class="table_title">
			<b>회원 정보</b>
		</div>
		<table id="user_info">
			<tr>
				<th>회원아이디</th>
				<td>abc123@naver.com</td>
				<th>code</th>
				<td>C12345678</td>
			</tr>
			<tr>
				<th>회원명</th>
				<td>김나라</td>
				<th></th>
				<td></td>
			</tr>
		</table>
	</div>

	<!-- 쿠폰 정보 테이블 -->
	<div class="info_table" style="margin: 0 auto 20px">
		<div class="table_title">
			<b>쿠폰 상세</b>
		</div>
		<table id="coupon_info">
			<tr>
				<th>쿠폰명</th>
				<td>리쇼라 30만원 할일</td>
				<th>쿠폰코드</th>
				<td>lINzCaiPwuLDIGPcdNdB</td>
			</tr>
			<tr>
				<th>할인액</th>
				<td>300,000</td>
				<th>조건</th>
				<td><span>300만원 이상 </span>구매시 사용가능</td>
			</tr>
			<tr>
				<th>발행일자</th>
				<td>2025-09-08 11:20-36</td>
				<th>유효기간</th>
				<td>2025-09-08 ~ 2025-09-18</td>
			</tr>
			<tr>
				<th>지급사유</th>
				<td>민원 발생</td>
				<th>중복 지급 여부</th>
				<td>중복 지급 불가</td>
			</tr>
			<tr>
				<th>지급대상</th>
				<td>개별회원</td>
				<th>발급제한수량</th>
				<td>-</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td>사용완료</td>
				<th>쿠폰상태</th>
				<td>사용완료</td>
			</tr>
			<tr>
				<th>사용일</th>
				<td>2025-09-08 12:30:25</td>
				<th>주문번호</th>
				<td>20250908-0214587</td>
			</tr>
		</table>
	</div>

	<div class="part_section writer_part">
		<div class="part_title title_font">
			<b>발행자</b>
		</div>
		<div class="writer_part">
			<input type="text" class="text_readonly" value="쿠폰발향한 관리자 이름"
				readonly />
		</div>
	</div>
</section>
<!-- 메인부분 -->