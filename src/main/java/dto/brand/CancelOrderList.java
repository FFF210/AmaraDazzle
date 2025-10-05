package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class CancelOrderList {
	private Long ordersId; // << 주문 ID (orders.orders_id)
	private String orderCode; // << 주문 코드 (예: 20250915-001478)
	private Long memberId; // << 주문자 회원 ID (member.member_id)
	private String memberName; // << 주문자 이름
	private String status; // << 주문 상태 (항상 'CANCELLED')

	private String productName; // << 대표 상품명 (취소 상품 중 첫 번째 상품)
	private String productNames; // << 주문에 포함된 취소 상품명 전체 (콤마 구분)

	private BigDecimal total; // << 총 주문 취소 금액 (SUM(oi.total))
	private Timestamp updatedAt; // << 취소 처리 시각 (MAX(oi.updated_at))

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

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

}
