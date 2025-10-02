package dto;

import java.sql.Timestamp;

import dto.brand2.BannerForm;

public class Banner {
    private Long bannerId;         // 배너 광고 신청 ID (PK, AUTO_INCREMENT)
    private Long brandId;          // 브랜드 관리자 ID (FK → brand.brand_id)
    private String managerName;    // 담당자명
    private String managerTel;     // 연락처
    private Timestamp startDate;   // 시작일
    private Timestamp endDate;     // 종료일
    private String bannerName;     // 배너 광고명
    private String bannerMessage;  // 관리자 전달사항
    private String status;         // 진행상황 (PENDING / APPROVED / ONGOING / COMPLETED / CANCELED)
    private Timestamp createdAt;   // 신청일 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp updatedAt;   // 수정일
    private Integer isExposed;     // 노출여부 (tinyint, DEFAULT 1)
    private String brandUrl;       // 브랜드페이지 URL
    private String stateChange;    // 배너 게시 상태 (POSTING / OFF)
    private Long adminId;          // 승인 관리자 ID (FK → admin_info.admin_info_id)
    private Long UploadFileId;	   // 업로드 파일 ID (FK → upload_file.upload_file_id)
    
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

    public String getBrandUrl() {
        return brandUrl;
    }
    public void setBrandUrl(String brandUrl) {
        this.brandUrl = brandUrl;
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
	public Long getUploadFileId() {
		return UploadFileId;
	}
	public void setUploadFileId(Long uploadFileId) {
		UploadFileId = uploadFileId;
	}
	@Override
	public String toString() {
		return "Banner [bannerId=" + bannerId + ", brandId=" + brandId + ", managerName=" + managerName
				+ ", managerTel=" + managerTel + ", startDate=" + startDate + ", endDate=" + endDate + ", bannerName="
				+ bannerName + ", bannerMessage=" + bannerMessage + ", status=" + status + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + ", isExposed=" + isExposed + ", brandUrl=" + brandUrl + ", stateChange="
				+ stateChange + ", adminId=" + adminId + ", UploadFileId=" + UploadFileId + "]";
	}
}