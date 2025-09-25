<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
    ReviewSummary 커스텀 태그

    속성(Props)
    • average   : 평균 평점 (예: 4.89)
    • floorAvg  : 평균 평점의 정수 부분 (예: 4)
    • total     : 전체 리뷰 수 (옵션)
    • dist5~1   : 각 점수 개수

    사용법 예시 (JSP에서 floorAvg 미리 계산해서 전달)
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <%
       double avg = 4.89;
       int floor = (int) Math.floor(avg);
       request.setAttribute("avg", avg);
       request.setAttribute("floor", floor);
    %>
    <my:reviewSummary
      average="${avg}"
      floorAvg="${floor}"
      total="120"
      dist5="100" dist4="15" dist3="3" dist2="1" dist1="1" />
================================ --%>

<%@ attribute name="average" required="true"%>
<%@ attribute name="floorAvg" required="true"%>
<%@ attribute name="total" required="false"%>
<%@ attribute name="dist5" required="true"%>
<%@ attribute name="dist4" required="true"%>
<%@ attribute name="dist3" required="true"%>
<%@ attribute name="dist2" required="true"%>
<%@ attribute name="dist1" required="true"%>

<c:set var="sum" value="${dist5 + dist4 + dist3 + dist2 + dist1}" />

<div class="review-summary">
	<!-- 왼쪽 -->
	<div class="summary-left">
		<p class="avg-score">${average}</p>
		<my:rating rating="${floorAvg}" readonly="true" />
		<c:if test="${not empty total}">
			<div class="total-count">(${total}건)</div>
		</c:if>
	</div>

	<!-- 오른쪽 : 별점 분포 (세로 막대 차트) -->
	<div class="summary-right">
		<div class="bar-col">
			<div class="bar">
				<div class="fill"
					style="height:${sum > 0 ? (dist5 * 100 / sum) : 0}%"></div>
			</div>
			<span class="label">5점</span>
		</div>
		<div class="bar-col">
			<div class="bar">
				<div class="fill"
					style="height:${sum > 0 ? (dist4 * 100 / sum) : 0}%"></div>
			</div>
			<span class="label">4점</span>
		</div>
		<div class="bar-col">
			<div class="bar">
				<div class="fill"
					style="height:${sum > 0 ? (dist3 * 100 / sum) : 0}%"></div>
			</div>
			<span class="label">3점</span>
		</div>
		<div class="bar-col">
			<div class="bar">
				<div class="fill"
					style="height:${sum > 0 ? (dist2 * 100 / sum) : 0}%"></div>
			</div>
			<span class="label">2점</span>
		</div>
		<div class="bar-col">
			<div class="bar">
				<div class="fill"
					style="height:${sum > 0 ? (dist1 * 100 / sum) : 0}%"></div>
			</div>
			<span class="label">1점</span>
		</div>
	</div>

</div>
