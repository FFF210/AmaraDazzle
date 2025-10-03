package dto;

import java.sql.Timestamp;

public class AdminPayment {
	private Long paymentId; // 결제 내역 고유 ID (PK, AUTO_INCREMENT)
	private String paymentType; // 결제 유형 (MEMBERSHIP / BANNER_AD)
	private String paymentKey; // PG사 결제 고유키 (UNIQUE)
	private Long brandId; // 결제한 브랜드 ID (FK → brand.brand_id)
	private Integer amount; // 결제 금액 (원, CHECK >= 0, DEFAULT 0)
	private Long planId; // 멤버십 요금제 ID (FK → membership_plan.membership_plan_id)
	private Long bannerId; // 배너 광고 ID (FK → banner.banner_id)
	private Timestamp payDate; // 결제일 (DEFAULT CURRENT_TIMESTAMP)
	private String orderId; // 토스페이먼츠용
	private String method; // 토스페이먼츠 지불 방식
	private String orderName; // 토스페이먼츠 구매상품 (생수 외 1건) 같은 형식
	private String receiptUrl; // 토스페이먼츠 영수증 URL
	
	public AdminPayment() {
	}

	public Long getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(Long paymentId) {
		this.paymentId = paymentId;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getPaymentKey() {
		return paymentKey;
	}

	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
	}

	public Long getBrandId() {
		return brandId;
	}

	public void setBrandId(Long brandId) {
		this.brandId = brandId;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Long getPlanId() {
		return planId;
	}

	public void setPlanId(Long planId) {
		this.planId = planId;
	}

	public Long getBannerId() {
		return bannerId;
	}

	public void setBannerId(Long bannerId) {
		this.bannerId = bannerId;
	}

	public Timestamp getPayDate() {
		return payDate;
	}

	public void setPayDate(Timestamp payDate) {
		this.payDate = payDate;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getOrderName() {
		return orderName;
	}

	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}

	public String getReceiptUrl() {
		return receiptUrl;
	}

	public void setReceiptUrl(String receiptUrl) {
		this.receiptUrl = receiptUrl;
	}

	@Override
	public String toString() {
		return "AdminPayment [paymentId=" + paymentId + ", paymentType=" + paymentType + ", paymentKey=" + paymentKey
				+ ", brandId=" + brandId + ", amount=" + amount + ", planId=" + planId + ", bannerId=" + bannerId
				+ ", payDate=" + payDate + ", orderId=" + orderId + ", method=" + method + ", orderName=" + orderName
				+ ", receiptUrl=" + receiptUrl + "]";
	}
	
	
}