package dto.consumer;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ProductSearch {
	private Long productId; // 상품 ID
	private Long brandId; // 브랜드 ID
	private String brandName; // 브랜드명
	private String name; // 상품명
	private Integer isExclusive; // 단독 판매 여부
	private Integer isVisible; // 노출 여부
	private Integer isPlanned; // 기획상품 여부
	private Integer hasOption; // 옵션 존재 여부
	private Long thumbnailFileId; // 썸네일 이미지 파일 ID

	private BigDecimal price; // 원가
	private String discountType; // 할인 타입 (RATE, AMOUNT)
	private BigDecimal discountValue; // 할인 값
	private Timestamp startDate; // 세일 시작일
	private Timestamp endDate; // 세일 종료일
	private Timestamp createdAt; // 생성 시각
	private Timestamp updatedAt; // 수정 시각

	private Integer isWished; // 사용자가 찜했는지 여부
	private BigDecimal finalPrice; // 세일가 (계산된 값)
	private Integer isSale; // 세일 상품 여부 (쿼리 계산값)

	private Integer totalSold; // 최근 30일간 판매량
	private Integer reviewCount; // 최근 30일간 리뷰 수
	private Double avgRating; // 최근 30일간 평균 평점
	private Integer wishCount; // 최근 30일간 찜 수
	private Double popularityScore;// 인기 점수 (판매+리뷰+평점+찜 가중치)

	public Integer getHasOption() {
		return hasOption;
	}

	public void setHasOption(Integer hasOption) {
		this.hasOption = hasOption;
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

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public Integer getIsPlanned() {
		return isPlanned;
	}

	public void setIsPlanned(Integer isPlanned) {
		this.isPlanned = isPlanned;
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

	public Integer getIsWished() {
		return isWished;
	}

	public void setIsWished(Integer isWished) {
		this.isWished = isWished;
	}

	public BigDecimal getFinalPrice() {
		return finalPrice;
	}

	public void setFinalPrice(BigDecimal finalPrice) {
		this.finalPrice = finalPrice;
	}

	public Integer getIsSale() {
		return isSale;
	}

	public void setIsSale(Integer isSale) {
		this.isSale = isSale;
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
