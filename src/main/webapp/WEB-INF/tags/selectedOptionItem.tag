<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
    SelectedOptionItem 커스텀 태그

    속성(Props)
    • name   : 상품명
    • price  : 가격 (숫자)
    • count  : 초기 수량 (기본 0)

    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <my:selectedOptionItem name="상품이름" price="10000" count="0" />
================================ --%>

<%@ attribute name="name" required="true"%>
<%@ attribute name="price" required="true"%>
<%@ attribute name="count" required="false"%>

<c:set var="count" value="${empty count ? 0 : count}" />

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

<div class="product-item">

	<div class="product-name">${name}</div>

	<div class="item-info">
		<div class="quantity-control">
			<button type="button" class="btn-decrease">
				<i class="bi bi-dash"></i>
			</button>
			<input type="text" class="quantity-input" value="${count}" readonly />
			<button type="button" class="btn-increase">
				<i class="bi bi-plus"></i>
			</button>
		</div>

		<div class="product-price">
			<span><c:out value="${price}" />원</span>
			<button type="button" class="btn-remove">
				<i class="bi bi-x"></i>
			</button>
		</div>
	</div>
</div>

<script>
document.addEventListener("click", (e) => {
	  if (e.target.closest(".btn-increase")) {
	    const item = e.target.closest(".product-item");
	    const input = item.querySelector(".quantity-input");
	    let val = parseInt(input.value) || 0;
	    input.value = val + 1;
	  }

	  if (e.target.closest(".btn-decrease")) {
	    const item = e.target.closest(".product-item");
	    const input = item.querySelector(".quantity-input");
	    let val = parseInt(input.value) || 0;
	    if (val > 0) input.value = val - 1;
	  }

	  if (e.target.closest(".btn-remove")) {
	    const item = e.target.closest(".product-item");
	    item.remove();
	    const event = new CustomEvent("productRemoved", {
	      detail: { name: item.querySelector(".product-name").textContent }
	    });
	    document.dispatchEvent(event);
	  }
	});

</script>
