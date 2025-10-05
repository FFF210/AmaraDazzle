package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ReturnOrderList {
	private Timestamp updatedAt; // << 반품 처리 시각 (order_item.updated_at)
	private Long ordersId; // << 주문 ID (orders.orders_id)
	private String orderCode; // << 주문 코드 (예: 20250915-001478)
	private Long memberId; // << 회원 ID
	private String memberName; // << 회원 이름 (member.name)
	private String productName; // << 대표 상품명 (첫 번째 상품)
	private String productNames; // << 모든 상품명 (콤마 구분)
	private BigDecimal total; // << 반품 총 금액 (SUM(order_item.total))
	private String orderStatus; // << 반품 상태 (RETURN 등)
	private String returnTrackingNo; // << 회송 운송장 번호 (returns.return_tracking_no)

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Long getOrdersId() {
		return ordersId;
	}

	public void setOrdersId(Long ordersId) {
		this.ordersId = ordersId;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductNames() {
		return productNames;
	}

	public void setProductNames(String productNames) {
		this.productNames = productNames;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getReturnTrackingNo() {
		return returnTrackingNo;
	}

	public void setReturnTrackingNo(String returnTrackingNo) {
		this.returnTrackingNo = returnTrackingNo;
	}

}
