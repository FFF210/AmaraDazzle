<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<link rel="stylesheet" href="./css/price.css" />

<%-- ================================
     ProductItem 커스텀 태그

     속성(Props)
     • size       : md | sm
     • title      : 문자열 (상품명)
     • isSale     : true | false
     • hasOption  : true | false
     • originPrice: 원가
     • saleRate   : 할인율
     • finalPrice : 최종가
     • showTags   : true | false (단, size=md일 때만 반영)

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:productItem 
       size="md"
       title="샘플 상품"
       isSale="true"
       hasOption="true"
       originPrice="15000"
       saleRate="10"
       finalPrice="13500"
       showTags="true">
       <my:tag color="green" size="sm" text="베스트" />
     </my:productItem>
================================ --%>

<%@ attribute name="size" required="false"%>
<%@ attribute name="title" required="false"%>
<%@ attribute name="isSale" required="false"%>
<%@ attribute name="hasOption" required="false"%>
<%@ attribute name="originPrice" required="false"%>
<%@ attribute name="saleRate" required="false"%>
<%@ attribute name="finalPrice" required="false"%>
<%@ attribute name="showTags" required="false"%>
<%@ attribute name="thumbnailFileId" required="false"%>
<%@ attribute name="href" required="false"%>

<c:set var="size" value="${empty size ? 'md' : size}" />
<c:set var="title" value="${empty title ? '상품명' : title}" />
<c:set var="isSale" value="${empty isSale ? 'false' : isSale}" />
<c:set var="hasOption" value="${empty hasOption ? 'false' : hasOption}" />
<c:set var="originPrice" value="${empty originPrice ? '' : originPrice}" />
<c:set var="saleRate" value="${empty saleRate ? '' : saleRate}" />
<c:set var="finalPrice" value="${empty finalPrice ? '' : finalPrice}" />
<c:set var="showTags" value="${empty showTags ? 'false' : showTags}" />

<div class="product-item ${size}">
	<div class="thumbnail">
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
			alt="대표 이미지" width="${size eq 'md' ? '120px' : '80px'}" />
	</div>

	<div class="info">
		<!-- 상품명 -->
		<p class="product-title">${title}</p>

		<!-- 가격 -->
		<my:price isSale="${isSale}" hasOption="${hasOption}" size="sm"
			originPrice="${originPrice}" saleRate="${saleRate}"
			finalPrice="${finalPrice}" />

		<!-- 태그 -->
		<c:if test="${showTags eq 'true' and size eq 'md'}">
			<div class="tags">
				<jsp:doBody />
				<%-- 호출자가 <my:tag /> 직접 삽입 가능 --%>
			</div>
		</c:if>
	</div>
</div>

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
