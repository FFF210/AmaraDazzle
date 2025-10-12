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
<title>취소/반품/교환 조회</title>
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
	href="<c:url value='/consumer/css/exchangeReturnCancelList.css'/>">
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
							class="em"><c:choose>
									<c:when test="${sessionScope.memberGrade eq 'VIP'}">VIP</c:when>
									<c:when test="${sessionScope.memberGrade eq 'GOLD'}">GOLD</c:when>
									<c:when test="${sessionScope.memberGrade eq 'SILVER'}">SILVER</c:when>
									<c:otherwise>일반</c:otherwise>
								</c:choose></span></span>
					</div>
					<div class="stat">
						<span class="label">포인트</span> <span class="value"><span
							class="em"><fmt:formatNumber value="${sessionScope.memberPoints}" pattern="#,###" /></span> p</span>
					</div>
					<div class="stat">
						<span class="label">쿠폰</span> <span class="value"><span
							class="em">${sessionScope.memberCoupons}</span> 개</span>
					</div>
				</div>
			</div>

			<div class="order-header">
				<h3 class="order-status-title">취소/반품/교환 조회</h3>
			</div>

			<!-- ============================ 2. 기간 조회 박스 ============================ -->
			<form id="searchForm"
				action="${pageContext.request.contextPath}/store/mypage/exchangeReturnCancelList"
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
							<th style="width: 80px; padding: 0;">주문번호</th>
							<th style="width: 150px; padding: 0;">상품</th>
							<th style="width: 30px; padding: 0;">수량</th>
							<th style="width: 60px; padding: 0;">주문금액</th>
							<th style="width: 80px; padding: 0;">상태</th>
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
										<td class="order-number-cell" style="padding: 0;">
											<div
												style="display: flex; flex-direction: column; color: #111;">
												<fmt:formatDate value="${item.updated_at}"
													pattern="yyyy.MM.dd" />
												<a
													href="${pageContext.request.contextPath}/store/mypage/consumerOrderDetail?orderId=${item.orders_id}"
													class="detail-link" style="color: #111; font-weight: 600;">${item.order_code}</a>
												<!-- 상세보기 링크 -->
												<c:choose>
													<c:when test="${item.status == 'CANCELLED'}">
														<span class="detail-link-disabled"
															style="font-weight: 600;">취소완료</span>
													</c:when>

													<%-- 교환 관련 --%>
													<c:when test="${fn:startsWith(item.status, 'EXCHANGE_')}">
														<a
															href="${pageContext.request.contextPath}/store/exchangeDetail?exchangeId=${item.exchange_id}"
															class="detail-link">상세보기</a>
													</c:when>

													<%-- 회수중 (교환/반품 구분) --%>
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

													<%-- 반품 관련 --%>
													<c:when test="${fn:startsWith(item.status, 'RETURN_')}">
														<a
															href="${pageContext.request.contextPath}/store/returnDetail?returnsId=${item.returns_id}"
															class="detail-link">상세보기</a>
													</c:when>
												</c:choose>
											</div>
										</td>

										<!-- 상품 정보 -->
										<td style="padding: 0;"
											onclick="location.href='${pageContext.request.contextPath}/store/productDetail?productId=${item.productId}'">
											<div
												style="display: flex; align-items: center; gap: 12px; padding: 20px 0;">
												<img
													src="${pageContext.request.contextPath}/image?fileId=${item.thumbnailFileId}"
													alt="${item.name}"
													style="width: 80px; height: 80px; object-fit: cover;">
												<div class="product-info"
													style="text-align: left; display: flex; flex-direction: column; width: 100%; height: fit-content; gap: 6px;">
													<p class="product-brand"
														style="color: #333; font-weight: 700; font-size: 13px;">${item.brand_name}</p>
													<p class="product-name">${item.name}</p>
													<c:if test="${not empty item.option_value}">
														<P style="color: #888; font-weight: 400; font-size: 13px;">옵션
															| ${item.option_value}</P>
													</c:if>
												</div>
											</div>
										</td>

										<!-- 수량 -->
										<td style="padding: 0; color: #111; font-size: 13px;">${item.quantity}</td>

										<!-- 구매가 -->
										<td style="padding: 0; color: #111; font-size: 13px;"><fmt:formatNumber
												value="${item.total}" pattern="#,###" />원</td>

										<!-- 상태 -->
										<td style="padding: 0;">
											<div class="order-status">
												<c:choose>
													<c:when test="${item.status == 'CANCELLED'}">주문취소</c:when>
													<c:when test="${item.status == 'RETURN_REQUESTED'}">반품신청</c:when>
													<c:when test="${item.status == 'RETURN_APPROVED'}">반품승인</c:when>
													<c:when test="${item.status == 'COLLECTING'}">회수중</c:when>
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
											</div> <!-- 상태별 버튼 -->
											<div class="status-button">
												<c:choose>
													<%-- 회수중: 회수 배송조회 (교환/반품 구분) --%>
													<c:when test="${item.status == 'COLLECTING'}">
														<c:choose>
															<%-- 교환 회수중 --%>
															<c:when
																test="${not empty item.exchange_id and not empty item.exchange_return_tracking_no}">
																<button class="btn btn-outline btn-sm"
																	onclick="trackDelivery('${item.exchange_return_tracking_no}', '${item.exchange_return_carrier_name}')">
																	배송조회</button>
															</c:when>
															<%-- 반품 회수중 --%>
															<c:when
																test="${not empty item.returns_id and not empty item.return_tracking_no}">
																<button class="btn btn-outline btn-sm"
																	onclick="trackDelivery('${item.return_tracking_no}', '${item.return_carrier_name}')">
																	배송조회</button>
															</c:when>
														</c:choose>
													</c:when>

													<%-- 교환배송중: 교환 재배송 조회 --%>
													<c:when test="${item.status == 'EXCHANGE_SHIPPING'}">
														<c:if
															test="${not empty item.exchange_shipping_tracking_no}">
															<button class="btn btn-outline btn-sm"
																onclick="trackDelivery('${item.exchange_shipping_tracking_no}', '${item.exchange_shipping_carrier_name}')">
																배송조회</button>
														</c:if>
													</c:when>

													<%-- 교환완료: 리뷰작성만 (교환은 1회 제한) --%>
													<c:when test="${item.status == 'EXCHANGE_COMPLETED'}">
														<button class="btn btn-outline btn-sm"
															onclick="writeReview(${item.order_item_id})">
															리뷰작성</button>
													</c:when>

													<%-- 기타 상태: 버튼 없음 --%>
													<c:otherwise>
														<span class="no-action">-</span>
													</c:otherwise>
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
			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}"
					baseUrl="/store/mypage/exchangeReturnCancelList?${queryString}" />
			</div>
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>

	<script>
	// 배송조회 함수
	function trackDelivery(trackingNo, carrierName) {
	    if(!trackingNo) {
	        alert('운송장 번호가 없습니다.');
	        return;
	    }
	    
	    let url = '';
	    if(carrierName === 'CJ대한통운') {
	        url = 'https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=' + trackingNo;
	    } else if(carrierName === '롯데택배') {
	        url = 'https://www.lotteglogis.com/home/reservation/tracking/linkView?InvNo=' + trackingNo;
	    } else if(carrierName === '한진택배') {
	        url = 'https://www.hanjin.com/kor/CMS/DeliveryMgr/WaybillResult.do?mCode=MN038&schLang=KR&wblnumText2=' + trackingNo;
	    } else {
	        alert('지원하지 않는 택배사입니다.');
	        return;
	    }
	    
	    window.open(url, '_blank', 'width=800,height=600');
	}

	// 리뷰작성 함수
	function writeReview(orderItemId) {
	    location.href = '${pageContext.request.contextPath}/consumer/writeReview?orderItemId=' + orderItemId;
	}
	
	// 날짜 선택 스크립트
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