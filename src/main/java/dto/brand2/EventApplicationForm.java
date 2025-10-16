package dto.brand2;

import java.math.BigDecimal;
import java.util.List;

public class EventApplicationForm {	
/* ======= 사용하지 않는 dto ======= */
	
    // event_application
	private Long eventApplicationId;  // 신청 PK (insert 후 세팅)
    private Long brandId;
    private Long eventId;
    private String managerName;
    private String managerTel;
    private String note;

    // event
    private String eventType;
    
    // event_product (여러개)
    private List<Long> productIds;
    
    // DISCOUNT 이벤트 전용
    // 또는 할인 이벤트 지원 시
    private String discountType; // RATE/AMOUNT
    private BigDecimal discountValue; // 할인 값

    // coupon
    private Long couponId; // 이미 발급된 쿠폰을 선택하는 경우 (nullable)
    
    // 쿠폰 다중 선택용
    private List<Long> couponIds;  // 신청 시 선택한 쿠폰들

    /*
    private String cname;
    private Timestamp couponStartDate;
    private Timestamp couponEndDate;
    private int amount;
    private String amountCondition;
    private String provision;
    private String writerType;
    private Long writerId;
    */
    
	public Long getEventApplicationId() {
		return eventApplicationId;
	}
	public void setEventApplicationId(Long eventApplicationId) {
		this.eventApplicationId = eventApplicationId;
	}
	public Long getBrandId() {
		return brandId;
	}
	public void setBrandId(Long brandId) {
		this.brandId = brandId;
	}
	public Long getEventId() {
		return eventId;
	}
	public void setEventId(Long eventId) {
		this.eventId = eventId;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public String getManagerTel() {
		return managerTel;
	}
	public void setManagerTel(String managerTel) {
		this.managerTel = managerTel;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	public List<Long> getProductIds() {
		return productIds;
	}
	public void setProductIds(List<Long> productIds) {
		this.productIds = productIds;
	}

	public String getDiscountType() {
		return discountType;
	}
	public void setDiscountType(String discountType) {
		this.discountType = discountType;
	}
	public BigDecimal getDiscountValue() {
		return discountValue;
	}
	public void setDiscountValue(BigDecimal discountValue) {
		this.discountValue = discountValue;
	}
	public List<Long> getCouponIds() {
		return couponIds;
	}
	public void setCouponIds(List<Long> couponIds) {
		this.couponIds = couponIds;
	}
	public Long getCouponId() {
		return couponId;
	}
	public void setCouponId(Long couponId) {
		this.couponId = couponId;
	}
	@Override
	public String toString() {
		return "EventApplicationForm [eventApplicationId=" + eventApplicationId + ", brandId=" + brandId + ", eventId="
				+ eventId + ", managerName=" + managerName + ", managerTel=" + managerTel + ", note=" + note
				+ ", eventType=" + eventType + ", productIds=" + productIds + ", discountType=" + discountType
				+ ", discountValue=" + discountValue + ", couponId=" + couponId + ", couponIds=" + couponIds + "]";
	}
	
	
	/*
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public Timestamp getCouponStartDate() {
		return couponStartDate;
	}
	public void setCouponStartDate(Timestamp couponStartDate) {
		this.couponStartDate = couponStartDate;
	}
	public Timestamp getCouponEndDate() {
		return couponEndDate;
	}
	public void setCouponEndDate(Timestamp couponEndDate) {
		this.couponEndDate = couponEndDate;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getAmountCondition() {
		return amountCondition;
	}
	public void setAmountCondition(String amountCondition) {
		this.amountCondition = amountCondition;
	}
	public String getProvision() {
		return provision;
	}
	public void setProvision(String provision) {
		this.provision = provision;
	}
	public String getWriterType() {
		return writerType;
	}
	public void setWriterType(String writerType) {
		this.writerType = writerType;
	}
	public Long getWriterId() {
		return writerId;
	}
	public void setWriterId(Long writerId) {
		this.writerId = writerId;
	}
	*/
    
}
