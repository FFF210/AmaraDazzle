package dto;

import java.sql.Timestamp;

public class Banner {

    private Long bannerId;         // 배너 광고 신청 ID (PK, AUTO_INCREMENT)
    private Long brandId;          // 브랜드 관리자 ID 
    private String managerName;    // 담당자명
    private String managerTel;     // 연락처
    private Timestamp startDate;   // 시작일
    private Timestamp endDate;     // 종료일
    private String bannerName;     // 배너 광고명
    private String bannerMessage;  // 관리자 전달사항
    private String status;         // 진행상황 (PENDING / APPROVED / ONGOING / COMPLETED / CANCELED, DEFAULT 'PENDING')
    private Timestamp createdAt;   // 신청일 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp changedAt;   // 수정일
    private String brandUrl;       // 브랜드페이지 URL
    private String stateChange;    // 배너 게시 상태 (POSTING / OFF)
    private Long adminId;          // 승인 관리자 ID (FK → admin_info.admin_info_id)
    private Long UploadFileId;	   // 업로드 파일 ID (FK → upload_file.upload_file_id)
    
    private int period; //기간 (계산용)
    
    //조인용 컬럼 
    private String brandName;	//브랜드명 
    private String aName; //관리자명 
    private Integer payAmount; //지불금액
    private String fileName;     // 원본 파일명
    private String fileRename;   // 리네임 파일명 (UNIQUE)
    
    
    public Banner() {}
	public Banner(Timestamp startDate, Timestamp endDate, String bannerName, String brandUrl,
			Long adminId, Long uploadFileId) {
		this.startDate = startDate;
		this.endDate = endDate;
		this.bannerName = bannerName;
		this.brandUrl = brandUrl;
		this.adminId = adminId;
		this.UploadFileId = uploadFileId;
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
	public Timestamp getChangedAt() {
		return changedAt;
	}
	public void setChangedAt(Timestamp changedAt) {
		this.changedAt = changedAt;
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
	public int getPeriod() {
		return period;
	}
	public void setPeriod(int period) {
		this.period = period;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getaName() {
		return aName;
	}
	public void setaName(String aName) {
		this.aName = aName;
	}
	public Integer getPayAmount() {
		return payAmount;
	}
	public void setPayAmount(Integer payAmount) {
		this.payAmount = payAmount;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileRename() {
		return fileRename;
	}
	public void setFileRename(String fileRename) {
		this.fileRename = fileRename;
	}
	
	@Override
	public String toString() {
		return "Banner [bannerId=" + bannerId + ", brandId=" + brandId + ", managerName=" + managerName
				+ ", managerTel=" + managerTel + ", startDate=" + startDate + ", endDate=" + endDate + ", bannerName="
				+ bannerName + ", bannerMessage=" + bannerMessage + ", status=" + status + ", createdAt=" + createdAt
				+ ", changedAt=" + changedAt + ", brandUrl=" + brandUrl + ", stateChange=" + stateChange + ", adminId="
				+ adminId + ", UploadFileId=" + UploadFileId + ", period=" + period + ", brandName=" + brandName
				+ ", aName=" + aName + ", payAmount=" + payAmount + ", fileName=" + fileName + ", fileRename="
				+ fileRename + "]";
	}



    
	
}
