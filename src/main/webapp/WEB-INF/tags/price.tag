<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ================================
     Price 커스텀 태그
     
     속성(Props)
     • isSale     : true | false   → 세일 여부 (% 표시 + 원래가격 strike 처리)
     • hasOption  : true | false   → 옵션 여부 (가격 뒤에 "~" 붙임)
     • size       : sm | md
     • originPrice: 원가
     • saleRate   : 할인율
     • finalPrice : 최종가

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:price 
       isSale="true"
       hasOption="true"
       size="sm"
       originPrice="34000"
       saleRate="25"
       finalPrice="25500" />
================================ --%>

<%@ attribute name="isSale" required="false" %>
<%@ attribute name="hasOption" required="false" %>
<%@ attribute name="size" required="false" %>
<%@ attribute name="originPrice" required="false" %>
<%@ attribute name="saleRate" required="false" %>
<%@ attribute name="finalPrice" required="false" %>

<c:set var="isSale" value="${empty isSale ? 'false' : isSale}" />
<c:set var="hasOption" value="${empty hasOption ? 'false' : hasOption}" />
<c:set var="size" value="${empty size ? 'md' : size}" />
<c:set var="originPrice" value="${empty originPrice ? '' : originPrice}" />
<c:set var="saleRate" value="${empty saleRate ? '' : saleRate}" />
<c:set var="finalPrice" value="${empty finalPrice ? '' : finalPrice}" />

<div class="price ${size}">
  <c:choose>
    <c:when test="${isSale eq 'true'}">
      <c:choose>
        <c:when test="${size eq 'sm'}">
          <span class="sale-rate">${saleRate}%</span>
          <span class="final">
            ${finalPrice}원
            <c:if test="${hasOption eq 'true'}">~</c:if>
          </span>
        </c:when>
        
        <c:when test="${size eq 'md'}">
          <div class="origin">${originPrice}원</div>
          <div class="sale-row">
            <span class="sale-rate">${saleRate}%</span>
            <span class="final">
              ${finalPrice}원
              <c:if test="${hasOption eq 'true'}">~</c:if>
            </span>
          </div>
        </c:when>
      </c:choose>
    </c:when>

    <c:otherwise>
      <span class="final">
        ${finalPrice}원
        <c:if test="${hasOption eq 'true'}">~</c:if>
      </span>
    </c:otherwise>
  </c:choose>
</div>
