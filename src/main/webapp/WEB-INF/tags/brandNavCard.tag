<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
     BrandNavCard 커스텀 태그

     속성(Props)
     • brandName : 브랜드명
     • logoFileId   : 브랜드 로고 이미지 id
     • isWished     : 좋아요 여부
     • href       : 클릭 시 이동할 링크 (예: /store/productDetail?productId=...)

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:brandNavCard 
       brandName="바이오던스" 
       logoFileId=3 
       isWished=1 />
================================ --%>

<%@ attribute name="brandId" required="false"%>
<%@ attribute name="brandName" required="false"%>
<%@ attribute name="logoFileId" required="false"%>
<%@ attribute name="isWished" required="false"%>
<%@ attribute name="href" required="false"%>

<c:choose>
	<c:when test="${not empty logoFileId}">
		<c:set var="logoFileUrl"
			value="${pageContext.request.contextPath}/image?fileId=${logoFileId}" />
	</c:when>
	<c:otherwise>
		<c:set var="logoFileUrl"
			value="${pageContext.request.contextPath}/image/placeholder.png" />
	</c:otherwise>
</c:choose>

<c:set var="brandName" value="${empty brandName ? '브랜드명' : brandName}" />
<c:set var="heartState" value="${isWished == 1 ? 'active' : 'default'}" />

<a class="brand-link" data-brandid="${brandId}"
	<c:if test="${not empty href}"> href="${href}" </c:if>>
	
	<div class="brand-wrapper">
		<!-- 좌측 브랜드 로고 -->
		<div class="brand-logo">
			<img src="${logoFileUrl}" alt="로고 이미지" width="90px" />
		</div>

		<!-- 중앙 브랜드 정보 -->
		<div class="brand-info">
			<p class="brand-label">브랜드관</p>
			<p class="brand-name">
				<strong>${brandName}</strong> 바로가기 <i class="bi bi-chevron-right"></i>
			</p>
		</div>
	</div> <!-- 찜 버튼 -->
	<div class="wishlist-btn">
		<my:heartBtn state="${heartState}" onlyIcon="true" hasCount="false" />
	</div>
</a>
