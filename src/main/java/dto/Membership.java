package dto;

import java.sql.Timestamp;

public class Membership {
    private Long membershipId;    // 멤버십 ID (PK, AUTO_INCREMENT)
    private Long brandId;         // 멤버십 가입 브랜드 ID (FK → brand.brand_id)
    private String planId;          // 가입한 요금제 ID (FK → membership_plan.membership_plan_id)
    private Timestamp startDate;  // 멤버십 시작일
    private Timestamp endDate;    // 멤버십 만료일
    private String status;        // 상태 (ACTIVE, EXPIRED, CANCELLED)
    private Timestamp createdAt;  // 생성일
    private Timestamp updatedAt;  // 최근 갱신일
    private Integer remainQuota;  // 남은 발송 건수

    public Membership() {
    }

    public Long getMembershipId() {
        return membershipId;
    }
    public void setMembershipId(Long membershipId) {
        this.membershipId = membershipId;
    }

    public Long getBrandId() {
        return brandId;
    }
    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public String getPlanId() {
        return planId;
    }
    public void setPlanId(String planId) {
        this.planId = planId;
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

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
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

    public Integer getRemainQuota() {
        return remainQuota;
    }
    public void setRemainQuota(Integer remainQuota) {
        this.remainQuota = remainQuota;
    }

    @Override
    public String toString() {
        return "Membership [membershipId=" + membershipId + ", brandId=" + brandId +
                ", planId=" + planId + ", startDate=" + startDate +
                ", endDate=" + endDate + ", status=" + status +
                ", createdAt=" + createdAt + ", updatedAt=" + updatedAt +
                ", remainQuota=" + remainQuota + "]";
    }
}
