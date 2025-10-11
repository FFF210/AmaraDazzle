<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
    ReviewCard 커스텀 태그

    속성(Props)
    • nickname  : 작성자 닉네임
    • skinType  : 피부타입/조건 (예: 지성/민감성/여드름)
    • rating    : 별점 (1~5)
    • date      : 작성일 (yyyy.MM.dd)
    • option    : 선택 옵션명
    • content   : 리뷰 본문
    • images    : 리뷰 이미지 경로들 (쉼표로 구분)

    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <my:reviewCard 
      nickname="닉네임" 
      skinType="지성/민감성/여드름"
      rating="5" 
      date="2025.09.04" 
      option="옵션에 대한 이름" 
      content="리뷰 본문 내용입니다." 
      images="/img/review1.png,/img/review2.png,/img/review3.png" />
================================ --%>

<%@ attribute name="nickname" required="true"%>
<%@ attribute name="skinType" required="true"%>
<%@ attribute name="rating" required="true"%>
<%@ attribute name="date" required="true"%>
<%@ attribute name="option" required="false"%>
<%@ attribute name="content" required="true"%>
<%@ attribute name="images" required="false"%> 
<%@ attribute name="dataRating" required="false"%>
<%@ attribute name="dataDate" required="false"%>


<c:set var="imageList"
	value="${empty images ? null : fn:split(images, ',')}" />

<div class="review-card" data-rating="${dataRating}" data-date="${dataDate}">
	<!-- 왼쪽 : 작성자 정보 -->
	<div class="review-author">
		<p class="nickname">${nickname}</p>
		<p class="skin-type">${skinType}</p>
	</div>

	<!-- 오른쪽 : 리뷰 내용 -->
	<div class="review-body">
		<div class="review-header">
			<my:rating rating="${rating}" readonly="true" />
			<span class="review-date">${date}</span>
		</div>

		<c:if test="${not empty option}">
			<div class="review-option">[옵션] - ${option}</div>
		</c:if>

		<div class="review-content">${content}</div>

		<c:if test="${not empty imageList}">
			<div class="review-images">
				<c:forEach var="img" items="${imageList}">
					<img src="${img}" alt="리뷰 이미지" />
				</c:forEach>
			</div>
		</c:if>
	</div>
</div>
