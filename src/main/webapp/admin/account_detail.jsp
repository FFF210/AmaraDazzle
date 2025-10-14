<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>
<title>정산내역 상세보기</title>

<link rel="stylesheet" href="./css/accounts.css" />
<!-- 헤드부분 end -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
<section class="main_content">
	<div class="seller_info_header">
		<div class="seller_info_img">
			<img src="./image/logo_black.svg" />
		</div>
		<div>아비브 [ S123456 ]</div>
	</div>

	<!-- 정산월, 상태 -->
	<div class="calc_info">
		<div class="calc_mon">
			<input type="text" value="2025년 8월" class="text_readonly" readonly />
		</div>
		<div class="calc_status">[정산상태]</div>
	</div>
	<!-- 정산월, 상태 end -->

	<!-- 테이블 -->
	<div class="info_table">
		<div class="unit_info">
			<span><b>금액단위 : 원</b></span>
		</div>
		<table id="calculation_info">
			<tr>
				<th>당월 누적 주문건수</th>
				<td>12,345,678,900</td>
				<th>당월 누적 판매 개수</th>
				<td>12,345,678,900</td>
			</tr>
			<tr>
				<th>당월 총 매출</th>
				<td class="price_cell">100,000,000</td>
				<th>배송비</th>
				<td class="price_cell">2,400,000</td>
			</tr>
			<tr>
				<th>판매자 쿠폰</th>
				<td class="price_cell">600,000</td>
				<th>플랫폼 쿠폰</th>
				<td class="price_cell">600,000</td>
			</tr>
			<tr>
				<th>포인트</th>
				<td class="price_cell">150,000</td>
				<th>당월 순수 매출액</th>
				<td class="price_cell">97,300,000</td>
			</tr>
			<tr>
				<th>수수료 (7%)</th>
				<td class="price_cell">6,811,000</td>
				<th style="color: red">최종 정산금액</th>
				<td class="price_cell">92,289,000</td>
			</tr>
			<tr>
				<th>입금계좌정보</th>
				<td>신한 110-409-****22 이명헌</td>
				<th style="color: red">최종 입금액</th>
				<td class="price_cell" style="color: red">92,289,000</td>
			</tr>
			<tr>
				<th>정산완료일자</th>
				<td>2025-09-01 12:13:14</td>
				<th>입금일자</th>
				<td>2025-09-10 12:13:14</td>
			</tr>
		</table>
	</div>

	<div class="description">
		<div>
			<div class="desc" style="text-align: right; margin: 15px 0">
				<b>예시 : </b>
			</div>
			<div class="desc">
				1. 순수매출액(수수료 과세 기준) <br /> 
				<i class="bi bi-dot"></i>총매출 100,000,000 <br /> 
				<i class="bi bi-dot"></i>구매자 배송비 제외 - 2,400,000 <br /> 
				<i class="bi bi-dot"></i>플랫폼 쿠폰/포인트 보전 + 300,000 <br /> 
				<i class="bi bi-dot"></i>판매자 쿠폰 - 600,000 <br />
				&nbsp;&nbsp;&nbsp;&nbsp;= 97,300,000원 <br />
			</div>
			<div class="desc">
				2. 플랫폼 이용수수료 (7%) <br />
				<i class="bi bi-dot"></i>97,300,000 x 7% = 6,811,000원 <br />
			</div>
			<div class="desc">
				3. 최종 정산액(판매자 수령) <br /> 
				<i class="bi bi-dot"></i>(순수매출액 - 수수료) + (구매자 배송비 - 판매자 부담 배송비)<br /> 
				&nbsp;&nbsp;&nbsp;&nbsp;= (97,300,000 - 6,811,000) + (2,400,000 - 600,000) <br />
				&nbsp;&nbsp;&nbsp;&nbsp;= 90,489,000 + 1,800,000 <br />
				&nbsp;&nbsp;&nbsp;&nbsp;= 92,289,000원
			</div>

			<div class="desc">
				<i class="bi bi-arrow-right-circle"></i> &nbsp;결론 <br /> 
				<i class="bi bi-dot"></i>당월 순수매출액: 97,300,000원 <br /> 
				<i class="bi bi-dot"></i>판매자 최종 정산액: 92,289,000원<br />
			</div>
		</div>
	</div>

	<div class="button_box">
		<button type="button" class="btn first_btn action_btn">정산확인</button>
	</div>
</section>
<!-- 메인부분 -->
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->



	<!-- JS부분 -->
	<!-- JS부분 end -->

</body>
</html>