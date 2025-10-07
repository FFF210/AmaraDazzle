<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- 오늘 날짜를 JSTL 변수에 저장 --%>
<jsp:useBean id="now" class="java.util.Date" />

<fmt:formatDate value="${now}" pattern="yyyy" var="__todayY" />
<fmt:formatDate value="${now}" pattern="M" var="__todayM" />
<fmt:formatDate value="${now}" pattern="d" var="__todayD" />

<c:set var="__submit" value="조회" />
<c:set var="__periods" value="1,3,6,12" />
<c:set var="__prefix" value="drf" />
<c:set var="__size" value="md" />

<c:set var="__yFrom" value="${__todayY - 5}" />
<c:set var="__yTo" value="${__todayY}" />

<c:set var="__startY" value="${empty startY ? __todayY : startY}" />
<c:set var="__startM" value="${empty startM ? __todayM : startM}" />
<c:set var="__startD" value="${empty startD ? __todayD : startD}" />
<c:set var="__endY" value="${empty endY ? __todayY : endY}" />
<c:set var="__endM" value="${empty endM ? __todayM : endM}" />
<c:set var="__endD" value="${empty endD ? __todayD : endD}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취소/반품/교환 내역</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet"
	href="<c:url value='/tagcss/dateRangeFilterBox.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/orderStatusCard.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/userInfo.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/orderList.css'/>">
