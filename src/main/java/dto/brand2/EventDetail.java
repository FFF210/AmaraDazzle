package dto.brand2;

import java.sql.Timestamp;
import java.util.List;

public class EventDetail {
	/* ======= 상세보기버튼 조회 결과 전용 DTO ======= */
	
	// event
    private Long eventId;
    private String eventType;
    private String eventName;
    private String status;
    private Timestamp startDate;
    private Timestamp endDate;

    // event_application
    private String managerName;
    private String managerTel;
    private String note;

    // coupon
    private String cname;
    private Timestamp couponStartDate;
    private Timestamp couponEndDate;
    private int amount;
    private String amountCondition;
    
    // 상품코드
    private String productIds;

	public Long getEventId() {
		return eventId;
	}

	public void setEventId(Long eventId) {
		this.eventId = eventId;
	}

	public String getEventType() {
		return eventType;
	}

	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getStartDate() {
		return startDate;
	}

	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}

	public Timestamp getEndDate() {
		return endDate;
	}

	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
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

	public String getProductIds() {
		return productIds;
	}

	public void setProductIds(String productIds) {
		this.productIds = productIds;
	}

	@Override
	public String toString() {
		return "EventDetail [eventId=" + eventId + ", eventType=" + eventType + ", eventName=" + eventName + ", status="
				+ status + ", startDate=" + startDate + ", endDate=" + endDate + ", managerName=" + managerName
				+ ", managerTel=" + managerTel + ", note=" + note + ", cname=" + cname + ", couponStartDate="
				+ couponStartDate + ", couponEndDate=" + couponEndDate + ", amount=" + amount + ", amountCondition="
				+ amountCondition + ", productIds=" + productIds + "]";
	}
    
    
}