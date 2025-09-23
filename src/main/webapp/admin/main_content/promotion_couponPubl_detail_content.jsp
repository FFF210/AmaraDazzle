<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- 메인부분 -->
<section class="main_content">
	<!-- 테이블 -->
	<div class="info_table" style="margin: 50px auto 10px">
		<table id="coupon_info">
			<tr>
				<th>쿠폰명</th>
				<td>리쇼라 30만원 할일</td>
				<th>쿠폰코드</th>
				<td>lINzCaiPwuLDIGPcdNdB</td>
			</tr>
			<tr>
				<th>발행일자</th>
				<td>2025-09-08 11:20-36</td>
				<th>유효기간</th>
				<td>지급일로부터 10일</td>
			</tr>
			<tr>
				<th>할인액</th>
				<td>300,000</td>
				<th>조건</th>
				<td><span>300만원 이상 </span>구매시 사용가능</td>
			</tr>
			<tr>
				<th>지급사유</th>
				<td>회원 직접 발급</td>
				<th>중복 지급 여부</th>
				<td>중복 지급 불가</td>
			</tr>
			<tr>
				<th>지급대상</th>
				<td>전체회원</td>
				<th>발급제한수량</th>
				<td>500 매</td>
			</tr>
		</table>
	</div>

	<div class="button_box">
		<button type="button" class="btn first_btn action_btn">노출중지</button>
		<button type="button" class="btn second_btn action_btn">삭제</button>
	</div>
</section>
<!-- 메인부분 -->