package dto.brand2;

import java.sql.Timestamp;
import java.util.List;

public class EventApplicationForm {	
/* ======= insert/update 용 ======= */
	
    // event_application
    private Long brandId;
    private Long eventId;
    private String managerName;
    private String managerTel;
    private String note;

    // event_product (여러개)
    private List<Long> productIds;

    // coupon
    private String cname;
    private Timestamp startDateCoupon;
    private Timestamp endDateCoupon;
    private int amount;
    private String amountCondition;
    private String provision;
    private String writerType;
    private Long writerId;
    
    
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
	public List<Long> getProductIds() {
		return productIds;
	}
	public void setProductIds(List<Long> productIds) {
		this.productIds = productIds;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public Timestamp getStartDateCoupon() {
		return startDateCoupon;
	}
	public void setStartDateCoupon(Timestamp startDateCoupon) {
		this.startDateCoupon = startDateCoupon;
	}
	public Timestamp getEndDateCoupon() {
		return endDateCoupon;
	}
	public void setEndDateCoupon(Timestamp endDateCoupon) {
		this.endDateCoupon = endDateCoupon;
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
	@Override
	public String toString() {
		return "EventApplicationForm [brandId=" + brandId + ", eventId=" + eventId + ", managerName=" + managerName
				+ ", managerTel=" + managerTel + ", note=" + note + ", productIds=" + productIds + ", cname=" + cname
				+ ", startDateCoupon=" + startDateCoupon + ", endDateCoupon=" + endDateCoupon + ", amount=" + amount
				+ ", amountCondition=" + amountCondition + ", provision=" + provision + ", writerType=" + writerType
				+ ", writerId=" + writerId + "]";
	}
	
    
}
