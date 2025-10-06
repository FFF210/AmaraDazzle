package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ExchangeOrderList {
	private Long ordersId; // 주문 ID
	private String orderCode; // 주문 코드
	private Long memberId; // 회원 ID
	private String memberName; // 회원 이름
	private String productName; // 대표 상품명
	private String productNames; // 전체 상품 목록
	private BigDecimal total; // 총 금액
	private String orderStatus; // 교환 상태
	private String returnTrackingNo; // 회수 운송장번호
	private String shippingTrackingNo; // 교환 발송 운송장번호
	private Timestamp updatedAt; // 수정일

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

	public String getShippingTrackingNo() {
		return shippingTrackingNo;
	}

	public void setShippingTrackingNo(String shippingTrackingNo) {
		this.shippingTrackingNo = shippingTrackingNo;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

}
