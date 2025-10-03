package dto.brand2;

import java.sql.Timestamp;

public class BannerDetail {
	private Long bannerId; // 배너 광고 신청 ID
	private Timestamp createdAt; // 신청일
	private Timestamp startDate; // 시작일
	private Timestamp endDate; // 종료일
	private String bannerName; // 배너 광고명
	private String status; // 진행상태 (PENDING / ONGOING / COMPLETED / CANCELED)
	private String managerName; // 담당자명
	private String managerTel; // 연락처
	private Long UploadFileId; // 업로드 파일 ID (FK → upload_file.upload_file_id)
	private boolean amount; // 결제할 금액

	public BannerDetail() {
	}

	public Long getBannerId() {
		return bannerId;
	}

	public void setBannerId(Long bannerId) {
		this.bannerId = bannerId;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public Long getUploadFileId() {
		return UploadFileId;
	}

	public void setUploadFileId(Long uploadFileId) {
		UploadFileId = uploadFileId;
	}

	public boolean isAmount() {
		return amount;
	}

	public void setAmount(boolean amount) {
		this.amount = amount;
	}

	@Override
	public String toString() {
		return "BannerDetail [bannerId=" + bannerId + ", createdAt=" + createdAt + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", bannerName=" + bannerName + ", status=" + status + ", managerName="
				+ managerName + ", managerTel=" + managerTel + ", UploadFileId=" + UploadFileId + ", amount=" + amount
				+ "]";
	}

}
