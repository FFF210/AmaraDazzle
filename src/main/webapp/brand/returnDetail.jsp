<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>반품 상세</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/dialog.css" />
<link rel="stylesheet" href="./css/alert.css" />
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
			<h3 class="modal-title">반품 요청 거절</h3>
			<p class="modal-subTitle">
				반품 요청을 거절하시겠습니까?<br>입력하신 사유는 고객에게 안내됩니다.
			</p>
			<div class="modal-body">
				<!-- 폼 내용 -->
				<div class="form-row">
					<label class="form-row-label">거절 사유(필수)</label>
					<my:textInput type="default" name="optionName"
						placeholder="예: 개봉된 상품은 반품이 불가합니다." size="sm" />
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
				<c:choose>
					<c:when test="${param.from eq 'order'}">
						<my:breadcrumb items="주문관리:/brand/orderList,주문상세:/brand/orderDetail?orderId=${param.orderId}&from=${param.from},반품상세" />
					</c:when>
					<c:otherwise>
						<my:breadcrumb items="반품관리:/brand/returnList,반품상세:" />
					</c:otherwise>
				</c:choose>
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>반품 상세</h2>
			</div>

			<!-- 반품 상세 폼 -->
			<form class="product-form">

				<section class="form-section">
					<h3>기본 정보</h3>
					<div class="form-group">
						<label>주문번호</label>
						<my:textInput type="link" state="default" size="lg"
							value="${returnDetail.summary.orderCode}"
							link="/brand/orderDetail?returnId=${returnDetail.summary.returnId}&orderId=${returnDetail.summary.orderId}&from=returnDetail" />
					</div>
					<div class="form-group">
						<label>반품 요청일</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${returnDetail.summary.returnRequestDate}" />
					</div>
					<div class="form-group tag">
						<label>반품상태</label>
						<c:choose>
							<c:when
								test="${returnDetail.summary.returnStatus == 'RETURN_REQUESTED'}">
								<my:tag color="yellow" size="lg" text="반품요청" />
							</c:when>
							<c:when
								test="${returnDetail.summary.returnStatus == 'RETURN_APPROVED'}">
								<my:tag color="yellow" size="lg" text="반품승인" />
							</c:when>
							<c:when
								test="${returnDetail.summary.returnStatus == 'RETURN_REFUNDING'}">
								<my:tag color="yellow" size="lg" text="환불대기" />
							</c:when>
							<c:when
								test="${returnDetail.summary.returnStatus == 'RETURN_REJECTED'}">
								<my:tag color="red" size="lg" text="반품거절" />
							</c:when>
							<c:when
								test="${returnDetail.summary.returnStatus == 'RETURN_COMPLETED'}">
								<my:tag color="green" size="lg" text="환불완료" />
							</c:when>
						</c:choose>
					</div>
				</section>

				<section class="form-section">
					<h3>반품 상품</h3>
					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>상품명</th>
									<th>옵션</th>
									<th>수량</th>
									<th class="sortable">환불금액 <i
										class="bi bi-dash-lg sort-icon"></i></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${returnDetail.items}"
									varStatus="loop">
									<tr>
										<td>${loop.index + 1}</td>
										<td>${item.productName}</td>
										<td>${item.optionName}</td>
										<td>${item.quantity}</td>
										<td><fmt:formatNumber value="${item.total}" type="number"
												maxFractionDigits="0" groupingUsed="true" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="form-group-br"></div>
					<div class="form-group">
						<label>반품사유</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${returnDetail.reason}" />
					</div>
					<c:if
						test="${not empty returnDetail.image1FileId 
                or not empty returnDetail.image2FileId 
                or not empty returnDetail.image3FileId}">
						<div class="form-group">
							<label>첨부파일</label>
							<div class="form-image-group">
								<c:if test="${not empty returnDetail.image1FileId}">
									<img
										src="${pageContext.request.contextPath}/image?fileId=${returnDetail.image1FileId}"
										alt="반품 사유 이미지" width="120px" height="120px" />
								</c:if>
								<c:if test="${not empty returnDetail.image2FileId}">
									<img
										src="${pageContext.request.contextPath}/image?fileId=${returnDetail.image2FileId}"
										alt="반품 사유 이미지" width="120px" height="120px" />
								</c:if>
								<c:if test="${not empty returnDetail.image3FileId}">
									<img
										src="${pageContext.request.contextPath}/image?fileId=${returnDetail.image3FileId}"
										alt="반품 사유 이미지" width="120px" height="120px" />
								</c:if>
							</div>
						</div>
					</c:if>
				</section>

				<fmt:formatNumber value="${returnDetail.summary.totalAmount}"
					type="number" var="fmtTotalAmount" />
				<fmt:formatNumber value="${returnDetail.summary.usingPoint}"
					type="number" var="fmtUsingPoint" />
				<fmt:formatNumber value="${returnDetail.summary.couponAmount}"
					type="number" var="fmtCouponAmount" />
				<fmt:formatNumber value="${returnDetail.summary.actualCancelAmount}"
					type="number" var="fmtActualCancelAmount" />
				<fmt:formatNumber value="${returnDetail.summary.shippingCost}"
					type="number" var="fmtShippingCost" />

				<section class="form-section">
					<h3>반품 처리</h3>
					<div class="form-group">
						<label>총 결제 금액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${fmtTotalAmount}" />
					</div>
					<div class="form-group">
						<label>쿠폰 할인액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${fmtCouponAmount}" />
					</div>
					<div class="form-group chip-wrapper">
						<label>쿠폰 내역</label>
						<div class="chip">${returnDetail.summary.couponName}</div>
					</div>
					<div class="form-group">
						<label>포인트 사용액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${fmtUsingPoint}" />
					</div>
					<div class="form-group">
						<label>실제 환불액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${fmtActualCancelAmount}" />
					</div>
					<div class="form-group">
						<label>반품비 부담 주체 <span class="required">*</span></label>
						<c:choose>
							<c:when
								test="${returnDetail.summary.shippingCostPayer == 'member'}">
								<my:textInput type="readOnly" state="default" size="lg"
									value="구매자 부담" />
							</c:when>
							<c:when
								test="${returnDetail.summary.shippingCostPayer == 'brand'}">
								<my:textInput type="readOnly" state="default" size="lg"
									value="판매자 부담" />
							</c:when>
						</c:choose>
					</div>
					<div class="form-group">
						<label>추가 결제 금액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${fmtShippingCost}" />
					</div>
					<c:choose>
						<c:when
							test="${returnDetail.summary.returnStatus == 'RETURN_APPROVED' || returnDetail.summary.returnStatus == 'RETURN_REFUNDING' || returnDetail.summary.returnStatus == 'RETURN_COMPLETED'}">
							<div class="form-group">
								<label>회수 송장번호</label>
								<my:textInput type="readOnly" state="default" size="lg"
									value="${returnDetail.summary.returnInvoice}" />
							</div>
						</c:when>
					</c:choose>
				</section>

				<!-- 버튼 상태 제어 -->
				<div class="form-actions" id="returnActions">
					<c:choose>
						<c:when
							test="${returnDetail.summary.returnStatus == 'RETURN_REQUESTED'}">
							<button type="button" class="btn btn-outline btn-xl"
								id="btnReject">거절</button>
							<button type="button" class="btn btn-primary btn-xl"
								id="btnApprove">승인</button>
						</c:when>
						<c:when
							test="${returnDetail.summary.returnStatus == 'RETURN_APPROVED'}">
							<button type="button" class="btn btn-primary btn-xl" id="btnShip">환불</button>
						</c:when>
						<c:when
							test="${returnDetail.summary.returnStatus == 'RETURN_REFUNDING'}">
							<my:tag color="green" size="lg" text="환불 처리중 (자동 완료 예정)" />
						</c:when>
						<c:when
							test="${returnDetail.summary.returnStatus == 'RETURN_COMPLETED'}">
							<my:tag color="green" size="lg" text="환불완료" />
						</c:when>
						<c:when
							test="${returnDetail.summary.returnStatus == 'RETURN_REJECTED'}">
							<my:tag color="red" size="sm"
								text="거절됨 (${returnDetail.summary.rejectionReason})" />
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
  const returnId = "${returnDetail.summary.returnId}";
  const actions = document.getElementById("returnActions");

  /**************************************
   * 반품 거절 (모달 열기)
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
        const resp = await fetch("/brand/returnReject", {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body:
            "returnId=" +
            encodeURIComponent(returnId) +
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
              message: "반품 요청이 거절되었습니다.",
            })
          );

          location.reload();
        } else {
          showToast("error", "반품 거절 처리 실패");
        }
      } catch (err) {
        console.error("반품 거절 요청 중 오류:", err);
      }
    });

  /**************************************
   * 반품 승인
   **************************************/
  document.getElementById("btnApprove")?.addEventListener("click", async () => {
    try {
      const resp = await fetch("/brand/returnApprove", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "returnId=" + encodeURIComponent(returnId),
      });

      const data = await resp.json();

      if (data.success) {
        localStorage.setItem(
          "toast",
          JSON.stringify({
            type: "success",
            message: "반품이 승인되었습니다.",
          })
        );
        location.reload();
      } else {
        showToast("error", "반품 승인 실패");
      }
    } catch (err) {
      console.error("반품 승인 중 오류:", err);
    }
  });

  /**************************************
   * 환불 처리 (자동 완료)
   **************************************/
  document.addEventListener("click", async (e) => {
    if (e.target.id === "btnShip") {
      try {
        const resp = await fetch("/brand/returnShip", {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body: "returnId=" + encodeURIComponent(returnId),
        });

        const data = await resp.json();

        if (data.success) {
          // 즉시 UI 업데이트 (새로고침 없이)
          if (actions) {
            actions.innerHTML =
              '<span class="tag green lg">환불 처리중 (자동 완료 예정)</span>';
          }

          showToast("success", "환불 처리가 시작되었습니다. 잠시 후 자동 완료됩니다.");

          // 일정 시간(3초) 후 자동 완료 실행
          setTimeout(async () => {
            try {
              const completeResp = await fetch("/brand/returnAutoComplete", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "returnId=" + encodeURIComponent(returnId),
              });

              const completeData = await completeResp.json();

              if (completeData.success) {
                if (actions) {
                  actions.innerHTML = '<span class="tag green lg">환불 완료</span>';
                }

                showToast("success", "환불이 자동 완료되었습니다.");
                
                location.reload();
              } else {
                showToast("error", "환불 자동 완료 실패");
              }
            } catch (err) {
              console.error("환불 자동 완료 중 오류:", err);
            }
          }, 3000); // 3초 뒤 자동 완료
        } else {
          showToast("error", "환불 처리 실패");
        }
      } catch (err) {
        console.error("환불 요청 중 오류:", err);
      }
    }
  });
});
</script>

</body>
</html>
