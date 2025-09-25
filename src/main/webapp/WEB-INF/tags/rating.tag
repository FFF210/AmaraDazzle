<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
     Rating 별점 커스텀 태그 (5점 만점 고정)
     
     속성(Props)
     • rating    : 현재 별점 값 (0-5, 기본값 0)
     • readonly  : 읽기전용 여부 true | false (기본값 false)
     • noBackground: 배경 없는 버전 true | false (기본값 false)
     • id        : 컨테이너 ID (선택사항)
     • className : 추가 CSS 클래스 (선택사항)

     사용법 예시
     <%@ taglib prefix="star" tagdir="/WEB-INF/tags" %>
     
     <!-- 기본 배경 있는 버전 (읽기 전용) -->
     <star:rating rating="4" readonly="true" />

     <!-- 배경 없는 버전 -->
     <star:rating rating="4" readonly="true" noBackground="true" />

     <!-- 클릭 가능한 별점 -->
     <star:rating rating="0" noBackground="true" id="user-rating" />
================================ --%>

<%@ attribute name="rating" required="false"%>
<%@ attribute name="readonly" required="false"%>
<%@ attribute name="noBackground" required="false"%>
<%@ attribute name="id" required="false"%>
<%@ attribute name="className" required="false"%>

<c:set var="rating" value="${empty rating ? 0 : rating}" />
<c:set var="readonly" value="${empty readonly ? false : readonly}" />
<c:set var="noBackground" value="${empty noBackground ? false : noBackground}" />
<c:set var="className" value="${empty className ? '' : className}" />

<div class="rating-container ${readonly ? 'readonly' : ''} ${noBackground ? 'no-background' : ''} ${className}"
     data-rating="${rating}" <c:if test="${not empty id}">id="${id}"</c:if>> 

  <c:forEach var="i" begin="1" end="5">
    <i class="bi ${i <= rating ? 'bi-star-fill' : 'bi-star'} star"
       data-value="${i}"></i>
  </c:forEach>
</div>
