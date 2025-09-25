package dto;

import java.sql.Timestamp;

public class Brand {
    private Long brandId;           // 고유 식별자 (PK, AUTO_INCREMENT)
    private String email;           // 이메일 (UNIQUE)
    private String password;        // 비밀번호
    private String brn;             // 사업자등록번호 (UNIQUE)
    private String brandName;       // 브랜드명 (UNIQUE)
    private String managerName;     // 담당자명
    private String phone;           // 담당자 휴대폰 번호 (UNIQUE)
    private String brandStatus;     // 계정 상태 (SIGNUP_COMPLETED, APPLY_SUBMITTED, APPROVED)
    private Long logoFileId;        // 업로드된 로고 이미지 파일 ID (FK → upload_file.upload_file_id)
    private Long heroFileId;        // 업로드된 배너 이미지 파일 ID (FK → upload_file.upload_file_id)
    private String intro;           // 브랜드 소개 문구
    private String bank;            // 정산 은행명
    private String accountNumber;   // 정산 계좌번호
    private String accountHolder;   // 예금주명
    private String settlementDate;  // 정산 일자
    private Timestamp createdAt;    // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp updatedAt;    // 수정 시각 (ON UPDATE CURRENT_TIMESTAMP)

    public Brand() {
    }

    public Long getBrandId() {
        return brandId;
    }
    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getBrn() {
        return brn;
    }
    public void setBrn(String brn) {
        this.brn = brn;
    }

    public String getBrandName() {
        return brandName;
    }
    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getManagerName() {
        return managerName;
    }
    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getBrandStatus() {
        return brandStatus;
    }
    public void setBrandStatus(String brandStatus) {
        this.brandStatus = brandStatus;
    }

    public Long getLogoFileId() {
        return logoFileId;
    }
    public void setLogoFileId(Long logoFileId) {
        this.logoFileId = logoFileId;
    }

    public Long getHeroFileId() {
        return heroFileId;
    }
    public void setHeroFileId(Long heroFileId) {
        this.heroFileId = heroFileId;
    }

    public String getIntro() {
        return intro;
    }
    public void setIntro(String intro) {
        this.intro = intro;
    }

    public String getBank() {
        return bank;
    }
    public void setBank(String bank) {
        this.bank = bank;
    }

    public String getAccountNumber() {
        return accountNumber;
    }
    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getAccountHolder() {
        return accountHolder;
    }
    public void setAccountHolder(String accountHolder) {
        this.accountHolder = accountHolder;
    }

    public String getSettlementDate() {
        return settlementDate;
    }
    public void setSettlementDate(String settlementDate) {
        this.settlementDate = settlementDate;
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
        return "Brand [brandId=" + brandId + ", email=" + email +
                ", password=" + password + ", brn=" + brn +
                ", brandName=" + brandName + ", managerName=" + managerName +
                ", phone=" + phone + ", brandStatus=" + brandStatus +
                ", logoFileId=" + logoFileId + ", heroFileId=" + heroFileId +
                ", intro=" + intro + ", bank=" + bank +
                ", accountNumber=" + accountNumber + ", accountHolder=" + accountHolder +
                ", settlementDate=" + settlementDate + ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt + "]";
    }
}
