<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>교환 상세</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/dialog.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/dialog.css" />
<link rel="stylesheet" href="./css/detailForm.css" />
<script src="${pageContext.request.contextPath}/resources/js/toast.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/dialog.js"></script>
</head>
<body>
	<!-- Toast 알림 컨테이너 -->
	<div id="toast-container"></div>

	<!-- 옵션 모달 -->
	<div id="optionDialog" class="modal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">교환 요청 거절</h3>
			<p class="modal-subTitle">
				교환 요청을 거절하시겠습니까?<br>입력하신 사유는 고객에게 안내됩니다.
			</p>
			<div class="modal-body">
				<!-- 폼 내용 -->
				<div class="form-row">
					<label class="form-row-label">거절 사유(필수)</label>
					<my:textInput type="default" name="optionName"
						placeholder="예: 요청하신 옵션은 현재 재고가 없습니다." size="sm" />
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline btn-md"
					data-action="취소">취소</button>
				<button type="button" class="btn btn-primary btn-md"
					data-action="추가">거절 확정</button>
			</div>
		</div>
	</div>

	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="교환관리:/brand/exchangeList,교환상세:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>교환 상세</h2>
			</div>

			<!-- 교환 상세 폼 -->
			<form class="product-form">

				<section class="form-section">
					<h3>기본 정보</h3>
					<div class="form-group">
						<label>주문번호</label>
						<my:textInput type="link" state="default" size="lg"
							value="${exchangeDetail.orderCode}"
							link="/brand/orderDetail?exchangeId=${exchangeDetail.exchangeId}&orderId=${exchangeDetail.orderId}&from=exchangeDetail" />
					</div>
					<div class="form-group">
						<label>교환 요청일</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${exchangeDetail.exchangeRequestDate}" />
					</div>
					<div class="form-group tag">
						<label>교환상태</label>
						<c:choose>
							<c:when
								test="${exchangeDetail.exchangeStatus == 'EXCHANGE_REQUESTED'}">
								<my:tag color="yellow" size="lg" text="교환요청" />
							</c:when>
							<c:when
								test="${exchangeDetail.exchangeStatus == 'EXCHANGE_APPROVED'}">
								<my:tag color="yellow" size="lg" text="교환승인" />
							</c:when>
							<c:when
								test="${exchangeDetail.exchangeStatus == 'EXCHANGE_SHIPPING'}">
								<my:tag color="yellow" size="lg" text="교환배송중" />
							</c:when>
							<c:when
								test="${exchangeDetail.exchangeStatus == 'EXCHANGE_REJECTED'}">
								<my:tag color="red" size="lg" text="교환거절" />
							</c:when>
							<c:when
								test="${exchangeDetail.exchangeStatus == 'EXCHANGE_COMPLETED'}">
								<my:tag color="green" size="lg" text="교환완료" />
							</c:when>
						</c:choose>
					</div>
				</section>

				<section class="form-section">
					<h3>교환 상품</h3>
					<div class="form-group">
						<label>상품명</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${exchangeDetail.productName}" />
					</div>
					<div class="form-group">
						<label>옵션</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${exchangeDetail.originalOptionName}" />
					</div>
					<div class="form-group">
						<label>수량</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${exchangeDetail.quantity}" />
					</div>
					<div class="form-group">
						<label>희망옵션</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${exchangeDetail.desiredOptionName}" />
					</div>
					<div class="form-group">
						<label>요청사유</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${exchangeDetail.reason}" />
					</div>

					<c:if
						test="${not empty exchangeDetail.image1FileId 
                or not empty exchangeDetail.image2FileId 
                or not empty exchangeDetail.image3FileId}">
						<div class="form-group">
							<label>첨부파일</label>
							<div class="form-image-group">
								<c:if test="${not empty exchangeDetail.image1FileId}">
									<img
										src="${pageContext.request.contextPath}/image?fileId=${exchangeDetail.image1FileId}"
										alt="교환 사유 이미지" width="120px" height="120px"/>
								</c:if>
								<c:if test="${not empty exchangeDetail.image2FileId}">
									<img
										src="${pageContext.request.contextPath}/image?fileId=${exchangeDetail.image2FileId}"
										alt="교환 사유 이미지" width="120px" height="120px"/>
								</c:if>
								<c:if test="${not empty exchangeDetail.image3FileId}">
									<img
										src="${pageContext.request.contextPath}/image?fileId=${exchangeDetail.image3FileId}"
										alt="교환 사유 이미지" width="120px" height="120px"/>
								</c:if>
							</div>
						</div>
					</c:if>
				</section>

				<section class="form-section">
					<h3>교환 처리</h3>
					<div class="form-group tag">
						<label>재고 확인 결과</label>
						<c:choose>
							<c:when test="${exchangeDetail.stockStatus == '재고없음'}">
								<my:tag color="red" size="lg" text="재고없음" />
							</c:when>
							<c:when test="${exchangeDetail.stockStatus == '재고있음'}">
								<my:tag color="green" size="lg" text="재고있음" />
							</c:when>
						</c:choose>
					</div>
					<div class="form-group">
						<label>교환비 부담 주체</label>
						<c:choose>
							<c:when test="${exchangeDetail.shippingCostPayer == 'member'}">
								<my:textInput type="readOnly" state="default" size="lg"
									value="구매자 부담" />
							</c:when>
							<c:when test="${exchangeDetail.shippingCostPayer == 'brand'}">
								<my:textInput type="readOnly" state="default" size="lg"
									value="판매자 부담" />
							</c:when>
						</c:choose>
					</div>
					<fmt:formatNumber value="${exchangeDetail.shippingCost}"
						type="number" var="fmtShippingCost" />
					<div class="form-group">
						<label>추가 결제 금액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${fmtShippingCost}" />
					</div>

					<c:choose>
						<c:when
							test="${exchangeDetail.exchangeStatus == 'EXCHANGE_APPROVED' || exchangeDetail.exchangeStatus == 'EXCHANGE_SHIPPING' || exchangeDetail.exchangeStatus == 'EXCHANGE_COMPLETED'}">
							<div class="form-group">
								<label>회수 송장번호</label>
								<my:textInput type="readOnly" state="default" size="lg"
									value="${exchangeDetail.returnInvoice}" />
							</div>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when
							test="${exchangeDetail.exchangeStatus == 'EXCHANGE_APPROVED'}">
							<div class="form-group">
								<label>발송 송장번호 <span class="required">*</span></label>
								<my:textInput type="default" state="default" size="lg"
									name="shippingTrackingNo" placeholder="운송장번호를 입력하세요" value="" />
							</div>
						</c:when>
						<c:when
							test="${exchangeDetail.exchangeStatus == 'EXCHANGE_SHIPPING' || exchangeDetail.exchangeStatus == 'EXCHANGE_COMPLETED'}">
							<div class="form-group">
								<label>발송 송장번호</label>
								<my:textInput type="readOnly" state="default" size="lg"
									value="${exchangeDetail.exchangeInvoice}" />
							</div>
						</c:when>
					</c:choose>
				</section>

				<!-- 버튼 상태 제어 -->
				<div class="form-actions" id="exchangeActions">
					<c:choose>
						<c:when
							test="${exchangeDetail.exchangeStatus == 'EXCHANGE_REQUESTED'}">
							<button type="button" class="btn btn-outline btn-xl"
								id="btnReject">거절</button>
							<button type="button" class="btn btn-primary btn-xl"
								id="btnApprove">승인</button>
						</c:when>
						<c:when
							test="${exchangeDetail.exchangeStatus == 'EXCHANGE_APPROVED'}">
							<button type="button" class="btn btn-primary btn-xl" id="btnShip">배송</button>
						</c:when>
						<c:when
							test="${exchangeDetail.exchangeStatus == 'EXCHANGE_SHIPPING'}">
							<my:tag color="green" size="lg" text="배송중 (자동 완료 예정)" />
						</c:when>
						<c:when
							test="${exchangeDetail.exchangeStatus == 'EXCHANGE_COMPLETED'}">
							<my:tag color="green" size="lg" text="교환완료" />
						</c:when>
						<c:when
							test="${exchangeDetail.exchangeStatus == 'EXCHANGE_REJECTED'}">
							<my:tag color="red" size="sm"
								text="거절됨 (${exchangeDetail.rejectionReason})" />
						</c:when>
					</c:choose>
				</div>
			</form>
		</div>
	</my:layout>
	<script>
	/*********************************************************************************************************
	 * 모달 열기 / 닫기 / 리셋
	 *********************************************************************************************************/
	function openDialog(id) {
	  const dialog = document.getElementById(id);
	  if (!dialog) return;
	  dialog.classList.add("show");
	  dialog.querySelector(".modal-overlay").addEventListener("click", () => closeDialog(id));
	}

	function closeDialog(id) {
	  const dialog = document.getElementById(id);
	  if (!dialog) return;
	  dialog.classList.remove("show");
	}

	function resetOptionDialog() {
	  const dialog = document.getElementById("optionDialog");
	  if (!dialog) return;
	  dialog.querySelectorAll("input").forEach(input => (input.value = ""));
	}

	/*********************************************************************************************************
	 * DOM 로드 후 이벤트 바인딩
	 *********************************************************************************************************/
	document.addEventListener("DOMContentLoaded", () => {
	  const exchangeId = "${exchangeDetail.exchangeId}";
	  const actions = document.getElementById("exchangeActions");

	  /**************************************
	   * 교환 거절 (모달 열기)
	   **************************************/
	  document.getElementById("btnReject")?.addEventListener("click", () => {
	    resetOptionDialog();
	    openDialog("optionDialog");
	  });

	  /**************************************
	   * 모달 내부 버튼
	   **************************************/
	  document
	    .querySelector("#optionDialog [data-action='취소']")
	    ?.addEventListener("click", () => {
	      closeDialog("optionDialog");
	    });

	  document
	    .querySelector("#optionDialog [data-action='추가']")
	    ?.addEventListener("click", async () => {
	      const reason = document
	        .querySelector("#optionDialog input[name='optionName']")
	        .value.trim();

	      if (!reason) {
	        showToast("error", "거절 사유를 입력하세요");
	        return;
	      }

	      try {
	        const resp = await fetch("/brand/exchangeReject", {
	          method: "POST",
	          headers: { "Content-Type": "application/x-www-form-urlencoded" },
	          body:
	            "exchangeId=" +
	            encodeURIComponent(exchangeId) +
	            "&reason=" +
	            encodeURIComponent(reason),
	        });

	        const data = await resp.json();

	        if (data.success) {
	          closeDialog("optionDialog");

	          localStorage.setItem(
	            "toast",
	            JSON.stringify({
	              type: "success",
	              message: "교환 요청이 거절되었습니다.",
	            })
	          );

	          location.reload();
	        } else {
	          showToast("error", "거절 처리 실패");
	        }
	      } catch (err) {
	        console.error("거절 요청 중 오류:", err);
	      }
	    });

	  /**************************************
	   * 교환 승인
	   **************************************/
	  document.getElementById("btnApprove")?.addEventListener("click", async () => {
	    try {
	      const resp = await fetch("/brand/exchangeApprove", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: "exchangeId=" + encodeURIComponent(exchangeId),
	      });

	      const data = await resp.json();

	      if (data.success) {
	        localStorage.setItem(
	          "toast",
	          JSON.stringify({
	            type: "success",
	            message: "교환이 승인되었습니다.",
	          })
	        );
	        location.reload();
	      } else {
	        showToast("error", "교환 승인 실패");
	      }
	    } catch (err) {
	      console.error("교환 승인 중 오류:", err);
	    }
	  });

	  /**************************************
	   * 교환 배송
	   **************************************/
	  document.addEventListener("click", async (e) => {
	    if (e.target.id === "btnShip") {
	      const trackingInput = document.querySelector("input[name='shippingTrackingNo']");
	      if (!trackingInput) {
	        showToast("error", "발송 송장번호 입력 필드를 찾을 수 없습니다.");
	        return;
	      }

	      const trackingNo = trackingInput.value.trim();
	      if (!trackingNo) {
	        showToast("warning", "발송 송장번호를 입력해주세요.");
	        trackingInput.focus();
	        return;
	      }

	      try {
	        const resp = await fetch("/brand/exchangeShip", {
	          method: "POST",
	          headers: { "Content-Type": "application/x-www-form-urlencoded" },
	          body:
	            "exchangeId=" +
	            encodeURIComponent(exchangeId) +
	            "&trackingNo=" +
	            encodeURIComponent(trackingNo),
	        });

	        const data = await resp.json();

	        if (data.success) {
	          // UI 즉시 갱신 (새로고침 없이)
	          const actions = document.getElementById("exchangeActions");
	          if (actions) {
	            actions.innerHTML =
	              '<span class="tag green lg">배송중 (자동 완료 예정)</span>';
	          }

	          // 입력 비활성화
	          trackingInput.setAttribute("readonly", true);

	          // Toast 알림
	          showToast("success", "배송 처리가 완료되었습니다. 일정 시간 후 자동 완료됩니다.");

	          // 일정 시간(3초) 후 자동 완료 실행
	          setTimeout(async () => {
	            try {
	              const completeResp = await fetch("/brand/exchangeAutoComplete", {
	                method: "POST",
	                headers: { "Content-Type": "application/x-www-form-urlencoded" },
	                body: "exchangeId=" + encodeURIComponent(exchangeId),
	              });

	              const completeData = await completeResp.json();

	              if (completeData.success) {
	                // UI 갱신
	                if (actions) {
	                  actions.innerHTML =
	                    '<span class="tag green lg">교환 완료</span>';
	                }

	                showToast("success", "교환이 자동 완료되었습니다.");
	              } else {
	                showToast("error", "교환 자동 완료 실패");
	              }
	            } catch (err) {
	              console.error("자동 완료 중 오류:", err);
	            }
	          }, 3000); // 3초 뒤 자동 완료
	        } else {
	          showToast("error", "배송 처리 실패");
	        }
	      } catch (err) {
	        console.error("배송 요청 중 오류:", err);
	      }
	    }
	  });


	});
	</script>
</body>
</html>
