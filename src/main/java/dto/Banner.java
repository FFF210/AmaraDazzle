package dto;

import java.sql.Timestamp;

public class Banner {
    private Long bannerId;         // 배너 광고 신청 ID (PK, AUTO_INCREMENT)
    private Long brandId;          // 브랜드 관리자 ID (FK → brand.brand_id)
    private String managerName;    // 담당자명
    private String managerTel;     // 연락처
    private Timestamp startDate;   // 시작일
    private Timestamp endDate;     // 종료일
    private String bannerName;     // 배너 광고명
    private String bannerMessage;  // 관리자 전달사항
    private String status;         // 진행상황 (PENDING / ONGOING / COMPLETED / CANCELED)
    private Timestamp createdAt;   // 신청일 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp updatedAt;   // 수정일
    private Integer isExposed;     // 노출여부 (tinyint, DEFAULT 1)
    private Long categoryId;       // 상품 카테고리 (FK → category.category_id)
    private String stateChange;    // 배너 게시 상태 (POSTING / OFF)
    private Long adminId;          // 승인 관리자 ID (FK → admin_info.admin_info_id)

    public Banner() {
    }

    public Long getBannerId() {
        return bannerId;
    }
    public void setBannerId(Long bannerId) {
        this.bannerId = bannerId;
    }

    public Long getBrandId() {
        return brandId;
    }
    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public String getManagerName() {
        return managerName;
    }
    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getManagerTel() {
        return managerTel;
    }
    public void setManagerTel(String managerTel) {
        this.managerTel = managerTel;
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

    public String getBannerName() {
        return bannerName;
    }
    public void setBannerName(String bannerName) {
        this.bannerName = bannerName;
    }

    public String getBannerMessage() {
        return bannerMessage;
    }
    public void setBannerMessage(String bannerMessage) {
        this.bannerMessage = bannerMessage;
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

    public Integer getIsExposed() {
        return isExposed;
    }
    public void setIsExposed(Integer isExposed) {
        this.isExposed = isExposed;
    }

    public Long getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public String getStateChange() {
        return stateChange;
    }
    public void setStateChange(String stateChange) {
        this.stateChange = stateChange;
    }

    public Long getAdminId() {
        return adminId;
    }
    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }

    @Override
    public String toString() {
        return "Banner [bannerId=" + bannerId + ", brandId=" + brandId +
                ", managerName=" + managerName + ", managerTel=" + managerTel +
                ", startDate=" + startDate + ", endDate=" + endDate +
                ", bannerName=" + bannerName + ", bannerMessage=" + bannerMessage +
                ", status=" + status + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt +
                ", isExposed=" + isExposed + ", categoryId=" + categoryId +
                ", stateChange=" + stateChange + ", adminId=" + adminId + "]";
    }
}
