<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>상품 목록</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/dialog.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/alert.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
</head>
<body>
	<!-- Toast 알림 컨테이너 -->
	<div id="toast-container"></div>

	<!-- 세일 모달 -->
	<div id="saleDialog" class="modal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">세일 등록하기</h3>
			<p class="modal-subTitle">
				할인율과 기간을 설정하면,<br>즉시 세일이 적용됩니다.
			</p>
			<div class="modal-body">
				<!-- 폼 내용 -->
				<div class="form-row">
					<label class="form-row-label">할인 방식</label>
					<div class="radio-wrapper">
						<label> <input type="radio" name="discountType"
							value="RATE" class="form-radio" />정률
						</label> <label> <input type="radio" name="discountType"
							value="AMOUNT" class="form-radio" />정액
						</label>
					</div>
				</div>
				<div class="form-row">
					<label class="form-row-label">할인율 또는 금액</label>
					<my:textInput type="default" name="discountValue"
						placeholder="20 또는 2,000" size="sm" />
				</div>
				<div class="form-row">
					<label class="form-row-label">기간 (시작-종료)</label>
					<my:dateInput type="input" name="startDate" value="2025-09-02" />
					<my:dateInput type="input" name="endDate" value="2025-09-02" />
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline btn-md"
					data-action="취소">취소</button>
				<button type="button" class="btn btn-primary btn-md"
					data-action="저장">저장</button>
			</div>
		</div>
	</div>

	<!-- 재고 변경 모달 -->
	<div id="stockDialog" class="modal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">상품 재고 변경</h3>
			<p class="modal-subTitle">
				해당 상품의 재고 수량을 변경할 수 있습니다.<br>변경된 재고는 즉시 적용됩니다.
			</p>
			<div class="modal-body">
				<!-- 폼 내용 -->
				<div class="form-row">
					<label class="form-row-label">현재 재고</label>
					<my:textInput type="readOnly" name="currentStock" size="sm" />
				</div>
				<div class="form-row">
					<label class="form-row-label">새로운 재고</label>
					<my:textInput type="default" name="newStock" placeholder="0"
						size="sm" />
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline btn-md"
					data-action="취소">취소</button>
				<button type="button" class="btn btn-primary btn-md"
					data-action="변경">변경</button>
			</div>
		</div>
	</div>

	<!-- 판매 중지 모달 -->
	<div id="stopSaleDialog" class="modal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">판매 중지</h3>
			<p class="modal-subTitle">
				해당 상품은 주문, 찜, 리뷰와<br>연결된 데이터가 있어 삭제할 수 없습니다. <br> <span>대신
					판매중지 상태로 변경됩니다.</span>
			</p>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline btn-md"
					data-action="취소">취소</button>
				<button type="button" class="btn btn-primary btn-md"
					data-action="확인">확인</button>
			</div>
		</div>
	</div>

	<!-- 상품 공개 모달 -->
	<div id="releaseSaleDialog" class="modal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">판매 재개</h3>
			<p class="modal-subTitle">
				현재 상품을 다시 판매 상태로 변경합니다.<br>변경 후에는 고객이 상품을 주문할 수 있습니다.
			</p>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline btn-md"
					data-action="취소">취소</button>
				<button type="button" class="btn btn-primary btn-md"
					data-action="확인">확인</button>
			</div>
		</div>
	</div>

	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="상품목록:" />
			</div>

			<!-- 세일 등록 버튼 -->
			<div class="page-openSaleDialog">
				<button type="button" class="btn btn-primary btn-md"
					id="openSaleDialog">세일 등록</button>
			</div>

			<!-- 테이블 필터 -->
			<div class="page-tableFilter">
				<my:tableFilter
					filters="판매상태:ALL=전체|SALE=판매중|SOLD_OUT=품절|STOP_SALE=판매중지"
					hasDate="false" searchItems="상품명,카테고리" />
			</div>

			<!-- 총 건수 -->
			<div class="page-totalCount">
				<p>총 ${totalCount} 건</p>
			</div>

			<!-- 결과 테이블 -->
			<div class="page-table">
				<div class="table-wrapper">
					<table class="table">
						<thead>
							<tr>
								<th><input type="checkbox" id="selectAll"
									class="form-check" /></th>
								<th class="sortable">번호 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>상품코드</th>
								<th>상품명</th>
								<th>카테고리</th>
								<th class="sortable">판매가 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">할인가 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>판매상태</th>
								<th class="sortable">재고 수 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">누적 판매수 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">리뷰 수 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th>작업</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="product" items="${productList}" varStatus="loop">
								<tr>
									<td><input type="checkbox"
										class="form-check product-checkbox"
										value="${product.productId}" /></td>
									<td>${loop.index + 1}</td>
									<td>${product.productId}</td>
									<td>
										<div class="product-name">
											<p>${product.name}</p>
										</div>
									</td>
									<td>${product.categoryPath}</td>
									<td><fmt:formatNumber value="${product.price}"
											type="number" maxFractionDigits="0" groupingUsed="true" /></td>
									<td><c:choose>
											<c:when test="${product.salePrice lt product.price}">
												<span class="sale-price"> <fmt:formatNumber
														value="${product.salePrice}" type="number"
														maxFractionDigits="0" groupingUsed="true" />
												</span>
											</c:when>
											<c:otherwise>
												<fmt:formatNumber value="${product.salePrice}" type="number"
													maxFractionDigits="0" groupingUsed="true" />
											</c:otherwise>
										</c:choose></td>
									<td><my:tag
											color="${product.status == 'SALE' ? 'green' : (product.status == 'SOLD_OUT' ? 'red' : 'gray')}"
											size="sm" text="${product.status.getDescription()}" /></td>
									<td>${product.stockQty}</td>
									<td>${product.salesQty}</td>
									<td>${product.reviewCount}</td>
									<td>
										<div class="actions">
											<button type="button"
												class="btn btn-outline btn-sm btn-stock"
												data-product-id="${product.productId}"
												data-stock="${product.stockQty}">재고 수정</button>
											<button type="button" class="btn btn-outline btn-sm btn-edit"
												data-product-id="${product.productId}">수정</button>
											<c:choose>
												<c:when test="${product.isVisible eq 0}">
													<button type="button"
														class="btn btn-outline btn-sm btn-release"
														data-product-id="${product.productId}">판매</button>
												</c:when>
												<c:otherwise>
													<button type="button"
														class="btn btn-danger btn-sm btn-delete"
														data-product-id="${product.productId}">중지</button>
												</c:otherwise>
											</c:choose>

										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<c:set var="queryString"> status=${param.status}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}&page=</c:set>

			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}"
					baseUrl="/brand/productList?${queryString}" />
			</div>
		</div>
	</my:layout>

	<script src="./js/dialog.js"></script>
	<script src="./js/toast.js"></script>
	<script src="./js/selectbox.js"></script>
	<script>
	
  /*********************************************************************************************************
   * tableFilter 이벤트
   *********************************************************************************************************/
  document.addEventListener("filterChanged", (e) => {
  console.log("필터 상태:", e.detail);

  if (e.detail.submit) {
    const { filters, searchField, searchKeyword } = e.detail;
    const params = new URLSearchParams();

    // 판매상태
    for (const [key, value] of Object.entries(filters)) {
    	  params.append("status", value);
    	}

    if (searchField) params.append("searchType", searchField);
    if (searchKeyword) params.append("searchKeyword", searchKeyword);

    // 페이지는 1부터 시작
    params.append("page", 1);

    // 최종 URL로 이동 (GET 요청)
    window.location.href = "/brand/productList?" + params.toString();
  }
});
  
  /*********************************************************************************************************
   * 모달 Ajax
   *********************************************************************************************************/
   const sendAjax = (data) => {
	    return fetch("/brand/productList", {
	      method: "POST",
	      headers: { "Content-Type": "application/x-www-form-urlencoded" },
	      body: new URLSearchParams(data)
	    }).then(res => res.json());
	  };
	  
  const dialogHandlers = {
    saleDialog: {
      저장: async() => {
    	const dialog = document.getElementById("saleDialog");
    	const discountType = dialog.querySelector("input[name='discountType']:checked")?.value;
    	const discountValue = dialog.querySelector("input[name='discountValue']").value;
        const startDate = dialog.querySelector("input[name='startDate']").value;
        const endDate = dialog.querySelector("input[name='endDate']").value;
        
     // 체크된 상품 ID 모으기
        const selectedProducts = Array.from(
          document.querySelectorAll(".product-checkbox:checked")
        ).map(cb => cb.value);

        if (!discountType || !discountValue || !startDate || !endDate) {
          showToast("warning", "모든 항목을 입력해주세요.");
          return;
        } else if (selectedProducts.length === 0) {
          showToast("warning", "세일을 적용할 상품을 선택해주세요.");
          return;
        }
        
        const result = await sendAjax({
            action: "sale",
            discountType, discountValue, startDate, endDate,
            productIds: selectedProducts
          });
        
        if (result.result === "success") {
            localStorage.setItem("toast", JSON.stringify({
              type: "success",
              message: "세일이 등록되었습니다."
            }));
            location.reload();
          } else {
            showToast("error", result.message || "세일 등록 실패");
          }
        }
    },
    stockDialog: {
      변경: async() => {
        const dialog = document.getElementById("stockDialog");
        const productId = dialog.dataset.productId;
        const newStock = dialog.querySelector("input[name='newStock']").value;

        if (!newStock || Number(newStock) < 0) {
        	showToast("error", "재고 수량을 올바르게 입력해주세요.");
          return;
        }

        const result = await sendAjax({ action: "stock", productId, newStock });
        
        if (result.result === "success") {
            localStorage.setItem("toast", JSON.stringify({
              type: "success",
              message: "재고가 변경되었습니다."
            }));
            location.reload();
          } else {
            showToast("error", result.message || "재고 변경 실패", "실패");
          }
       }
    },
    stopSaleDialog: {
      확인: async() => {
    	  const dialog = document.getElementById("stopSaleDialog");
          const productId = dialog.dataset.productId;

    	  const result = await sendAjax({ action: "delete", productId });
    	  if (result.result === "success") {
    	        localStorage.setItem("toast", JSON.stringify({
    	          type: "info",
    	          message: "상품이 판매중지 상태로 변경되었습니다."
    	        }));
    	        location.reload();
    	     } else {
    	        showToast("error", result.message || "판매중지 실패");
    	   }
      }
  },
  		releaseSaleDialog: {
		    확인: async () => {
		      const dialog = document.getElementById("releaseSaleDialog");
		      const productId = dialog.dataset.productId;
	
		      const result = await sendAjax({ action: "release", productId });
	
		      if (result.result === "success") {
		        localStorage.setItem("toast", JSON.stringify({
		          type: "success",
		          message: "상품이 판매 상태로 변경되었습니다."
		        }));
		        location.reload();
		      } else {
		        showToast("error", result.message || "판매 재개 실패");
		      }
		    }
	  }
	};

  /*********************************************************************************************************
   * 모달 오픈
   *********************************************************************************************************/
  //공통 이벤트 연결
  document.addEventListener("dialogAction", (e) => {
    const { id, action } = e.detail;
    dialogHandlers[id]?.[action]?.();
  });

  // 버튼 이벤트: 모달 열기
  // 세일 등록 버튼
  document.getElementById("openSaleDialog").addEventListener("click", () => openDialog("saleDialog"));
  // 재고 변경 버튼
  document.querySelectorAll(".btn-stock").forEach(btn => {
    btn.addEventListener("click", () => {
      const stockDialog = document.getElementById("stockDialog");
      stockDialog.querySelector("input[name='currentStock']").value = btn.dataset.stock;
      stockDialog.querySelector("input[name='newStock']").value = "";
      stockDialog.dataset.productId = btn.dataset.productId;
      openDialog("stockDialog");
    });
  });
  // 판매 중지 버튼
  document.querySelectorAll(".btn-delete").forEach(btn => {
    btn.addEventListener("click", () => {
      const stopSaleDialog = document.getElementById("stopSaleDialog");
      stopSaleDialog.dataset.productId = btn.dataset.productId;
      openDialog("stopSaleDialog");
    });
  });
  //판매 재개 버튼
  document.querySelectorAll(".btn-release").forEach(btn => {
    btn.addEventListener("click", () => {
      const releaseSaleDialog = document.getElementById("releaseSaleDialog");
      releaseSaleDialog.dataset.productId = btn.dataset.productId;
      openDialog("releaseSaleDialog");
    });
  });
  
  //수정 버튼 클릭 → 상세 페이지 이동
  document.querySelectorAll(".btn-edit").forEach(btn => {
  btn.addEventListener("click", () => {
    const productId = btn.dataset.productId;   // 버튼의 data-product-id 값 가져오기
    window.location.href = "/brand/productDetail?productId=" + productId;
  });
});

  /*********************************************************************************************************
   * 테이블 체크박스
   *********************************************************************************************************/
  // 전체 선택 체크박스
   const selectAll = document.getElementById("selectAll");

   // 개별 상품 체크박스
   const productCheckboxes = document.querySelectorAll(".product-checkbox");

   // 전체 선택 → 하위 모두 체크
   selectAll.addEventListener("change", (e) => {
     productCheckboxes.forEach(cb => {
       cb.checked = e.target.checked;
     });
   });

   // 개별 선택 → 전체 선택 상태 업데이트
   productCheckboxes.forEach(cb => {
     cb.addEventListener("change", () => {
       // 모두 체크된 경우에만 selectAll 체크
       selectAll.checked = Array.from(productCheckboxes).every(c => c.checked);
     });
   });

  /*********************************************************************************************************
   * 테이블 정렬
   *********************************************************************************************************/
  document.querySelectorAll(".table th.sortable").forEach(th => {
	  th.addEventListener("click", () => {
	    // 모든 헤더 초기화
	    document.querySelectorAll(".table th.sortable").forEach(other => {
	      if (other !== th) {
	        other.classList.remove("asc", "desc");
	        other.querySelector(".sort-icon").className = "bi bi-dash-lg sort-icon";
	      }
	    });

	    const icon = th.querySelector(".sort-icon");

	    if (th.classList.contains("asc")) {
	      th.classList.remove("asc");
	      th.classList.add("desc");
	      icon.className = "bi bi-caret-down-fill sort-icon";
	    } else if (th.classList.contains("desc")) {
	      th.classList.remove("desc");
	      icon.className = "bi bi-dash-lg sort-icon"; // 기본 상태
	    } else {
	      th.classList.add("asc");
	      icon.className = "bi bi-caret-up-fill sort-icon";
	    }
	  });
	});
</script>
</body>
</html>
