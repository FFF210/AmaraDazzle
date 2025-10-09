package dto.brand;

import java.math.BigDecimal;

public class OrdersItemDetail {
	private Long orderItemId; // 주문 상품 ID (PK)
	private Long productId; // 상품 ID (FK → product.product_id)
	private Long optionId; // 옵션 ID (FK → product_option.product_option_id)
	private Long returnId; // 반품 ID
	private Long exchangeId; // 교환 ID
	private Integer quantity; // 주문 수량
	private BigDecimal total; // 주문 상품 총 금액 (할인 포함, order_item.total)
	private String itemStatus; // 주문 상품 상태
	private String productName; // 상품명
	private String optionName; // 옵션명 (없을 경우 null)

	public Long getReturnId() {
		return returnId;
	}

	public void setReturnId(Long returnId) {
		this.returnId = returnId;
	}

	public Long getExchangeId() {
		return exchangeId;
	}

	public void setExchangeId(Long exchangeId) {
		this.exchangeId = exchangeId;
	}

	public Long getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(Long orderItemId) {
		this.orderItemId = orderItemId;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Long getOptionId() {
		return optionId;
	}

	public void setOptionId(Long optionId) {
		this.optionId = optionId;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public String getItemStatus() {
		return itemStatus;
	}

	public void setItemStatus(String itemStatus) {
		this.itemStatus = itemStatus;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}

}
