package dto;

import java.sql.Timestamp;

public class BrandFollow {
    private Long brandFollowId;  // 관심브랜드 ID (PK, AUTO_INCREMENT)
    private Long memberId;       // 회원 ID (FK → member.member_id)
    private Long brandId;        // 브랜드 ID (FK → brand.brand_id)
    private Timestamp createdAt; // 등록한 시각 (DEFAULT CURRENT_TIMESTAMP)

    public BrandFollow() {
    }

    public Long getBrandFollowId() {
        return brandFollowId;
    }
    public void setBrandFollowId(Long brandFollowId) {
        this.brandFollowId = brandFollowId;
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "BrandFollow [brandFollowId=" + brandFollowId +
                ", memberId=" + memberId + ", brandId=" + brandId +
                ", createdAt=" + createdAt + "]";
    }
}
