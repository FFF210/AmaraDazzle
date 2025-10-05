package dto;

import java.sql.Timestamp;

public class Coupon {
    private Long couponId;          // 쿠폰 ID (PK, AUTO_INCREMENT)
    private String cname;           // 쿠폰명
    private Timestamp startDate;    // 유효기간 시작일자
    private Timestamp endDate;      // 유효기간 종료일자
    private Integer amount;         // 할인액
    private Long pCode;             // 피부 고민/피부타입/퍼스널컬러 (FK → code_detail.code_detail_id)
    private Long cCode;             // 카테고리 (FK → category.category_id)
    private String amountCondition; // 조건 (금액)
    private String reason;          // 지급 사유
    private String provision;       // 지급 대상 유형 (모든회원, VIP, GOLD, SILVER, 일반, 개별지급)
    private String couponLimit;           // 발급 제한 수량
    private String writerType;      // 쿠폰 발행자 타입 (ADMIN, BRAND_ADMIN)
    private Long writerId;          // 쿠폰 발행자 ID (FK → brand.brand_id / admin_info.admin_info_id)
    private Timestamp createdAt;    // 발행일자
    private String pch_noRestr; // 사용조건 제한없음
    private String qnt_noRestr;  // 발급수량 제한없음 
    private String no_dupl; // 중복발급여부 (on:중복발급 불가)
    
    public Coupon() {}
	public Coupon(String cname, Timestamp startDate, Timestamp endDate, Integer amount,
			Long cCode, String amountCondition, String reason, String provision, String couponLimit, String writerType,
			Long writerId, String pch_noRestr, String qnt_noRestr) {
		super();
		this.cname = cname;
		this.startDate = startDate;
		this.endDate = endDate;
		this.amount = amount;
		this.cCode = cCode;
		this.amountCondition = amountCondition;
		this.reason = reason;
		this.provision = provision;
		this.couponLimit = couponLimit;
		this.writerType = writerType;
		this.writerId = writerId;
		this.pch_noRestr = pch_noRestr;
		this.qnt_noRestr = qnt_noRestr;
	}

	public Long getCouponId() {
		return couponId;
	}
	public void setCouponId(Long couponId) {
		this.couponId = couponId;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
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
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public Long getpCode() {
		return pCode;
	}
	public void setpCode(Long pCode) {
		this.pCode = pCode;
	}
	public Long getcCode() {
		return cCode;
	}
	public void setcCode(Long cCode) {
		this.cCode = cCode;
	}
	public String getAmountCondition() {
		return amountCondition;
	}
	public void setAmountCondition(String amountCondition) {
		this.amountCondition = amountCondition;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getProvision() {
		return provision;
	}
	public void setProvision(String provision) {
		this.provision = provision;
	}
	public String getCouponLimit() {
		return couponLimit;
	}
	public void setCouponLimit(String couponLimit) {
		this.couponLimit = couponLimit;
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
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public String getPch_noRestr() {
		return pch_noRestr;
	}
	public void setPch_noRestr(String pch_noRestr) {
		this.pch_noRestr = pch_noRestr;
	}
	public String getQnt_noRestr() {
		return qnt_noRestr;
	}
	public void setQnt_noRestr(String qnt_noRestr) {
		this.qnt_noRestr = qnt_noRestr;
	}
	public String getNo_dupl() {
		return no_dupl;
	}
	public void setNo_dupl(String no_dupl) {
		this.no_dupl = no_dupl;
	}
	
	@Override
    public String toString() {
        return "Coupon [couponId=" + couponId + ", cname=" + cname +
                ", startDate=" + startDate + ", endDate=" + endDate +
                ", amount=" + amount + ", pCode=" + pCode + ", cCode=" + cCode +
                ", amountCondition=" + amountCondition + ", reason=" + reason +
                ", provision=" + provision + ", couponLimit=" + couponLimit +
                ", writerType=" + writerType + ", writerId=" + writerId +
                ", createdAt=" + createdAt + "]";
    }
}
