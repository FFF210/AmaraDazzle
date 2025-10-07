package dto.consumer;

import java.math.BigDecimal;

public class ModalProduct {
	private Long productId; // 상품 고유 식별자 (PK, AUTO_INCREMENT)
	private Long brandId; // 등록 브랜드 관리자 ID (FK → brand.brand_id)
	private String name; // 상품명
	private String brandName; // 브랜드명

	private Integer isExclusive; // 단독 판매 여부 (tinyint, DEFAULT 0)
	private Integer isVisible; // 상품 공개 여부 (tinyint, DEFAULT 1)
	private Integer isPlanned; // 기획 상품 여부 (tinyint, DEFAULT 0)
	private Integer hasOption; // 옵션 존재 여부
	private Integer isSale; // 세일 여부 (쿼리에서 계산: 0/1)
	private Integer isWished; // 1: 찜했음, 0: 안함

	private Long thumbnailFileId; // 썸네일 파일 ID (FK → upload_file.upload_file_id)

	private BigDecimal price; // 판매가 (기본가)
	private BigDecimal finalPrice; // 최종 판매가 (세일 적용가)
	private String discountType; // 할인 방식 (RATE, AMOUNT)
	private BigDecimal discountValue; // 할인 값(퍼센트 또는 금액)

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

	public Integer getIsSale() {
		return isSale;
	}

	public void setIsSale(Integer isSale) {
		this.isSale = isSale;
	}

	public Integer getIsWished() {
		return isWished;
	}

	public void setIsWished(Integer isWished) {
		this.isWished = isWished;
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

}
