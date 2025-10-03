package dto.consumer;

import java.sql.Timestamp;

public class CouponList {
	private Long couponId; // 쿠폰 ID
	private String cname; // 쿠폰명
	private Timestamp startDate; // 유효기간 시작일자
	private Timestamp endDate; // 유효기간 종료일자
	private int amount; // 할인액
	private int amountCondition; // 조건 (금액)
	private String reason; // 지급 사유
	private String provision; // 지급 대상 유형
	private String couponLimit; // 발급 제한 수량
	private String writerType; // 쿠폰 발행자 타입
	private Long writerId; // 발행자 ID
	private Timestamp createdAt; // 발행일자

	// 브랜드 정보 (BRAND_ADMIN 발행 시)
	private String brandName; // 브랜드명
	private Long logoFileId; // 브랜드 로고 이미지 ID

	private String categoryName; // 쿠폰 적용 카테고리명 (없으면 null)
	private Integer downloaded; // 쿠폰 다운 여부 (1: 이미 다운, 0: 미다운)

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

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getAmountCondition() {
		return amountCondition;
	}

	public void setAmountCondition(int amountCondition) {
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

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public Long getLogoFileId() {
		return logoFileId;
	}

	public void setLogoFileId(Long logoFileId) {
		this.logoFileId = logoFileId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public Integer getDownloaded() {
		return downloaded;
	}

	public void setDownloaded(Integer downloaded) {
		this.downloaded = downloaded;
	}

}
