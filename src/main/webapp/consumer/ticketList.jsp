<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 - 1:1 문의목록</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/dateRangeFilterBox.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/ticketList.css'/>">
</head>
<body>
<%-- 헤더 --%>
<%@ include file="/consumer/header.jsp"%>

<div class="pageHeader-wrapper">
    <my:pageHeader hasButton="false" title="고객센터" description="무엇을 도와드릴까요" />
</div>

<!-- Main Content -->
<main class="main-content">
    <!-- 필터 섹션 -->
    <div class="filter-section">
        <form action="<c:url value='/store/mypage/ticketList'/>" method="get">
            <my:dateRangeFilterBox periods="1,3,6,12" submitLabel="조회" size="md" />
        </form>
    </div>
    
    <!-- 문의내역 테이블 -->
    <div class="table-wrapper">
        <table class="table">
            <thead>
                <tr>
                    <th style="width: 80px;">번호</th>
                    <th style="width: 100px;">유형</th>
                    <th>내용</th>
                    <th style="width: 120px;">등록일</th>
                </tr>
            </thead>
            <tbody>
                <%-- 문의 내역이 없을 때 --%>
                <c:if test="${empty ticketList}">
                    <tr>
                        <td colspan="4" style="text-align: center; padding: 40px;">
                            문의 내역이 없습니다.
                        </td>
                    </tr>
                </c:if>
                
                <%-- 문의 내역이 있을 때 --%>
                <c:forEach var="ticket" items="${ticketList}" varStatus="status">
                    <tr onclick="location.href='<c:url value='/ticket/detail'/>?ticketId=${ticket.ticketId}'" 
                        style="cursor: pointer;">
                        <td>${status.count}</td>
                        <td>
                            <%-- 카테고리별 badge 표시 --%>
                            <c:choose>
                                <c:when test="${ticket.category == 'ORDER'}">
                                    <span class="status-badge status-주문">주문</span>
                                </c:when>
                                <c:when test="${ticket.category == 'CANCEL'}">
                                    <span class="status-badge status-취소">취소</span>
                                </c:when>
                                <c:when test="${ticket.category == 'REFUND'}">
                                    <span class="status-badge status-환불">환불</span>
                                </c:when>
                                <c:when test="${ticket.category == 'EXCHANGE'}">
                                    <span class="status-badge status-교환">교환</span>
                                </c:when>
                                <c:when test="${ticket.category == 'DELIVERY'}">
                                    <span class="status-badge status-배송">배송</span>
                                </c:when>
                                <c:when test="${ticket.category == 'PAYMENT'}">
                                    <span class="status-badge status-결제">결제</span>
                                </c:when>
                                <c:when test="${ticket.category == 'EVENT'}">
                                    <span class="status-badge status-이벤트">이벤트</span>
                                </c:when>
                                <c:when test="${ticket.category == 'SITE_ISSUE'}">
                                    <span class="status-badge status-사이트">사이트</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-일반">일반</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-left">
                            <%-- 문의 내용 (너무 길면 자르기) --%>
                            <c:choose>
                                <c:when test="${ticket.question.length() > 50}">
                                    ${ticket.question.substring(0, 50)}...
                                </c:when>
                                <c:otherwise>
                                    ${ticket.question}
                                </c:otherwise>
                            </c:choose>
                            
                            <%-- 답변이 있으면 표시 --%>
                            <c:if test="${not empty ticket.answer}">
                                <span style="color: #1e90ff; margin-left: 5px;">[답변완료]</span>
                            </c:if>
                        </td>
                        <td>
                            <%-- 날짜 포맷 (yyyy-MM-dd) --%>
                            <fmt:formatDate value="${ticket.questionedAt}" pattern="yyyy-MM-dd" />
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- 1:1 문의하기 버튼 -->
    <div class="inquiry-button-section">
        <button class="inquiry-btn" onclick="location.href='<c:url value='/store/mypage/writeTicket'/>'">
            1:1 문의하기
        </button>
    </div>

    <!-- pagination (나중에 추가 가능) -->
    <%-- <my:pagination currentPage="${currentPage}" totalPages="${totalPages}" baseUrl="/store/mypage/ticketList" /> --%>
</main>

<%-- footer --%>
<%@ include file="/consumer/footer.jsp"%>

<script>
// 행 클릭 시 상세 페이지로 이동 (이미 tr에 onclick 있음)
</script>

</body>
</html>