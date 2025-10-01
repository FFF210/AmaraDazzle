package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrdersList {
	private Long ordersId; // 주문 ID (PK, orders.orders_id)
	private String orderCode; // 주문번호 (order_code)
	private Long memberId; // 주문 회원 ID (FK → member.member_id)
	private String memberName; // 주문자 이름 (member.name)
	private BigDecimal totalAmount; // 최종 결제 금액 (orders.total_amount)
	private Timestamp createdAt; // 주문 생성 시각 (orders.created_at)

	private String productName; // 대표 상품명 (첫 번째 상품명)
	private String productNames; // 주문에 포함된 모든 상품명 (검색용)

	private String orderStatus; // 주문 대표 상태 (우선순위 적용)
	private boolean hasCancelledItem; // 취소 상품 존재 여부 (0/1 → false/true)
	private boolean hasReturnItem; // 반품 상품 존재 여부 (0/1 → false/true)
	private boolean hasExchangeItem; // 교환 상품 존재 여부 (0/1 → false/true)

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

	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
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

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public boolean isHasCancelledItem() {
		return hasCancelledItem;
	}

	public void setHasCancelledItem(boolean hasCancelledItem) {
		this.hasCancelledItem = hasCancelledItem;
	}

	public boolean isHasReturnItem() {
		return hasReturnItem;
	}

	public void setHasReturnItem(boolean hasReturnItem) {
		this.hasReturnItem = hasReturnItem;
	}

	public boolean isHasExchangeItem() {
		return hasExchangeItem;
	}

	public void setHasExchangeItem(boolean hasExchangeItem) {
		this.hasExchangeItem = hasExchangeItem;
	}

}
