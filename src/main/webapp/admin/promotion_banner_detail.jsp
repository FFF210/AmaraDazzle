<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/> 

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>ADMIN - 메인배너 신청건 상세보기</title>
<link rel="stylesheet" href="./css/boards_detailview.css" />
<link rel="stylesheet" href="./css/banner.css" />
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- *********************************메인부분********************************* -->
		<section class="board_detailview">
			<div class="part_section">
				<div class="part_title">게시 여부</div>
				<div class="part_content">
					<c:choose>
						<c:when test="${banner.stateChange == 'POSTING' }">
							<!-- 게시여부 : 게시중 -->
							<my:tag color="yellow" size="md" text="게시중" />
						</c:when>
						<c:when test="${banner.stateChange == 'OFF'}">
							<!-- 게시여부 : 노게시 -->
							<my:tag color="gray" size="md" text="비공개" />
						</c:when>
					</c:choose>

				</div>
			</div>
			<div class="part_section">
				<div class="part_title">게시 상태</div>
				<div class="part_content">
					<c:choose>
						<c:when test="${banner.status == 'PENDING' }">
							<my:tag color="red" size="md" text="승인대기" />
						</c:when>
						<c:when test="${banner.status == 'APPROVED'}">
							<my:tag color="blue" size="md" text="승인완료" />
						</c:when>
						<c:when test="${banner.status == 'ONGOING' }">
							<my:tag color="yellow" size="md" text="진행중" />
						</c:when>
						<c:when test="${banner.status == 'COMPLETED' }">
							<my:tag color="green" size="md" text="완료" />
						</c:when>
						<c:when test="${banner.status == 'CANCELED' }">
							<my:tag color="gray" size="md" text="취소" />
						</c:when>
					</c:choose>

				</div>
			</div>
			<div class="part_section">
			</div>
			
			<c:if test="${banner.brandId ne null}">
			<div class="brand_info">
				<!--  style="display: none" -->
				<div class="part_section brand_part">
					<div class="part_title">브랜드명</div>
					<div class="part_content">
						<input type="text" class="text_readonly" value="${banner.brandName}" readonly />
					</div>
				</div>

				<div class="part_section manager_part">
					<div class="part_title">신청담당자명</div>
					<div class="part_content">
						<input type="text" name="managerName" class="text_readonly" value="${banner.managerName}" readonly /> 
						<input type="text" name="managerPhone" class="text_readonly" value="${banner.managerTel}" readonly />
					</div>
				</div>

				<div class="part_section message_part">
					<div class="part_title">전달사항</div>
					<div class="part_content">
						<div class="content_part">${banner.bannerMessage}</div>
					</div>
				</div>

				<div class="part_section pay_part">
					<div class="part_title">결제금액</div>
					<div class="part_content">
					<c:set var="pay_amount" value="${banner.payAmount}" /> 
					<fmt:formatNumber value="${pay_amount}" pattern="#,###" />
						<input type="text" name="payAmount" class="text_readonly" value="${banner.brandName}" readonly /> 원
					</div>
				</div>
				<hr />
			</div>
			</c:if>
			
			<div class="part_section title_part">
				<div class="part_title">제목</div>
				<div class="part_content">
					<input type="text" name="bannerName" value="${banner.bannerName}" readonly />
				</div>
			</div>

			<div class="part_section period_part">
				<div class="part_title">진행기간</div>
				<div class="part_content">
					<c:set var="startDate" value="${banner.startDate}" /> 
					<c:set var="endDate" value="${banner.endDate}" /> 
					<input type="text" name="bannerPeriod" value="${fn:substring(startDate,0,19)} ~ ${fn:substring(endDate,0,19)}" readonly />
				</div>
			</div>

			<div class="part_section thumb_part">
				<div class="part_title">배너이미지</div>
				<div class="part_content">
					<div class="img_content">
						<img src="${contextPath}/upload_file/${banner.fileRename}">
					</div>
					<div class="text_content">
						<a href="">${banner.fileName}</a>
					</div>
				</div>
			</div>

			<div class="part_section content_part">
				<div class="part_title">연결된 URL</div>
				<div class="part_content">
					<div class="link_part">
						<a name="linkUrl" href="${banner.brandUrl}">${banner.brandUrl}</a>
					</div>
				</div>
			</div>

			<div class="part_section bottom_part">
				<div class="part_title">작성자</div>
				<div class="part_content">
					<div class="writer_part" style="width: 50%">
						${aname}
						<input type="hidden" name="aName" value="${aidx}" />
					</div>
					<div class="btn_part">
						<!-- <button type="button" class="btn second_btn action_btn">미리보기</button> -->
						<button type="button" class="btn first_btn action_btn">승인</button>
					</div>
				</div>
			</div>
		</section>
		<!-- *********************************메인부분 end********************************* -->
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->





	<!-- JS부분 -->
	<!-- JS부분 end -->

</body>
</html>