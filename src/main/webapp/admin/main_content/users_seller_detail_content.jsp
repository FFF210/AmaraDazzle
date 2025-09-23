<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<!-- 메인부분 -->
<!-- 상단  판매자정보 -->
<div class="profile">
	<div class="info_image">
		<div class="thumbnail"></div>
		<div class="brandStoreBtn">
			<button type="button" class="btn">브랜드 스토어 보기</button>
		</div>
	</div>
	<div class="info_table">
		<table id="seller_info">
			<tr>
				<th>회원 타입</th>
				<td>Seller</td>
				<th>code</th>
				<td>S250829801</td>
			</tr>
			<tr>
				<th>브랜드명</th>
				<td></td>
				<th>담당자명</th>
				<td></td>
			</tr>
			<tr>
				<th>사업자번호</th>
				<td></td>
				<th>이메일</th>
				<td></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td></td>
				<th>구독여부</th>
				<td></td>
			</tr>
			<tr>
				<th>수수료율</th>
				<td></td>
				<th>정산 계좌</th>
				<td></td>
			</tr>
			<tr>
				<th>가입일</th>
				<td></td>
				<th>활동 여부</th>
				<td></td>
			</tr>
		</table>
	</div>
</div>
<!-- 상단  판매자정보 end -->
<!-- 탭 -->
<div class="info_tab">
	<div class="tabs">
		<div class="tab active" data-tab="calculate"
			onclick="showTab('calculate')">정산내역</div>
		<div class="tab" data-tab="product" onclick="showTab('product')">상품</div>
		<div class="tab" data-tab="payment" onclick="showTab('payment')">결제내역</div>
		<div class="tab" data-tab="question" onclick="showTab('question')">일대일문의</div>
	</div>
</div>
<!-- 탭 end -->

<!-- ========== 내용(정산내역) ========== -->
<%@ include file="./users_seller_d_calc.jsp"%>
<!-- ========== 내용(정산내역) end ========== -->


<!-- ========== 내용(상품) ========== -->
<%@ include file="./users_seller_d_pd.jsp"%>
<!-- ========== 내용(상품) end ========== -->


<!-- ========== 내용(결제내역) ========== -->
<%@ include file="./users_seller_d_pm.jsp"%>
<!-- ========== 내용(결제내역) ========== -->


<!-- ========== 내용(일대일문의) ========== -->
<%@ include file="./users_seller_d_qna.jsp"%>
<!-- ========== 내용(일대일문의) end ========== -->


</main>
<!-- 메인부분 -->