package dto;

import java.sql.Timestamp;

public class Wishlist {
    private Long wishlistId;     // 관심상품 ID (PK, AUTO_INCREMENT)
    private Long memberId;       // 회원 ID (FK → member.member_id)
    private Long productId;      // 상품 ID (FK → product.product_id)
    private Timestamp createdAt; // 찜한 시각 (DEFAULT CURRENT_TIMESTAMP)

    public Wishlist() {
    }

    public Long getWishlistId() {
        return wishlistId;
    }
    public void setWishlistId(Long wishlistId) {
        this.wishlistId = wishlistId;
    }

    public Long getMemberId() {
        return memberId;
    }
    public void setMemberId(Long memberId) {
        this.memberId = memberId;
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

    @Override
    public String toString() {
        return "Wishlist [wishlistId=" + wishlistId +
                ", memberId=" + memberId + ", productId=" + productId +
                ", createdAt=" + createdAt + "]";
    }
}