</head>
<body>

	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<div class="container">

		<!-- 마이페이지 메뉴 -->
		<%@ include file="/consumer/mypageMenu.jsp"%>

		<div class="page-contents">

			<!-- ============================ 1. 사용자 정보 요약 ============================ -->
			<div class="user-info">

				<div class="user-info__top">
					<p class="greeting">
						<span class="name">${sessionScope.memberName}</span> 님 반갑습니다.
					</p>
				</div>

				<!-- 하단 통계 영역 -->
				<div class="user-info__bottom">
					<div class="stat">
						<span class="label">등급</span> <span class="value"><span
							class="em">${sessionScope.memberGrade}</span></span>
					</div>
					<div class="stat">
						<span class="label">포인트</span> <span class="value"><span
							class="em">${sessionScope.memberPoints}</span> p</span>
					</div>
					<div class="stat">
						<span class="label">쿠폰</span> <span class="value"><span
							class="em">${sessionScope.memberCoupons}</span> 개</span>
					</div>
				</div>
			</div>

			<!-- ============================ 2. 기간 조회 박스 ============================ -->
			<form
				action="${pageContext.request.contextPath}/store/mypage/cancelExchangeReturnList"
				method="get">
				<div class="drf-wrap drf-${__size}">
					<div class="drf-box">
						<div class="drf-header">
							<div class="drf-label">구매기간</div>
							<div class="drf-periods">
								<c:forTokens items="${__periods}" delims="," var="p"
									varStatus="st">
									<button type="button"
										class="drf-chip ${st.first ? 'is-active' : ''}"
										data-months="${p}">${p}개월</button>
								</c:forTokens>
							</div>
						</div>

						<div class="drf-dates">
							<div class="since-drf-date">
								<select class="drf-select" name="${__prefix}StartY"
									data-role="start-y">
									<c:forEach var="y" begin="${__yFrom}" end="${__yTo}">
										<option value="${y}" ${y == __startY ? 'selected' : ''}>${y}</option>
									</c:forEach>
								</select><span class="drf-suffix">년</span> <select class="drf-select"
									name="${__prefix}StartM" data-role="start-m">
									<c:forEach var="m" begin="1" end="12">
										<option value="${m}" ${m == __startM ? 'selected' : ''}>${m}</option>
									</c:forEach>
								</select><span class="drf-suffix">월</span> <select class="drf-select"
									name="${__prefix}StartD" data-role="start-d">
									<c:forEach var="d" begin="1" end="31">
										<option value="${d}" ${d == __startD ? 'selected' : ''}>${d}</option>
									</c:forEach>
								</select><span class="drf-suffix">일</span>
							</div>

							<div class="drf-tilde">~</div>

							<div class="until-drf-date">
								<select class="drf-select" name="${__prefix}EndY"
									data-role="end-y">
									<c:forEach var="y" begin="${__yFrom}" end="${__yTo}">
										<option value="${y}" ${y == __endY ? 'selected' : ''}>${y}</option>
									</c:forEach>
								</select><span class="drf-suffix">년</span> <select class="drf-select"
									name="${__prefix}EndM" data-role="end-m">
									<c:forEach var="m" begin="1" end="12">
										<option value="${m}" ${m == __endM ? 'selected' : ''}>${m}</option>
									</c:forEach>
								</select><span class="drf-suffix">월</span> <select class="drf-select"
									name="${__prefix}EndD" data-role="end-d">
									<c:forEach var="d" begin="1" end="31">
										<option value="${d}" ${d == __endD ? 'selected' : ''}>${d}</option>
									</c:forEach>
								</select><span class="drf-suffix">일</span>
							</div>
						</div>
					</div>

					<button class="drf-submit" type="submit">${__submit}</button>
				</div>
			</form>

			<!-- ============================ 3. 상품 목록 테이블 ============================ -->
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 150px;">주문번호</th>
							<th style="width: 380px;">상품</th>
							<th style="width: 46px;">수량</th>
							<th style="width: 103px;">구매가</th>
							<th style="width: 145px;">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty list}">
								<tr>
									<td colspan="5" style="text-align: center; padding: 50px;">
										취소/교환/반품 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="item" items="${list}">
									<tr>
										<!-- 주문번호 -->
										<td class="order-number-cell">
											<div class="order-date">
												<fmt:formatDate value="${item.updated_at}"
													pattern="yyyy.MM.dd" />
											</div>
											<div class="order-number">${item.order_code}</div> <!-- 상세보기 링크: 교환/반품/취소별로 다르게 -->
											<c:choose>
												<c:when test="${item.status == 'CANCELLED'}">
													<span class="detail-link">취소완료</span>
												</c:when>
												<c:when test="${fn:startsWith(item.status, 'EXCHANGE_')}">
													<a
														href="${pageContext.request.contextPath}/store/exchangeDetail?exchangeId=${item.exchange_id}"
														class="detail-link">상세보기</a>
												</c:when>
												<%-- COLLECTING은 exchange_id나 returns_id로 판단 --%>
												<c:when test="${item.status == 'COLLECTING'}">
													<c:choose>
														<c:when test="${not empty item.exchange_id}">
															<a
																href="${pageContext.request.contextPath}/store/exchangeDetail?exchangeId=${item.exchange_id}"
																class="detail-link">상세보기</a>
														</c:when>
														<c:when test="${not empty item.returns_id}">
															<a
																href="${pageContext.request.contextPath}/store/returnDetail?returnsId=${item.returns_id}"
																class="detail-link">상세보기</a>
														</c:when>
													</c:choose>
												</c:when>
												<c:when test="${fn:startsWith(item.status, 'RETURN_')}">
													<a
														href="${pageContext.request.contextPath}/store/returnDetail?returnsId=${item.returns_id}"
														class="detail-link">상세보기</a>
												</c:when>
											</c:choose>
										</td>

										<!-- 상품 정보 -->
										<td>
											<div style="display: flex; align-items: center; gap: 12px;">
												<div class="product-image">이미지</div>
												<div class="product-info">
													<div class="product-brand">${item.brand_name}</div>
													<div class="product-name">
														<a
															href="${pageContext.request.contextPath}/store/productDetail?productId=${item.product_id}">
															${item.name} <c:if test="${not empty item.option_id}">
																(${item.option_value})
															</c:if>
														</a>
													</div>
												</div>
											</div>
										</td>

										<!-- 수량 -->
										<td>${item.quantity}</td>

										<!-- 구매가 -->
										<td><fmt:formatNumber value="${item.total}"
												pattern="#,###" />원</td>

										<!-- 상태 -->
										<td>
											<div class="order-status">
												<c:choose>
													<c:when test="${item.status == 'CANCELLED'}">주문취소</c:when>
													<c:when test="${item.status == 'RETURN_REQUESTED'}">반품신청</c:when>
													<c:when test="${item.status == 'RETURN_APPROVED'}">반품승인</c:when>
													<c:when test="${item.status == 'COLLECTING'}">회수중</c:when>
													<%-- 교환/반품 통합 --%>
													<c:when test="${item.status == 'RETURN_REFUNDING'}">환불대기</c:when>
													<c:when test="${item.status == 'RETURN_REJECTED'}">반품거절</c:when>
													<c:when test="${item.status == 'RETURN_COMPLETED'}">반품완료</c:when>
													<c:when test="${item.status == 'EXCHANGE_REQUESTED'}">교환신청</c:when>
													<c:when test="${item.status == 'EXCHANGE_APPROVED'}">교환승인</c:when>
													<c:when test="${item.status == 'EXCHANGE_SHIPPING'}">교환배송중</c:when>
													<c:when test="${item.status == 'EXCHANGE_REJECTED'}">교환거절</c:when>
													<c:when test="${item.status == 'EXCHANGE_COMPLETED'}">교환완료</c:when>
													<c:otherwise>${item.status}</c:otherwise>
												</c:choose>
											</div>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>

	<script>
	(function(){
		  // 태그 바로 뒤 script 기준: 이전 형제가 루트
		  const wrap = document.currentScript && document.currentScript.previousElementSibling;
		  if(!wrap || !wrap.classList.contains('drf-wrap')) return;

		  const $  = (s,ctx=wrap)=>ctx.querySelector(s);
		  const $$ = (s,ctx=wrap)=>Array.from(ctx.querySelectorAll(s));

		  const sY=$('[data-role="start-y"]'), sM=$('[data-role="start-m"]'), sD=$('[data-role="start-d"]');
		  const eY=$('[data-role="end-y"]'),   eM=$('[data-role="end-m"]'),   eD=$('[data-role="end-d"]');

		  const clamp=(y,m,d)=>Math.min(d, new Date(y, m, 0).getDate());
		  const setSel=(sel,v)=>{ const t=String(parseInt(v,10)); for(const o of sel.options){ if(String(parseInt(o.value,10))===t){ o.selected=true; break; } } };
		  const getDate=(Y,M,D)=>new Date(parseInt(Y.value,10), parseInt(M.value,10)-1, parseInt(D.value,10));
		  const setDate=(dt,start)=>{ const y=dt.getFullYear(), m=dt.getMonth()+1, d=dt.getDate();
		    if(start){ setSel(sY,y); setSel(sM,m); setSel(sD,clamp(y,m,d)); }
		    else     { setSel(eY,y); setSel(eM,m); setSel(eD,clamp(y,m,d)); }
		  };
		  const minusMonths=(base,months)=>{
		    let y=base.getFullYear(), m=base.getMonth()+1, d=base.getDate();
		    let nm=m-months; while(nm<=0){ nm+=12; y--; }
		    return new Date(y, nm-1, clamp(y,nm,d));
		  };

		  // 개월 버튼
		  $$('.drf-chip').forEach(btn=>{
		    btn.addEventListener('click', ()=>{
		      const months=parseInt(btn.dataset.months,10)||1;
		      const end=getDate(eY,eM,eD);
		      const start=minusMonths(end, months);
		      setDate(start,true);

		      $$('.drf-chip').forEach(b=>b.classList.remove('is-active'));
		      btn.classList.add('is-active');
		    });
		  });

		  // 종료 연/월 변경 시 day 정리
		  [eY,eM].forEach(sel=> sel.addEventListener('change', ()=>{
		    const end=getDate(eY,eM,eD); setDate(end,false);
		    const st =getDate(sY,sM,sD); setDate(new Date(st.getFullYear(), st.getMonth(), clamp(st.getFullYear(), st.getMonth()+1, st.getDate())), true);
		  }));
		})();
	</script>
</body>
</html>