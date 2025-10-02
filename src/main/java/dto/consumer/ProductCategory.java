package dto.consumer;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

public class ProductCategory {
	private Long productId; // 상품 고유 식별자 (product.product_id)
	private Long brandId; // 브랜드 ID (brand.brand_id)
	private String brandName; // 브랜드명 (brand.brand_name)
	private String name; // 상품명 (product.name)

	private Integer isExclusive; // 단독 판매 여부 (tinyint 0/1)
	private Integer isVisible; // 노출 여부 (tinyint 0/1)
	private Integer isPlanned; // 기획 상품 여부 (tinyint 0/1)
	private Integer hasOption; // 옵션 존재 여부 (tinyint 0/1)

	private Long category1Id; // 대분류 카테고리 ID
	private Long category2Id; // 중분류 카테고리 ID
	private Long category3Id; // 소분류 카테고리 ID
	private Long thumbnailFileId; // 썸네일 이미지 파일 ID

	private BigDecimal price; // 기본 판매가
	private String discountType; // 할인 유형 (RATE/AMOUNT)
	private BigDecimal discountValue; // 할인 값 (퍼센트 또는 금액)
	private Date startDate; // 세일 시작일
	private Date endDate; // 세일 종료일

	private Timestamp createdAt; // 등록일
	private Timestamp updatedAt; // 수정일

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

	public Integer getHasOption() {
		return hasOption;
	}

	public void setHasOption(Integer hasOption) {
		this.hasOption = hasOption;
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

	private Integer totalSold; // 최근 30일 판매량
	private Integer reviewCount; // 최근 30일 리뷰 개수
	private Double avgRating; // 최근 30일 평균 평점
	private Integer wishCount; // 최근 30일 찜 개수
	private Double popularityScore;// 인기 점수 계산 값
	private Integer isWished; // 현재 로그인 사용자 찜 여부 (1/0)
	private BigDecimal finalPrice; // 최종 판매가 (할인 적용된 금액)

}
