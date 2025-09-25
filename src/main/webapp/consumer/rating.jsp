<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- ================================
Rating 컴포넌트

속성(Props)
• color: yellow | green | blue | red | gray (기본값: yellow)
• size : sm | md | lg (기본값: md)
• rating : 0.0 ~ 5.0 평점 (기본값: 0)
• readonly : true | false 읽기전용 여부 (기본값: true)
• showScore : true | false 점수 표시 여부 (기본값: false)

사용법 예시
<!-- 1. 기본 평점 표시 (읽기전용) -->
<c:import url="/rating.jsp">
    <c:param name="color" value="yellow" />
    <c:param name="size" value="md" />
    <c:param name="rating" value="4.5" />
    <c:param name="readonly" value="true" />
</c:import>

<!-- 2. 평점 선택 (클릭 가능) -->
<c:import url="/rating.jsp">
    <c:param name="color" value="yellow" />
    <c:param name="size" value="lg" />
    <c:param name="rating" value="3" />
    <c:param name="readonly" value="false" />
    <c:param name="showScore" value="true" />
</c:import>
================================ --%>

<%-- 파라미터 기본값 처리 --%>
<c:set var="color" value="${param.color != null ? param.color : 'yellow'}" />
<c:set var="size" value="${param.size != null ? param.size : 'md'}" />
<c:set var="rating" value="${param.rating != null ? param.rating : '0'}" />
<c:set var="readonly" value="${param.readonly != null ? param.readonly : 'true'}" />
<c:set var="showScore" value="${param.showScore != null ? param.showScore : 'false'}" />
<c:set var="ratingId" value="${param.ratingId != null ? param.ratingId : 'rating'}" />

<%-- 평점을 소수점으로 변환 --%>
<c:set var="ratingValue" value="${rating}" />
<c:set var="fullStars" value="${ratingValue - (ratingValue % 1)}" />
<c:set var="hasHalfStar" value="${(ratingValue % 1) >= 0.5}" />

<div class="rating ${color} ${size} ${readonly eq 'true' ? 'readonly' : 'interactive'}" 
     data-rating="${ratingValue}" data-rating-id="${ratingId}">
     
    <c:forEach var="i" begin="1" end="5">
        <c:choose>
            <c:when test="${i <= fullStars}">
                <span class="star filled" data-value="${i}">★</span>
            </c:when>
            <c:when test="${i == (fullStars + 1) && hasHalfStar}">
                <span class="star half-filled" data-value="${i}">★</span>
            </c:when>
            <c:otherwise>
                <span class="star empty" data-value="${i}">★</span>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    
    <c:if test="${showScore eq 'true'}">
        <span class="rating-score">${ratingValue}</span>
    </c:if>
</div>