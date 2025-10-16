<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>ADMIN - Users 사업자회원 상세보기</title>
<link rel="stylesheet" href="./css/componant/detail_tab.css" />
<link rel="stylesheet" href="./css/user_seller.css" />
<!-- 헤드부분 -->

<body>
	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
		<!-- 상단  판매자정보 -->
		<div class="profile">
			<div class="info_image">
				<div class="thumbnail">
					<c:if test="${brand.logoFileId eq null}">
						<img src="/image/no-image.svg">
					</c:if> 
					<c:if test="${brand.logoFileId ne null}">
						<img src="${contextPath}/upload_file/${brand.fileRename}">
					</c:if>
				</div>
				<div class="brandStoreBtn">
					<button type="button" class="btn goStoreBtn">브랜드 스토어 보기</button>
					<c:if test="${brand.brandStatus == 'APPLY_SUBMITTED'}">
						<button type="button" class="btn appBtn">가입 승인</button>
					</c:if>
				</div>
			</div>
			
			<c:set var="createDate" value="${brand.createdAt}" /> 
			<div class="info_table">
				<table id="seller_info">
					<tr>
						<th>회원 타입</th>
						<td>Seller</td>
						<th>브랜드명</th>
						<td>${brand.brandName}</td>
					</tr>
					<tr>
						<th>사업자번호</th>
						<td>${brand.brn}</td>
						<th>아이디</th>
						<td>${brand.email}</td>
					</tr>
					<tr>
						<th>담당자명</th>
						<td>${brand.managerName}</td>
						<th>연락처</th>
						<td>${brand.phone}</td>
					</tr>
					<tr>
						<th>구독여부</th>
						<td></td>
						<th>수수료율</th>
						<td>7%</td>
					</tr>
					<tr>
						<th>정산일</th>
						<td>${brand.settlementDate} </td>
						<th>정산 계좌</th>
						<td>${brand.bank} ${brand.accountNumber} ${brand.accountHolder}</td>
					</tr>
					<tr>
						<th>가입일</th>
						<td>${fn:substring(createDate,0,19)}</td>
						<th>활동상태</th>
						<td>
						<c:choose>
							<c:when test="${brand.brandStatus == 'APPLY_SUBMITTED' }">
								<my:tag color="gray" size="md" text="승인대기" />
							</c:when>
							<c:when test="${brand.brandStatus == 'APPROVED'}">
								<my:tag color="blue" size="md" text="승인완료" />
							</c:when>
							<c:when test="${brand.brandStatus == 'SIGNUP_COMPLETED'}">
								<my:tag color="yellow" size="md" text="가입완료" />
							</c:when>
						</c:choose>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- 상단  판매자정보 end -->
		<!-- 탭 -->
		<div class="info_tab">
			<div class="tabs">
				<div class="tab active" data-tab="calculate" onclick="showTab('calculate')">정산내역</div>
				<div class="tab" data-tab="product" onclick="showTab('product')">상품</div>
				<div class="tab" data-tab="payment" onclick="showTab('payment')">결제내역</div>
				<div class="tab" data-tab="question" onclick="showTab('question')">일대일문의</div>
			</div>
		</div>
		<!-- 탭 end -->

		<!-- ========== 내용(정산내역) ========== -->
		<%@ include file="./main_content/users_seller_d_calc.jsp"%>
		<!-- ========== 내용(정산내역) end ========== -->


		<!-- ========== 내용(상품) ========== -->
		<%@ include file="./main_content/users_seller_d_pd.jsp"%>
		<!-- ========== 내용(상품) end ========== -->


		<!-- ========== 내용(결제내역) ========== -->
		<%@ include file="./main_content/users_seller_d_pm.jsp"%>
		<!-- ========== 내용(결제내역) ========== -->


		<!-- ========== 내용(일대일문의) ========== -->
		<%@ include file="./main_content/users_seller_d_qna.jsp"%>
		<!-- ========== 내용(일대일문의) end ========== -->

		<!-- 메인부분 -->
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