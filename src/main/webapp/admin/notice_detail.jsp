<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/> 


<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>공지 내용보기</title>
<link rel="stylesheet" href="./css/boards_detailview.css" />

<!-- 헤드부분 -->

<body>
	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- *********************************메인부분********************************* -->
		<section class="board_detailview">
			<div class="part_section">
				<div class="part_title">노출여부</div>
				<div class="part_content">
					<c:choose>
						<c:when test="${notice.isExposed == '1' }">
							<!-- 게시여부 : 게시중 -->
							<my:tag color="yellow" size="md" text="게시중" />
						</c:when>
						<c:when test="${notice.isExposed == '0'}">
							<!-- 게시여부 : 노게시 -->
							<my:tag color="gray" size="md" text="비공개" />
						</c:when>
					</c:choose>

				</div>
			</div>
			<div class="part_section cate_part">
				<div class="part_title">카테고리</div>
				<div class="part_content">
					<c:choose>
						<c:when test="${notice.typeId == '25' || notice.typeId == '29'}">
							<!-- 카테고리 : 이벤트 -->
							<my:tag color="pink" size="md" text="${notice.name}" />
						</c:when>
						<c:when test="${notice.typeId == '26' || notice.typeId == '28'}">
							<!-- 카테고리 : 점검 / 시스템 -->
							<my:tag color="green" size="md" text="${notice.name}" />
						</c:when>
						<c:when test="${notice.typeId == '27' || notice.typeId == '30'}">
							<!-- 카테고리 : 기타 -->
							<my:tag color="blue" size="md" text="${notice.name}" />
						</c:when>
					</c:choose>

				</div>
			</div>

			<div class="part_section title_part">
				<div class="part_title">제목</div>
				<div class="part_content">
					<input type="text" value="${notice.title }" readonly />
				</div>
			</div>

			<div class="part_section">
				<div class="part_title">첨부파일</div>
				<div class="part_content">
					<c:if test="${notice.docFileId == null}">
						<span class="text_readonly">&nbsp; 첨부파일 없음</span>
					</c:if>
				</div>
			</div>

			<div class="part_section">
				<div class="part_title">내용</div>
				<div class="part_content">
					<div class="content_part">
						<div class="img_content">
							<img src="${contextPath}/upload_file/${notice.image1FileName}">
						</div>
						<div class="text_content">${notice.content } ${contextPath}
						</div>
					</div>
				</div>
			</div>

			<div class="part_section">
				<div class="part_title">작성일자</div>
				<div class="part_content">
					<c:set var="createDate" value="${notice.createdAt}" />
					&nbsp; ${fn:substring(createDate,0,19)}
				</div>
			</div>

			<div class="part_section bottom_part">
				<div class="part_title">작성자</div>
				<div class="part_content">
					<div class="writer_part">
						<span>&nbsp; Amara Dazzle</span>
					</div>
					<div class="btn_part">
						<button type="button" class="btn first_btn action_btn">수정</button>
						<button type="button" class="btn second_btn action_btn">삭제</button>
					</div>
				</div>
			</div>
		</section>
		<!-- *********************************메인부분 end********************************* -->
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->



</body>
</html>