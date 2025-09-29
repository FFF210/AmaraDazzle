package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrdersSummary {
	private Long ordersId; // 주문 ID (PK → orders.orders_id)
	private Timestamp createdAt; // 주문 생성일자
	private String orderStatus; // 주문 상태 (우선순위 적용)

	private String trackingNo; // 운송장 번호
	private String carrierName; // 택배사 이름

	private BigDecimal subtotalAmount; // 상품금액 합계(할인 전)
	private BigDecimal discountAmount; // 할인 금액
	private BigDecimal shippingAmount; // 배송비
	private int usingPoint;
	private BigDecimal totalAmount; // 최종 결제 금액

	private String shipRecipient; // 받는 분
	private String shipPhone; // 배송 연락처
	private String shipPostcode; // 우편번호
	private String shipLine1; // 주소
	private String shipLine2; // 상세주소
	private String note; // 배송 요청사항

	private String memberEmail; // 회원 이메일
	private String memberName; // 회원 이름
	private String memberPhone; // 회원 연락처

	public Long getOrdersId() {
		return ordersId;
	}

	public void setOrdersId(Long ordersId) {
		this.ordersId = ordersId;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getTrackingNo() {
		return trackingNo;
	}

	public void setTrackingNo(String trackingNo) {
		this.trackingNo = trackingNo;
	}

	public String getCarrierName() {
		return carrierName;
	}

	public int getUsingPoint() {
		return usingPoint;
	}

	public void setUsingPoint(int usingPoint) {
		this.usingPoint = usingPoint;
	}

	public void setCarrierName(String carrierName) {
		this.carrierName = carrierName;
	}

	public BigDecimal getSubtotalAmount() {
		return subtotalAmount;
	}

	public void setSubtotalAmount(BigDecimal subtotalAmount) {
		this.subtotalAmount = subtotalAmount;
	}

	public BigDecimal getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(BigDecimal discountAmount) {
		this.discountAmount = discountAmount;
	}

	public BigDecimal getShippingAmount() {
		return shippingAmount;
	}

	public void setShippingAmount(BigDecimal shippingAmount) {
		this.shippingAmount = shippingAmount;
	}

	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getShipRecipient() {
		return shipRecipient;
	}

	public void setShipRecipient(String shipRecipient) {
		this.shipRecipient = shipRecipient;
	}

	public String getShipPhone() {
		return shipPhone;
	}

	public void setShipPhone(String shipPhone) {
		this.shipPhone = shipPhone;
	}

	public String getShipPostcode() {
		return shipPostcode;
	}

	public void setShipPostcode(String shipPostcode) {
		this.shipPostcode = shipPostcode;
	}

	public String getShipLine1() {
		return shipLine1;
	}

	public void setShipLine1(String shipLine1) {
		this.shipLine1 = shipLine1;
	}

	public String getShipLine2() {
		return shipLine2;
	}

	public void setShipLine2(String shipLine2) {
		this.shipLine2 = shipLine2;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberPhone() {
		return memberPhone;
	}

	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}

}
