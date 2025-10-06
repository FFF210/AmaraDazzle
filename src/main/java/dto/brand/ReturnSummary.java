package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ReturnSummary {
	private Long returnId; // 반품 고유 ID
	private Long memberId; // 회원 ID
	private Long orderId; // 회원 ID
	private String orderCode; // 주문 코드

	private String memberName; // 회원 이름

	private Timestamp returnRequestDate; // 반품 요청일
	private String returnStatus; // 반품 상태 (예: RETURN_REQUESTED, RETURN_APPROVED 등)

	private String reason; // 반품 사유
	private String rejectionReason; // 반품 거절 사유
	private Double shippingCost; // 배송비
	private String shippingCostPayer; // 배송비 부담 주체 (member, brand)
	private String returnInvoice; // 회수 송장번호

	private Long image1FileId; // 반품 이미지1
	private Long image2FileId; // 반품 이미지2
	private Long image3FileId; // 반품 이미지3

	private BigDecimal totalAmount; // 총 결제 금액 (orders.total_amount)
	private Integer usingPoint; // 사용 포인트 (orders.using_point)
	private BigDecimal couponAmount; // 쿠폰 할인액 (coupon.amount)
	private String couponName; // 쿠폰 이름 ("조건 + 할인액" 형태)
	private BigDecimal cancelledTotal; // 반품 상품 총합 (SUM(order_item.total))
	private BigDecimal actualCancelAmount; // 실제 반품 금액 (쿠폰 조건 고려한 금액)

	private Timestamp updatedAt; // 상태 변경일

	public String getRejectionReason() {
		return rejectionReason;
	}

	public void setRejectionReason(String rejectionReason) {
		this.rejectionReason = rejectionReason;
	}

	public Long getReturnId() {
		return returnId;
	}

	public void setReturnId(Long returnId) {
		this.returnId = returnId;
	}

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

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

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public Timestamp getReturnRequestDate() {
		return returnRequestDate;
	}

	public void setReturnRequestDate(Timestamp returnRequestDate) {
		this.returnRequestDate = returnRequestDate;
	}

	public String getReturnStatus() {
		return returnStatus;
	}

	public void setReturnStatus(String returnStatus) {
		this.returnStatus = returnStatus;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Double getShippingCost() {
		return shippingCost;
	}

	public void setShippingCost(Double shippingCost) {
		this.shippingCost = shippingCost;
	}

	public String getShippingCostPayer() {
		return shippingCostPayer;
	}

	public void setShippingCostPayer(String shippingCostPayer) {
		this.shippingCostPayer = shippingCostPayer;
	}

	public String getReturnInvoice() {
		return returnInvoice;
	}

	public void setReturnInvoice(String returnInvoice) {
		this.returnInvoice = returnInvoice;
	}

	public Long getImage1FileId() {
		return image1FileId;
	}

	public void setImage1FileId(Long image1FileId) {
		this.image1FileId = image1FileId;
	}

	public Long getImage2FileId() {
		return image2FileId;
	}

	public void setImage2FileId(Long image2FileId) {
		this.image2FileId = image2FileId;
	}

	public Long getImage3FileId() {
		return image3FileId;
	}

	public void setImage3FileId(Long image3FileId) {
		this.image3FileId = image3FileId;
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

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
}
