package dto.consumer;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

//[소비자] 상품 랭킹 목록 조회
public class ProductRank {
	private Long productId; // 고유 식별자 (PK, AUTO_INCREMENT)
	private Long brandId; // 등록 브랜드 관리자 ID (FK → brand.brand_id)
	private String name; // 상품명
	private String brandName; // 브랜드명
	private Integer isExclusive; // 단독 판매 여부 (tinyint, DEFAULT 0)
	private Integer isVisible; // 상품 공개 여부 (tinyint, DEFAULT 1)

	private Integer isPlanned; // 기획 상품 여부 (tinyint, DEFAULT 0)
	private Integer hasOption; // 옵션 존재 여부
	private Integer isWished; // 1: 찜했음, 0: 안함

	private Long category1Id; // 대분류 카테고리 ID (FK → category.category_id)
	private Long category2Id; // 중분류 카테고리 ID (FK → category.category_id)
	private Long category3Id; // 소분류 카테고리 ID (FK → category.category_id)
	private Long thumbnailFileId; // 썸네일 파일 ID (FK → upload_file.upload_file_id)

	private BigDecimal price; // 판매가 (기본가)
	private BigDecimal finalPrice; // 최종 판매가 (세일 적용가)
	private String discountType; // 할인 방식 (RATE, AMOUNT)
	private BigDecimal discountValue; // 할인 값(퍼센트 또는 금액)

	private Date startDate; // 세일 시작 시각
	private Date endDate; // 세일 종료 시각
	private Timestamp createdAt; // 생성 시각
	private Timestamp updatedAt; // 수정 시각

	// ====== 계산된 필드 (랭킹 점수 관련) ======
	private Integer totalSold; // 최근 30일 판매량
	private Integer reviewCount; // 최근 30일 리뷰 개수
	private Double avgRating; // 최근 30일 평균 평점
	private Integer wishCount; // 최근 30일 위시리스트 수
	private Double popularityScore; // 랭킹 점수 (가중치 기반)

	public Integer getIsPlanned() {
		return isPlanned;
	}

	public void setIsPlanned(Integer isPlanned) {
		this.isPlanned = isPlanned;
	}

	public Integer getHasOption() {
		return hasOption;
	}

	public void setHasOption(Integer hasOption) {
		this.hasOption = hasOption;
	}

	public Integer getIsWished() {
		return isWished;
	}

	public void setIsWished(Integer isWished) {
		this.isWished = isWished;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Long getBrandId() {
		return brandId;
	}

	public void setBrandId(Long brandId) {
		this.brandId = brandId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public Integer getIsExclusive() {
		return isExclusive;
	}

	public void setIsExclusive(Integer isExclusive) {
		this.isExclusive = isExclusive;
	}

	public Integer getIsVisible() {
		return isVisible;
	}

	public void setIsVisible(Integer isVisible) {
		this.isVisible = isVisible;
	}

	public Long getCategory1Id() {
		return category1Id;
	}

	public void setCategory1Id(Long category1Id) {
		this.category1Id = category1Id;
	}

	public Long getCategory2Id() {
		return category2Id;
	}

	public void setCategory2Id(Long category2Id) {
		this.category2Id = category2Id;
	}

	public Long getCategory3Id() {
		return category3Id;
	}

	public void setCategory3Id(Long category3Id) {
		this.category3Id = category3Id;
	}

	public Long getThumbnailFileId() {
		return thumbnailFileId;
	}

	public void setThumbnailFileId(Long thumbnailFileId) {
		this.thumbnailFileId = thumbnailFileId;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getFinalPrice() {
		return finalPrice;
	}

	public void setFinalPrice(BigDecimal finalPrice) {
		this.finalPrice = finalPrice;
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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
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

	public Integer getTotalSold() {
		return totalSold;
	}

	public void setTotalSold(Integer totalSold) {
		this.totalSold = totalSold;
	}

	public Integer getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(Integer reviewCount) {
		this.reviewCount = reviewCount;
	}

	public Double getAvgRating() {
		return avgRating;
	}

	public void setAvgRating(Double avgRating) {
		this.avgRating = avgRating;
	}

	public Integer getWishCount() {
		return wishCount;
	}

	public void setWishCount(Integer wishCount) {
		this.wishCount = wishCount;
	}

	public Double getPopularityScore() {
		return popularityScore;
	}

	public void setPopularityScore(Double popularityScore) {
		this.popularityScore = popularityScore;
	}

}
