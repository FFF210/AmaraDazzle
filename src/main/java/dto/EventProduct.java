package dto;

import java.sql.Timestamp;

public class EventProduct {
    private Long eventProductId; // 이벤트 참여 상품 ID (PK, AUTO_INCREMENT)
    private Long brandId;        // 브랜드 ID (FK → brand.brand_id)
    private Long productId;      // 상품 ID (FK → product.product_id)
    private Timestamp createdAt; // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp updatedAt; // 수정 시각 (ON UPDATE CURRENT_TIMESTAMP)

    public EventProduct() {
    }

    public Long getEventProductId() {
        return eventProductId;
    }
    public void setEventProductId(Long eventProductId) {
        this.eventProductId = eventProductId;
    }

    public Long getBrandId() {
        return brandId;
    }
    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public Long getProductId() {
        return productId;
    }
    public void setProductId(Long productId) {
        this.productId = productId;
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
        return "EventProduct [eventProductId=" + eventProductId +
                ", brandId=" + brandId + ", productId=" + productId +
                ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
    }
}
