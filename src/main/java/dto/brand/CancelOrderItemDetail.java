package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class CancelOrderItemDetail {
	private String orderCode; // 주문 코드 (orders.order_code)
	private Timestamp cancelledDate; // 취소 요청일 (order_item.updated_at)
	private String status; // 상태 (항상 'CANCELLED')
	private String productName; // 상품명 (product.name)
	private String optionName; // 옵션명 (product_option.option_value)
	private int quantity; // 수량 (order_item.quantity)
	private BigDecimal cancelledAmount; // 취소 금액 (order_item.total)

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public Timestamp getCancelledDate() {
		return cancelledDate;
	}

	public void setCancelledDate(Timestamp cancelledDate) {
		this.cancelledDate = cancelledDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getCancelledAmount() {
		return cancelledAmount;
	}

	public void setCancelledAmount(BigDecimal cancelledAmount) {
		this.cancelledAmount = cancelledAmount;
	}

}
