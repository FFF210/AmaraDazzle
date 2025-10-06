package dto.brand;

import java.math.BigDecimal;

public class CancelOrderSummary {
	private String orderCode; // 주문 코드 (orders.order_code)
	private Long orderId;
	private BigDecimal totalAmount; // 총 결제 금액 (orders.total_amount)
	private Integer usingPoint; // 사용 포인트 (orders.using_point)
	private BigDecimal couponAmount; // 쿠폰 할인액 (coupon.amount)
	private String couponName; // 쿠폰 이름 ("조건 + 할인액" 형태)
	private BigDecimal cancelledTotal; // 취소 상품 총합 (SUM(order_item.total))
	private BigDecimal actualCancelAmount; // 실제 취소 금액 (쿠폰 조건 고려한 금액)

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Integer getUsingPoint() {
		return usingPoint;
	}

	public void setUsingPoint(Integer usingPoint) {
		this.usingPoint = usingPoint;
	}

	public BigDecimal getCouponAmount() {
		return couponAmount;
	}

	public void setCouponAmount(BigDecimal couponAmount) {
		this.couponAmount = couponAmount;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public BigDecimal getCancelledTotal() {
		return cancelledTotal;
	}

	public void setCancelledTotal(BigDecimal cancelledTotal) {
		this.cancelledTotal = cancelledTotal;
	}

	public BigDecimal getActualCancelAmount() {
		return actualCancelAmount;
	}

	public void setActualCancelAmount(BigDecimal actualCancelAmount) {
		this.actualCancelAmount = actualCancelAmount;
	}

}
