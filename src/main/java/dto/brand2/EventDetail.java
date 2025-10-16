package dto.brand2;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import dto.Coupon;

public class EventDetail {
	/* ======= 신청하기, 상세보기버튼 조회 결과 전용 DTO ======= */

	private Long brandId;
	
	// event
	private Long eventId;
	private String eventType;
	private String eventName;
	private String status;
	private Timestamp startDate;
	private Timestamp endDate;
	private Long thumbnailFileId; // 배너 이미지 파일 ID (FK → upload_file.upload_file_id)
	private Long detailFileId; // 상세페이지 이미지 파일 ID (FK → upload_file.upload_file_id)
	private String content; // 내용
	private Long writer; // 작성자 (FK → admin_info.admin_info_id)
	private Integer exposeYn; // 노출 여부 (DEFAULT 0)
	private Timestamp createdAt; // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)
	private Timestamp updatedAt; // 수정 시각

	private Long category1Id;
	private String largeCategoryName;
	private Long category2Id;
	private String middleCategoryName;
	private Long category3Id;
	private String smallCategoryName;

	// event_application
	private String eventApplicationId;
	private String managerName;
	private String managerTel;
	private String note;
	private String applyDate;

	// coupon
	// coupon 리스트
	private List<Coupon> coupons;

	private String couponId;
	private String cname;
	private Timestamp couponStartDate;
	private Timestamp couponEndDate;
	private int amount;
	private String amountCondition;

	// ===== 상품 (DISCOUNT용) =====
	private String productIds; // 여러 개 상품 ID (콤마구분 or 배열 처리용)
	private List<Long> productIdList; // 다중 상품 ID를 List로 변환해서 담을 수 있음

	private String discountType; // RATE / AMOUNT
	private BigDecimal discountValue; // 할인 값 (null 가능)
	
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

	public Long getThumbnailFileId() {
		return thumbnailFileId;
	}

	public void setThumbnailFileId(Long thumbnailFileId) {
		this.thumbnailFileId = thumbnailFileId;
	}

	public Long getDetailFileId() {
		return detailFileId;
	}

	public void setDetailFileId(Long detailFileId) {
		this.detailFileId = detailFileId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getWriter() {
		return writer;
	}

	public void setWriter(Long writer) {
		this.writer = writer;
	}

	public Integer getExposeYn() {
		return exposeYn;
	}

	public void setExposeYn(Integer exposeYn) {
		this.exposeYn = exposeYn;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Long getCategory1Id() {
		return category1Id;
	}

	public void setCategory1Id(Long category1Id) {
		this.category1Id = category1Id;
	}

	public String getLargeCategoryName() {
		return largeCategoryName;
	}

	public void setLargeCategoryName(String largeCategoryName) {
		this.largeCategoryName = largeCategoryName;
	}

	public Long getCategory2Id() {
		return category2Id;
	}

	public void setCategory2Id(Long category2Id) {
		this.category2Id = category2Id;
	}

	public String getMiddleCategoryName() {
		return middleCategoryName;
	}

	public void setMiddleCategoryName(String middleCategoryName) {
		this.middleCategoryName = middleCategoryName;
	}

	public Long getCategory3Id() {
		return category3Id;
	}

	public void setCategory3Id(Long category3Id) {
		this.category3Id = category3Id;
	}

	public String getSmallCategoryName() {
		return smallCategoryName;
	}

	public void setSmallCategoryName(String smallCategoryName) {
		this.smallCategoryName = smallCategoryName;
	}

	public String getEventApplicationId() {
		return eventApplicationId;
	}

	public void setEventApplicationId(String eventApplicationId) {
		this.eventApplicationId = eventApplicationId;
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

	public String getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	public List<Coupon> getCoupons() {
		return coupons;
	}

	public void setCoupons(List<Coupon> coupons) {
		this.coupons = coupons;
	}

	public String getCouponId() {
		return couponId;
	}

	public void setCouponId(String couponId) {
		this.couponId = couponId;
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

	public List<Long> getProductIdList() {
		return productIdList;
	}

	public void setProductIdList(List<Long> productIdList) {
		this.productIdList = productIdList;
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

	@Override
	public String toString() {
		return "EventDetail [brandId=" + brandId + ", eventId=" + eventId + ", eventType=" + eventType + ", eventName="
				+ eventName + ", status=" + status + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", thumbnailFileId=" + thumbnailFileId + ", detailFileId=" + detailFileId + ", content=" + content
				+ ", writer=" + writer + ", exposeYn=" + exposeYn + ", createdAt=" + createdAt + ", updatedAt="
				+ updatedAt + ", category1Id=" + category1Id + ", largeCategoryName=" + largeCategoryName
				+ ", category2Id=" + category2Id + ", middleCategoryName=" + middleCategoryName + ", category3Id="
				+ category3Id + ", smallCategoryName=" + smallCategoryName + ", eventApplicationId="
				+ eventApplicationId + ", managerName=" + managerName + ", managerTel=" + managerTel + ", note=" + note
				+ ", applyDate=" + applyDate + ", coupons=" + coupons + ", couponId=" + couponId + ", cname=" + cname
				+ ", couponStartDate=" + couponStartDate + ", couponEndDate=" + couponEndDate + ", amount=" + amount
				+ ", amountCondition=" + amountCondition + ", productIds=" + productIds + ", productIdList="
				+ productIdList + ", discountType=" + discountType + ", discountValue=" + discountValue + "]";
	}

	
}