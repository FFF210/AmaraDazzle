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

<c:set var="__submit" value="${empty submitLabel ? '조회' : submitLabel}" />
<c:set var="__periods" value="${empty periods ? '1,3,6,12' : periods}" />
<c:set var="__prefix" value="${empty namePrefix ? 'drf' : namePrefix}" />
<c:set var="__size" value="${empty size ? 'md' : size}" />
<%-- 기본값 md --%>

<c:set var="__yFrom"
	value="${empty yearsFrom ? __todayY - 5 : yearsFrom}" />
<c:set var="__yTo" value="${empty yearsTo   ? __todayY      : yearsTo}" />

<c:set var="__startY" value="${empty startY ? __todayY : startY}" />
<c:set var="__startM" value="${empty startM ? __todayM : startM}" />
<c:set var="__startD" value="${empty startD ? __todayD : startD}" />
<c:set var="__endY" value="${empty endY   ? __todayY : endY}" />
<c:set var="__endM" value="${empty endM   ? __todayM : endM}" />
<c:set var="__endD" value="${empty endD   ? __todayD : endD}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/배송 조회</title>
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
<!-- 주문 취소 결과 알림 -->
    <c:if test="${param.cancelSuccess eq 'true'}">
        <script>alert('주문이 취소되었습니다.');</script>
    </c:if>
    
    <c:if test="${param.cancelFail eq 'true'}">
        <script>alert('주문 취소에 실패했습니다.');</script>
    </c:if>

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

			<!-- ============================ 2. 주문/배송 조회 ============================ -->
			<div class="order-status-card">
				<div class="order-status-header">
					<h3 class="order-status-title">주문/배송 조회</h3>
				</div>

				<div class="order-status-box">
					<div class="status-item ${activeStatus eq 'order' ? 'active' : ''}">
						<div class="status-count">${orderSummary.orderCount}</div>
						<div class="status-label">주문접수</div>
					</div>

					<div
						class="status-item ${activeStatus eq 'payment' ? 'active' : ''}">
						<div class="status-count">${orderSummary.paymentCount}</div>
						<div class="status-label">결제완료</div>
					</div>

					<div
						class="status-item ${activeStatus eq 'shipping' ? 'active' : ''}">
						<div class="status-count">${orderSummary.shippingCount}</div>
						<div class="status-label">배송준비중</div>
					</div>

					<div
						class="status-item ${activeStatus eq 'delivered' ? 'active' : ''}">
						<div class="status-count">${orderSummary.deliveredCount}</div>
						<div class="status-label">배송중</div>
					</div>

					<div
						class="status-item ${activeStatus eq 'confirmed' ? 'active' : ''}">
						<div class="status-count">${orderSummary.confirmedCount}</div>
						<div class="status-label">배송완료</div>
					</div>
				</div>
			</div>

			<!-- ============================ 3. 기간 조회 박스 ============================ -->
			<form method="get" action="${pageContext.request.contextPath}/store/mypage/orderList">
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

			<!-- ============================ 4. 상품 목록 테이블 ============================ -->
			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 150px;">주문번호</th>
							<th style="width: 340px;">상품</th>
							<th style="width: 60px;">수량</th>
							<th style="width: 100px;">구매가</th>
							<th style="width: 120px;">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty orderResult.groupedOrders}">
								<tr>
									<td colspan="5" style="text-align: center; padding: 50px;">
										주문 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<!-- 주문별 외부 루프 -->
								<c:forEach var="order" items="${orderResult.groupedOrders}">
									<!-- 상품별 내부 루프 -->
									<c:forEach var="item" items="${order.items}"
										varStatus="itemStatus">
										<tr>
											<!-- 첫 번째 상품일 때만 주문번호 셀 표시 -->
											<c:if test="${itemStatus.first}">
												<td class="order-number-cell"
													rowspan="${fn:length(order.items)}">
													<div class="order-date">
														<fmt:formatDate value="${order.orderDate}"
															pattern="yyyy.MM.dd" />
													</div>
													<div class="order-number">${order.orderCode}</div> <a
													href="${pageContext.request.contextPath}/store/mypage/consumerOrderDetail?orderId=${order.ordersId}"
													class="detail-link"> 상세보기</a>
												</td>
											</c:if>

											<!-- 상품 정보 -->
											<td>
												<div style="display: flex; align-items: center; gap: 12px;">
													<div class="product-image">이미지</div>
													<div class="product-info">
														<div class="product-brand">${item.brandName}</div>
														<div class="product-name">
															<a
																href="${pageContext.request.contextPath}/store/productDetail?productId=${item.productId}">
																${item.productName} ${item.productName} <c:if
																	test="${not empty item.optionValue}">
                                            (${item.optionValue})
                                        </c:if>
															</a>
														</div>
													</div>
												</div>
											</td>
											<td>${item.quantity}</td>
											<td><fmt:formatNumber value="${item.total}"
													pattern="#,###" />원</td>
											<td>
												<!-- 상태명 표시 -->
												<div class="order-status">
													<c:choose>
														<c:when test="${item.status == 'PAID'}">결제완료</c:when>
														<c:when test="${item.status == 'PREPARING'}">상품준비중</c:when>
														<c:when test="${item.status == 'SHIPPING'}">배송중</c:when>
														<c:when test="${item.status == 'DELIVERED'}">배송완료</c:when>
														<c:when test="${item.status == 'CONFIRMED'}">구매확정</c:when>
														<c:when test="${item.status == 'CANCELLED'}">취소완료</c:when>
														<c:when test="${item.status == 'EXCHANGE_REQUESTED'}">교환신청</c:when>
														<c:when test="${item.status == 'EXCHANGE_APPROVED'}">교환승인</c:when>
														<c:when test="${item.status == 'COLLECTING'}">회수중</c:when>
														<c:when test="${item.status == 'EXCHANGE_SHIPPING'}">교환배송중</c:when>
														<c:when test="${item.status == 'EXCHANGE_REJECTED'}">교환거절</c:when>
														<c:when test="${item.status == 'EXCHANGE_COMPLETED'}">교환완료</c:when>
														<c:when test="${item.status == 'RETURN_REQUESTED'}">반품신청</c:when>
														<c:when test="${item.status == 'RETURN_APPROVED'}">반품승인</c:when>
														<c:when test="${item.status == 'RETURN_REFUNDING'}">반품대기</c:when>
														<c:when test="${item.status == 'RETURN_REJECTED'}">반품거절</c:when>
														<c:when test="${item.status == 'RETURN_COMPLETED'}">반품완료</c:when>
														<c:otherwise>${item.status}</c:otherwise>
													</c:choose>
												</div>
												<div class="status-button">
													<c:choose>
														<%-- 결제완료, 상품준비중 - 취소신청 --%>
														<c:when
															test="${item.status == 'PAID' || item.status == 'PREPARING'}">
															<button class="btn btn-outline btn-sm"
																onclick="cancelOrder(${item.orderItemId})">취소신청</button>
														</c:when>
														<c:when test="${item.status == 'SHIPPING'}">
															<button class="btn btn-outline btn-sm"
																onclick="trackDelivery('${item.trackingNo}', '${item.carrierName}')">배송조회</button>
														</c:when>

														<%-- 배송완료 - 리뷰작성, 교환신청, 반품신청 (세로 배치) --%>
														<c:when test="${item.status == 'DELIVERED'}">
															<div class="button-vertical">
																<button class="btn btn-outline btn-sm"
																	onclick="writeReview(${item.orderItemId})">리뷰작성</button>

																<!--  교환 가능 여부 체크 -->
																<c:if test="${item.canExchange}">
																	<button class="btn btn-outline btn-sm"
																		onclick="requestExchange(${item.orderItemId})">교환신청</button>
																</c:if>

																<!--  반품 가능 여부 체크 -->
																<c:if test="${item.canReturn}">
																	<button class="btn btn-outline btn-sm"
																		onclick="requestReturn(${item.orderItemId})">반품신청</button>
																</c:if>

																<!--  기간 지난 경우 안내 -->
																<c:if test="${!item.canExchange && !item.canReturn}">
																	<span class="no-action"
																		style="color: #999; font-size: 12px;"> (교환/반품
																		기간 만료) </span>
																</c:if>
															</div>
														</c:when>

														<%-- 교환배송중 - 배송조회 --%>
														<c:when test="${item.status == 'EXCHANGE_SHIPPING'}">
															<button class="btn btn-outline btn-sm"
																onclick="trackDelivery('${item.trackingNo}', '${item.carrierName}')">배송조회</button>
														</c:when>

														<%-- 구매확정 - 리뷰작성만 --%>
														<c:when test="${item.status == 'CONFIRMED'}">
															<button class="btn btn-outline btn-sm"
																onclick="writeReview(${item.orderItemId})">리뷰작성</button>
														</c:when>

														<%-- 기타 상태 - 버튼 없음 --%>
														<c:otherwise>
															<span class="no-action">-</span>
														</c:otherwise>
													</c:choose>
												</div>
											</td>
										</tr>
									</c:forEach>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}" baseUrl="/store/mypage/orderList?${queryString}" />
			</div>
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>

	<script>
	function cancelOrder(orderItemId) {
	    if(confirm('주문을 취소하시겠습니까?')) {
	        // 취소 처리 로직
	        location.href = '/consumer/cancelOrder?orderItemId=' + orderItemId;
	    }
	}

	function trackDelivery(trackingNo, carrierName) {
	    // 택배 조회 새창으로 열기
	    let url = '';
	    if(carrierName === 'CJ대한통운') {
	        url = `https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${trackingNo}`;
	    } else if(carrierName === '롯데택배') {
	        url = `https://www.lotteglogis.com/home/reservation/tracking/linkView?InvNo=${trackingNo}`;
	    }
	    window.open(url, '_blank');
	}

	//그냥 마이리뷰 페이지로 보내기
	function writeReview(orderItemId) {
	    location.href = '/store/mypage/myReview';
	}

	function requestExchange(orderItemId) {
	    location.href = '/store/exchangeApply?orderItemId=' + orderItemId;
	}

	function requestReturn(orderItemId) {
	    location.href = '/store/returnApply?orderItemId=' + orderItemId;
	}
	
	// 날짜 선택 스크립트 (태그에서는 되는데 이게 dom을 못 찾아서 수정했어요....)
	(function(){
    // form을 ID로 직접 찾기
    const wrap = document.querySelector('.drf-wrap');
    if(!wrap) {
        console.error('날짜 선택 요소를 찾을 수 없습니다.');
        return;
    }

    const $  = (s,ctx=wrap)=>ctx.querySelector(s);
    const $$ = (s,ctx=wrap)=>Array.from(ctx.querySelectorAll(s));

    const sY=$('[data-role="start-y"]'), sM=$('[data-role="start-m"]'), sD=$('[data-role="start-d"]');
    const eY=$('[data-role="end-y"]'),   eM=$('[data-role="end-m"]'),   eD=$('[data-role="end-d"]');

    if(!sY || !sM || !sD || !eY || !eM || !eD) {
        console.error('날짜 선택 요소를 찾을 수 없습니다.');
        return;
    }

    const clamp=(y,m,d)=>Math.min(d, new Date(y, m, 0).getDate());
    const setSel=(sel,v)=>{ 
        const t=String(parseInt(v,10)); 
        for(const o of sel.options){ 
            if(String(parseInt(o.value,10))===t){ 
                o.selected=true; 
                break; 
            } 
        } 
    };
    const getDate=(Y,M,D)=>new Date(parseInt(Y.value,10), parseInt(M.value,10)-1, parseInt(D.value,10));
    const setDate=(dt,start)=>{ 
        const y=dt.getFullYear(), m=dt.getMonth()+1, d=dt.getDate();
        if(start){ 
            setSel(sY,y); setSel(sM,m); setSel(sD,clamp(y,m,d)); 
        } else { 
            setSel(eY,y); setSel(eM,m); setSel(eD,clamp(y,m,d)); 
        }
    };
    const minusMonths=(base,months)=>{
        let y=base.getFullYear(), m=base.getMonth()+1, d=base.getDate();
        let nm=m-months; 
        while(nm<=0){ 
            nm+=12; 
            y--; 
        }
        return new Date(y, nm-1, clamp(y,nm,d));
    };

    // 개월 버튼 클릭 이벤트
    $$('.drf-chip').forEach(btn=>{
        btn.addEventListener('click', (e)=>{
            e.preventDefault(); // 버튼 기본 동작 방지
            console.log('버튼 클릭:', btn.dataset.months); // 디버깅용
            
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
        const end=getDate(eY,eM,eD); 
        setDate(end,false);
        const st =getDate(sY,sM,sD); 
        setDate(new Date(st.getFullYear(), st.getMonth(), clamp(st.getFullYear(), st.getMonth()+1, st.getDate())), true);
    }));

    console.log('날짜 선택 스크립트 초기화 완료');
})();
	</script>
</body>
</html>