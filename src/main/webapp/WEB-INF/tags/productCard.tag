<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<link rel="stylesheet" href="./css/heartBtn.css" />
<link rel="stylesheet" href="./css/price.css" />

<%-- ================================
     ProductCard 커스텀 태그
     
     속성(Props)
     • brand      : 문자열 (브랜드명)
     • title      : 문자열 (상품명)
     • isSale     : true | false
     • hasOption  : true | false
     • originPrice: 원가
     • saleRate   : 할인율
     • finalPrice : 최종가
     • href       : 클릭 시 이동할 링크 (예: /store/productDetail?productId=...)

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:productCard 
       brand="브랜드명"
       productId="상품아이디"
       title="상품명"
       isSale="true"
       hasOption="false"
       originPrice="10000"
       saleRate="20"
       finalPrice="8000">
       <my:tag color="green" size="sm" text="신상품" />
     </my:productCard>
================================ --%>

<%@ attribute name="brand" required="false"%>
<%@ attribute name="productId" required="false"%>
<%@ attribute name="title" required="false"%>
<%@ attribute name="isSale" required="false"%>
<%@ attribute name="hasOption" required="false"%>
<%@ attribute name="originPrice" required="false"%>
<%@ attribute name="saleRate" required="false"%>
<%@ attribute name="finalPrice" required="false"%>
<%@ attribute name="isWished" required="false"%>
<%@ attribute name="thumbnailFileId" required="false"%>
<%@ attribute name="href" required="false"%>

<c:set var="brand" value="${empty brand ? '브랜드명' : brand}" />
<c:set var="title" value="${empty title ? '상품명' : title}" />
<c:set var="isSale" value="${empty isSale ? 'false' : isSale}" />
<c:set var="hasOption" value="${empty hasOption ? 'false' : hasOption}" />
<c:set var="originPrice" value="${empty originPrice ? '' : originPrice}" />
<c:set var="saleRate" value="${empty saleRate ? '' : saleRate}" />
<c:set var="finalPrice" value="${empty finalPrice ? '' : finalPrice}" />
<c:set var="heartState" value="${isWished == 1 ? 'active' : 'default'}" />

<a class="product-card" data-productid="${productId}"
	<c:if test="${not empty href}"> href="${href}" </c:if>>

	<div class="product-image">
		<!-- 상품 이미지 -->
		<img
			src="<c:choose>
          <c:when test='${not empty thumbnailFileId}'>
              ${pageContext.request.contextPath}/image?fileId=${thumbnailFileId}
          </c:when>
          <c:otherwise>
              ${pageContext.request.contextPath}/image/plus.png
          </c:otherwise>
       </c:choose>"
			alt="대표 이미지" width="220px" />

		<!-- 찜 버튼 -->
		<div class="wishlist-btn">
			<my:heartBtn state="${heartState}" onlyIcon="true" hasCount="false" />
		</div>
	</div>

	<div class="product-info">
		<!-- 브랜드명 -->
		<p class="product-brand">${brand}</p>
		<!-- 상품명 -->
		<p class="product-title">${title}</p>
	</div> <!-- 가격 --> <my:price isSale="${isSale}" hasOption="${hasOption}"
		size="sm" originPrice="${originPrice}" saleRate="${saleRate}"
		finalPrice="${finalPrice}" /> <!-- 태그 -->
	<div class="product-tags">
		<jsp:doBody />
		<%-- 호출자가 <my:tag />를 삽입 가능 --%>
	</div>
</a>

<script>
	/*********************************************************************************************************
	 * 이미지 버튼
	 *********************************************************************************************************/
	function readURL(input, previewId) {
		if (input.files && input.files[0]) {
			const reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById(previewId).src = e.target.result;
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script>
