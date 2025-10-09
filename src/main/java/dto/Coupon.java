package dto;

import java.sql.Timestamp;

public class Coupon {
    private Long couponId;          // 쿠폰 ID (PK, AUTO_INCREMENT)
    private String cname;           // 쿠폰명
    private Timestamp startDate;    // 유효기간 시작일자
    private Timestamp endDate;      // 유효기간 종료일자
    private Integer amount;         // 할인액
    private Long pCode;             // 피부 고민/피부타입/퍼스널컬러 (FK → code_detail.code_detail_id)
    private Long categoryId;             // 카테고리 (FK → category.category_id)
    private String amountCondition; // 조건 (금액)
    private String reason;          // 지급 사유
    private String provision;       // 지급 대상 유형 (모든회원, VIP, GOLD, SILVER, 일반, 개별지급)
    private String writerType;      // 쿠폰 발행자 타입 (ADMIN, BRAND_ADMIN)
    private Long writerId;          // 쿠폰 발행자 ID (FK → brand.brand_id / admin_info.admin_info_id)
    private Timestamp createdAt;    // 발행일자
    private String pch_noRestr; // 사용조건 제한없음
    private Long memberId; 	// 개별지급시 회원ID
    
    //조인용 컬럼 
    private String fullCategoryPath; //category 풀표기용
    private String codeName; //code_detail.name 
    private String WriterName; //admin_info.aname or brand.brand_name
    private String mName; //회원명
    private String mEmail; //회원아이디
    
    public Coupon() {}
	public Coupon(String cname, Timestamp startDate, Timestamp endDate, Integer amount,
			Long categoryId, String amountCondition, String reason, String provision, String writerType,
			Long writerId, String pch_noRestr) {
		super();
		this.cname = cname;
		this.startDate = startDate;
		this.endDate = endDate;
		this.amount = amount;
		this.categoryId = categoryId;
		this.amountCondition = amountCondition;
		this.reason = reason;
		this.provision = provision;
		this.writerType = writerType;
		this.writerId = writerId;
		this.pch_noRestr = pch_noRestr;
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
	public Long getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
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
	public String getFullCategoryPath() {
		return fullCategoryPath;
	}
	public void setFullCategoryPath(String fullCategoryPath) {
		this.fullCategoryPath = fullCategoryPath;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getWriterName() {
		return WriterName;
	}
	public void setWriterName(String writerName) {
		WriterName = writerName;
	}
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String getmEmail() {
		return mEmail;
	}
	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}
	@Override
	public String toString() {
		return "Coupon [couponId=" + couponId + ", cname=" + cname + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", amount=" + amount + ", pCode=" + pCode + ", categoryId=" + categoryId + ", amountCondition="
				+ amountCondition + ", reason=" + reason + ", provision=" + provision + ", writerType=" + writerType
				+ ", writerId=" + writerId + ", createdAt=" + createdAt + ", pch_noRestr=" + pch_noRestr + ", memberId="
				+ memberId + ", fullCategoryPath=" + fullCategoryPath + ", codeName="
				+ codeName + ", WriterName=" + WriterName + ", mName=" + mName + ", mEmail=" + mEmail + "]";
	}


	


	
}
