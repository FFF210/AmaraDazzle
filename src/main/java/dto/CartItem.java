package dto;

import java.sql.Timestamp;

public class CartItem {
    private Long cartItemId;     // 장바구니 아이템 ID (PK, AUTO_INCREMENT)
    private Long memberId;       // 회원 ID (FK → member.member_id)
    private Long brandId;        // 브랜드 ID (FK → brand.brand_id)
    private Long productId;      // 상품 ID (FK → product.product_id)
    private Long optionId;       // 상품 옵션 ID (FK → product_option.product_option_id)
    private Integer quantity;    // 담은 수량 (CHECK > 0)
    private Timestamp createdAt; // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp updatedAt; // 수정 시각 (ON UPDATE CURRENT_TIMESTAMP)

    public CartItem() {
    }

    public Long getCartItemId() {
        return cartItemId;
    }
    public void setCartItemId(Long cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Long getMemberId() {
        return memberId;
    }
    public void setMemberId(Long memberId) {
        this.memberId = memberId;
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

    public Long getOptionId() {
        return optionId;
    }
    public void setOptionId(Long optionId) {
        this.optionId = optionId;
    }

    public Integer getQuantity() {
        return quantity;
    }
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
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
        return "CartItem [cartItemId=" + cartItemId +
                ", memberId=" + memberId + ", brandId=" + brandId +
                ", productId=" + productId + ", optionId=" + optionId +
                ", quantity=" + quantity + ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt + "]";
    }
}
