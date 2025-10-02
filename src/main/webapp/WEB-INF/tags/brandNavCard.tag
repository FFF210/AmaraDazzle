<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
     BrandNavCard 커스텀 태그

     속성(Props)
     • brandName : 브랜드명
     • logoUrl   : 브랜드 로고 이미지 경로
     • likes     : 좋아요 수 (기본값 0)

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:brandNavCard 
       brandName="바이오던스" 
       logoUrl="https://placehold.co/64x64" 
       likes="500" />
================================ --%>

<%@ attribute name="brandName" required="false"%>
<%@ attribute name="logoUrl" required="false"%>
<%@ attribute name="likes" required="false"%>

<c:set var="brandName" value="${empty brandName ? '브랜드명' : brandName}" />
<c:set var="logoUrl"
	value="${empty logoUrl ? 'https://placehold.co/64x64' : logoUrl}" />
<c:set var="likes" value="${empty likes ? '0' : likes}" />

<div class="brand-link">
	<div class="brand-wrapper">
		<!-- 좌측 브랜드 로고 -->
		<div class="brand-logo">
			<img src="${logoUrl}" alt="${brandName} 로고" />
		</div>

		<!-- 중앙 브랜드 정보 -->
		<div class="brand-info">
			<p class="brand-label">브랜드관</p>
			<p class="brand-name">
				<strong>${brandName}</strong> 바로가기 <i class="bi bi-chevron-right"></i>
			</p>
		</div>
	</div>

	<!-- 찜 버튼 -->
	<div class="wishlist-btn">
		<my:heartBtn state="${heartState}" onlyIcon="true" hasCount="false" />
	</div>
</div>
