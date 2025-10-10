<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>발행쿠폰 상세보기 - ${coupon.cname}</title>
<link rel="stylesheet" href="./css/coupon.css" />
<!-- 헤드부분 -->

<body>
	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
		<section class="board_detailview coupon_detail">
			<!-- 테이블 -->
			<div class="info_table" style="margin: 50px auto 10px">
			<c:set var="createDate" value="${coupon.createdAt}" />
			<c:set var="startDate" value="${coupon.startDate}" />
			<c:set var="endDate" value="${coupon.endDate}" />
				<table id="coupon_info">
					<tr>
						<th>쿠폰명</th>
						<td>${coupon.cname}</td>
						<th>할인금액</th>
						<td><fmt:formatNumber value="${coupon.amount}" pattern="#,###,###" /> 원</td>
					</tr>
					
					<tr>
						<th>발행일자</th>
						<td>${fn:substring(createDate,0,19)}</td>
						<th>유효기간</th>
						<td>
							<c:choose>
								<c:when test="${endDate eq '2038-01-19 08:44:07.0' }"> 제한 없음 </c:when>
								<c:otherwise>
									${fn:substring(startDate,0,10)} ~ ${fn:substring(endDate,0,10)}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					
					<tr>
						<th>사용조건</th>
						<td>
							<c:choose>
								<c:when test="${coupon.amountCondition eq '-' }"> 제한 없음 </c:when>
								<c:otherwise>
									${coupon.amountCondition} 이상 구매시 사용 가능 
								</c:otherwise>
							</c:choose>
						</td>
						<th>적용 카테고리</th>
						<td>
							<c:choose>
								<c:when test="${coupon.categoryId eq null }"> 제한 없음 </c:when>
								<c:otherwise>
									${coupon.fullCategoryPath}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					
					<tr>
						<th>지급대상</th>
						<td>
							<c:choose>
								<c:when test="${coupon.provision eq 'ALL'}">모든 회원 </c:when>
								<c:when test="${coupon.provision eq 'VIP'}">VIP 회원</c:when>
								<c:when test="${coupon.provision eq 'GOLD'}">GOLD 회원</c:when>
								<c:when test="${coupon.provision eq 'SILVER'}">SILVER 회원</c:when>
								<c:when test="${coupon.provision eq 'REGULAR'}">일반 회원</c:when>
								<c:otherwise> 개별 회원  </c:otherwise>
							</c:choose>
						</td>
						<th>지급사유</th>
						<td>${coupon.reason}</td>
					</tr>
					<tr>
						<th>발행주체</th>
						<td>${coupon.writerType eq 'ADMIN' ? 'Amara Dazzle' : 'BRAND_ADMIN' }</td>
						<th>발행인</th>
						<td>${coupon.writerName}</td>
						
					</tr>
				</table>
			</div>

			<div class="button_box">
				<button type="button" class="btn first_btn action_btn">노출중지</button>
				<button type="button" class="btn second_btn action_btn">삭제</button>
			</div>
		</section>
		<!-- 메인부분 -->
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->




</body>
</html>