package dto.consumer;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

public class ProductSaleExclusive {
	private Long productId; // 상품 고유 식별자 (PK, AUTO_INCREMENT → product.product_id)
	private Long brandId; // 브랜드 ID (FK → brand.brand_id)
	private String brandName; // 브랜드명 (brand.brand_name)
	private String name; // 상품명 (product.name)

	private Integer hasOption; // 옵션 존재 여부 (tinyint, 0/1)
	private Integer isExclusive; // 단독 판매 여부 (tinyint, 0/1)
	private Integer isVisible; // 노출 여부 (tinyint, 0/1)
	private Integer isPlanned; // 기획 상품 여부 (tinyint, 0/1)

	private Long thumbnailFileId; // 썸네일 이미지 파일 ID (FK → upload_file.upload_file_id)

	private BigDecimal price; // 기본 판매가 (product.price)
	private String discountType; // 할인 유형 (RATE = 정률, AMOUNT = 정액)
	private BigDecimal discountValue; // 할인 값 (퍼센트 또는 금액)
	private Date startDate; // 세일 시작일 (product.start_date)
	private Date endDate; // 세일 종료일 (product.end_date)

	private Timestamp createdAt; // 등록일 (product.created_at)
	private Timestamp updatedAt; // 수정일 (product.updated_at)

	private Integer isWished; // 찜 여부 (1: 찜함, 0: 안 함)
	private BigDecimal finalPrice; // 최종 판매가 (할인 적용된 금액)

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

	public Integer getHasOption() {
		return hasOption;
	}

	public void setHasOption(Integer hasOption) {
		this.hasOption = hasOption;
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

}
