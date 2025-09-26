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
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
</head>
<body>
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
						<label> <input type="radio" name="discountType" value="RATE"
							class="form-radio" />정률
						</label> <label> <input type="radio" name="discountType" value="AMOUNT"
							class="form-radio" />정액
						</label>
					</div>
				</div>
				<div class="form-row">
					<label class="form-row-label">할인율 또는 금액</label>
					<my:textInput type="default" name="discountValue" placeholder="20 또는 2,000" size="sm" />
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
			<h3 class="modal-title">상품을 삭제할 수 없습니다.</h3>
			<p class="modal-subTitle">
				해당 상품은 주문, 찜, 리뷰와<br>연결된 데이터가 있어 삭제할 수 없습니다. <br>대신 <span>판매중지
					상태로 변경됩니다.</span>
			</p>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline btn-md"
					data-action="취소">취소</button>
				<button type="button" class="btn btn-primary btn-md"
					data-action="확인">확인</button>
			</div>
		</div>
	</div>

	<!-- 삭제 모달 -->
	<div id="deleteDialog" class="modal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">상품을 삭제하시겠습니까?</h3>
			<p class="modal-subTitle">
				삭제된 상품은 복구할 수 없습니다.<br>정말 삭제하시겠습니까?
			</p>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline btn-md"
					data-action="취소">취소</button>
				<button type="button" class="btn btn-primary btn-md"
					data-action="삭제">삭제</button>
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
								<th><input type="checkbox" class="form-check" /></th>
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
									<td><input type="checkbox" class="form-check" /></td>
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
									<td><fmt:formatNumber value="${product.salePrice}"
											type="number" maxFractionDigits="0" groupingUsed="true" /></td>
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
											<button type="button" class="btn btn-outline btn-sm" id=" ">수정</button>
											<button type="button"
												class="btn btn-danger btn-sm btn-delete"
												data-product-id="${product.productId}"
												data-sales-qty="${product.salesQty}"
												data-has-wishlist="${product.hasWishlist}"
												data-review-count="${product.reviewCount}">삭제</button>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}" baseUrl="/brand/products?page=" />
			</div>
		</div>
	</my:layout>

	<script src="./js/dialog.js"></script>
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
   * 모달 오픈 이벤트
   *********************************************************************************************************/
  // 세일 등록 모달 열기
  document.getElementById("openSaleDialog").addEventListener("click", () => {
    openDialog("saleDialog");
  });
  
  // 재고 변경 모달 열기
  document.querySelectorAll(".btn-stock").forEach(btn => {
    btn.addEventListener("click", () => {
      const productId = btn.dataset.productId;
      const stock = btn.dataset.stock;

      // 모달 안에 현재 재고 채워 넣기
      const stockDialog = document.getElementById("stockDialog");
      stockDialog.querySelector("input[name='currentStock']").value = stock;
      stockDialog.querySelector("input[name='newStock']").value = "";
      stockDialog.dataset.productId = productId;

      openDialog("stockDialog");
    });
  });

  // 삭제 모달 열기
  document.querySelectorAll(".btn-delete").forEach(btn => {
    btn.addEventListener("click", () => {
    	const salesQty = Number(btn.dataset.salesQty);     
        const hasWishlist = btn.dataset.hasWishlist === "true"; 
        const reviewCount = Number(btn.dataset.reviewCount); 
        
        if (salesQty > 0 || hasWishlist || reviewCount > 0) {
        	openDialog("stopSaleDialog");   // 판매중지 모달
      	} else {
        	openDialog("deleteDialog");     // 삭제 모달
      	}
    });
  });
  
  /*********************************************************************************************************
   * 모달 버튼 액션 이벤트 
   *********************************************************************************************************/
  const dialogHandlers = {
    saleDialog: {
      저장: () => {
    	const saleDialog = document.getElementById("saleDialog");
    	const discountType = saleDialog.querySelector("input[name='discountType']:checked")?.value;
    	const discountValue = saleDialog.querySelector("input[name='discountValue']").value;
        const startDate = saleDialog.querySelector("input[name='startDate']").value;
        const endDate = saleDialog.querySelector("input[name='endDate']").value;
        
        if (!discountType || !discountValue || !startDate || !endDate) {
            alert("모든 항목을 입력해주세요.");
            return;
          }
        
        console.log("세일 등록 요청:", { discountType, discountValue, startDate, endDate });
        // TODO: Ajax 호출
      }
    },
    stockDialog: {
      변경: () => {
        const stockDialog = document.getElementById("stockDialog");
        const productId = stockDialog.dataset.productId;
        const newStock = stockDialog.querySelector("input[name='newStock']").value;

        if (!newStock || Number(newStock) < 0) {
          alert("재고 수량을 올바르게 입력해주세요.");
          return;
        }

        console.log("재고 변경 요청:", { productId, newStock });
        // TODO: Ajax 호출
      }
    },
    deleteDialog: {
      삭제: () => {
        console.log("상품 삭제 요청 실행");
        // TODO: Ajax 호출
      }
    },
    stopSaleDialog: {
      확인: () => {
        console.log("판매중지 처리 실행");
        // TODO: Ajax 호출
      }
    }
  };

  // 공통 이벤트 리스너
  document.addEventListener("dialogAction", (e) => {
    const { id, action } = e.detail;

    // 매핑된 핸들러 실행
    const handler = dialogHandlers[id]?.[action];
    if (handler) {
      handler();
    } else {
      console.warn(`핸들러 없음: id=${id}, action=${action}`);
    }
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
