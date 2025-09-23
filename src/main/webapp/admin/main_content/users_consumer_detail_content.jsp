<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<!-- 메인부분 -->
<!-- 상단  회원정보 -->
<div class="profile">
	<!-- <div class="info_image">
                            <div class="thumbnail"></div>
                            <div class="brandStoreBtn">
                                <button type="button" class="btn">브랜드 스토어 보기</button>
                            </div>
                        </div> -->
	<div class="info_table">
		<table id="seller_info">
			<tr>
				<th>회원 타입</th>
				<td>Consumer</td>
				<th>code</th>
				<td>C250829801</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td></td>
				<th>휴대폰번호</th>
				<td></td>
			</tr>
			<tr>
				<th>이름</th>
				<td></td>
				<th>닉네임</th>
				<td></td>
			</tr>
			<tr>
				<th>누적 주문금액</th>
				<td></td>
				<th>최근 6개월 누적주문금액</th>
				<td></td>
			</tr>
			<tr>
				<th>등급</th>
				<td></td>
				<th>마케팅수신동의</th>
				<td></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td></td>
				<th>성별</th>
				<td></td>
			</tr>
			<tr>
				<th>보유쿠폰</th>
				<td></td>
				<th>보유포인트</th>
				<td>1,000 / 5,000</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td></td>
				<th>마지막 방문일</th>
				<td></td>
			</tr>
		</table>
	</div>
</div>
<!-- 상단  회원정보 end -->
<!-- 탭 -->
<div class="info_tab">
	<div class="tabs">
		<div class="tab active" data-tab="order" onclick="showTab('order')">주문내역</div>
		<div class="tab" data-tab="questions" onclick="showTab('questions')">문의글</div>
		<div class="tab" data-tab="review" onclick="showTab('review')">리뷰</div>
		<div class="tab" data-tab="coupon" onclick="showTab('coupon')">쿠폰</div>
		<div class="tab" data-tab="point" onclick="showTab('point')">포인트</div>
	</div>
</div>
<!-- 탭 end -->


<!-- ========== 내용(주문내역) ========== -->
<%@ include file="./users_consumer_d_od.jsp"%>
<!-- ========== 내용(주문내역) end ========== -->



<!-- ========== 내용(문의) ========== -->
<%@ include file="./users_consumer_d_qna.jsp"%>
<!-- ========== 내용(문의) end ========== -->



<!-- ========== 내용(리뷰) ========== -->
<%@ include file="./users_consumer_d_rv.jsp"%>
<!-- ========== 내용(리뷰) end ========== -->



<!-- ========== 내용(쿠폰) ========== -->
<%@ include file="./users_consumer_d_cp.jsp"%>
<!-- ========== 내용(쿠폰) ========== -->



<!-- ========== 내용(포인트) ========== -->
<%@ include file="./users_consumer_d_pnt.jsp"%>
<!-- ========== 내용(포인트) ========== -->
