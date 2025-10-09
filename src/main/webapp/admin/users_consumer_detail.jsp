<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>Users 일반회원 상세보기</title>
<link rel="stylesheet" href="./css/componant/detail_tab.css" />
<link rel="stylesheet" href="./css/user_consumer.css" />
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
		<!-- 상단  회원정보 -->
		<div class="profile">
			<c:set var="createDate" value="${member.createdAt}" /> 
			<div class="info_table">
				<table id="seller_info">
					<tr>
						<th>회원 타입</th>
						<td>Consumer</td>
						<th>아이디</th>
						<td>${member.email}</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${member.name}</td>
						<th>닉네임</th>
						<td>${member.nickname}</td>
					</tr>
					<tr>
						<th>휴대폰번호</th>
						<td>${member.phone}</td>
						<th></th>
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
						<td>
						<c:choose>
							<c:when test="${member.grade == 'VIP'}">
								<my:tag color="pink" size="md" text="VIP" />
							</c:when>
							<c:when test="${member.grade == 'GOLD'}">
								<my:tag color="blue" size="md" text="GOLD" />
							</c:when>
							<c:when test="${member.grade == 'SILVER'}">
								<my:tag color="green" size="md" text="SILVER" />
							</c:when>
							<c:when test="${member.grade == 'NORMAL'}">
								<my:tag color="yellow" size="md" text="일반" />
							</c:when>
						</c:choose>
						
						</td>
						<th>마케팅수신동의</th>
						<td>
							<c:if test="${member.marketingOpt eq 0}"> N </c:if>
							<c:if test="${member.marketingOpt eq 1}"> Y </c:if>
						</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>${member.birthDate}</td>
						<th>성별</th>
						<td>${member.gender}</td>
					</tr>
					<tr>
						<th>퍼스널컬러</th>
						<td></td>
						<th>피부타입</th>
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
						<td>${fn:substring(createDate,0,19)}</td>
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
		<%@ include file="./main_content/users_consumer_d_od.jsp"%>
		<!-- ========== 내용(주문내역) end ========== -->



		<!-- ========== 내용(문의) ========== -->
		<%@ include file="./main_content/users_consumer_d_qna.jsp"%>
		<!-- ========== 내용(문의) end ========== -->



		<!-- ========== 내용(리뷰) ========== -->
		<%@ include file="./main_content/users_consumer_d_rv.jsp"%>
		<!-- ========== 내용(리뷰) end ========== -->



		<!-- ========== 내용(쿠폰) ========== -->
		<%@ include file="./main_content/users_consumer_d_cp.jsp"%>
		<!-- ========== 내용(쿠폰) ========== -->



		<!-- ========== 내용(포인트) ========== -->
		<%@ include file="./main_content/users_consumer_d_pnt.jsp"%>
		<!-- ========== 내용(포인트) ========== -->

	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->


	<!-- JS부분 -->
	<script src="../tagjs/selectbox.js"></script>
	<script src="../tagjs/dateInput.js"></script>
	<script src="./js/common/table.js"></script>
	<script src="./js/users.js"></script>
	<script src="./js/user_detail.js"></script>
	<!-- JS부분 end -->

</body>
</html>