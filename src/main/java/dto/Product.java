package dto;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

public class Product {
    private Long productId;           // 고유 식별자 (PK, AUTO_INCREMENT)
    private String brandId;           // 등록 브랜드 관리자 ID (FK → brand.brand_id)
    private String name;              // 상품명
    private Integer isExclusive;      // 단독 판매 여부 (tinyint, DEFAULT 0)
    private Integer isVisible;        // 상품 공개 여부 (tinyint, DEFAULT 1)
    private Integer isPlanned;        // 기획 상품 여부 (tinyint, DEFAULT 0)
    private Long categoryId;          // 카테고리 ID (FK → category.category_id)
    private Long thumbnailFileId;     // 썸네일 파일 ID (FK → upload_file.upload_file_id)
    private Long image1FileId;        // 업로드 이미지 파일 ID
    private Long image2FileId;        // 업로드 이미지 파일 ID
    private Long image3FileId;        // 업로드 이미지 파일 ID
    private Long image4FileId;        // 업로드 이미지 파일 ID
    private Long image5FileId;        // 업로드 이미지 파일 ID
    private String ingredients;       // 전성분
    private BigDecimal price;         // 판매가 (기본가)
    private Integer orderLimit;       // 1회 주문 수량 제한값
    private Integer hasOption;        // 옵션 존재 여부 (tinyint, DEFAULT 0)
    private Integer stockQty;         // 단일 상품 재고 (옵션 없을 때만 사용)
    private String shippingMethod;    // 배송 방법 (DEFAULT, FREE)
    private String discountType;      // 할인 방식 (RATE, AMOUNT)
    private BigDecimal discountValue; // 할인 값(퍼센트 또는 금액)
    private Date startDate;           // 세일 시작 시각
    private Date endDate;             // 세일 종료 시각
    private Long eventId;             // 이벤트 ID
    private Timestamp createdAt;      // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp updatedAt;      // 수정 시각 (ON UPDATE CURRENT_TIMESTAMP)

    public Product() {
    }

    public Long getProductId() {
        return productId;
    }
    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getBrandId() {
        return brandId;
    }
    public void setBrandId(String brandId) {
        this.brandId = brandId;
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

    public Long getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public Long getThumbnailFileId() {
        return thumbnailFileId;
    }
    public void setThumbnailFileId(Long thumbnailFileId) {
        this.thumbnailFileId = thumbnailFileId;
    }

    public Long getImage1FileId() {
        return image1FileId;
    }
    public void setImage1FileId(Long image1FileId) {
        this.image1FileId = image1FileId;
    }

    public Long getImage2FileId() {
        return image2FileId;
    }
    public void setImage2FileId(Long image2FileId) {
        this.image2FileId = image2FileId;
    }

    public Long getImage3FileId() {
        return image3FileId;
    }
    public void setImage3FileId(Long image3FileId) {
        this.image3FileId = image3FileId;
    }

    public Long getImage4FileId() {
        return image4FileId;
    }
    public void setImage4FileId(Long image4FileId) {
        this.image4FileId = image4FileId;
    }

    public Long getImage5FileId() {
        return image5FileId;
    }
    public void setImage5FileId(Long image5FileId) {
        this.image5FileId = image5FileId;
    }

    public String getIngredients() {
        return ingredients;
    }
    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }

    public BigDecimal getPrice() {
        return price;
    }
    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getOrderLimit() {
        return orderLimit;
    }
    public void setOrderLimit(Integer orderLimit) {
        this.orderLimit = orderLimit;
    }

    public Integer getHasOption() {
        return hasOption;
    }
    public void setHasOption(Integer hasOption) {
        this.hasOption = hasOption;
    }

    public Integer getStockQty() {
        return stockQty;
    }
    public void setStockQty(Integer stockQty) {
        this.stockQty = stockQty;
    }

    public String getShippingMethod() {
        return shippingMethod;
    }
    public void setShippingMethod(String shippingMethod) {
        this.shippingMethod = shippingMethod;
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

    public Long getEventId() {
        return eventId;
    }
    public void setEventId(Long eventId) {
        this.eventId = eventId;
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

    @Override
    public String toString() {
        return "Product [productId=" + productId + ", brandId=" + brandId +
                ", name=" + name + ", isExclusive=" + isExclusive +
                ", isVisible=" + isVisible + ", isPlanned=" + isPlanned +
                ", categoryId=" + categoryId + ", thumbnailFileId=" + thumbnailFileId +
                ", image1FileId=" + image1FileId + ", image2FileId=" + image2FileId +
                ", image3FileId=" + image3FileId + ", image4FileId=" + image4FileId +
                ", image5FileId=" + image5FileId + ", ingredients=" + ingredients +
                ", price=" + price + ", orderLimit=" + orderLimit +
                ", hasOption=" + hasOption + ", stockQty=" + stockQty +
                ", shippingMethod=" + shippingMethod + ", discountType=" + discountType +
                ", discountValue=" + discountValue + ", startDate=" + startDate +
                ", endDate=" + endDate + ", eventId=" + eventId +
                ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
    }
}
