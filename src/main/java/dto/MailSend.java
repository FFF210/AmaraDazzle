package dto;

import java.sql.Timestamp;

public class MailSend {
    private Long mailSendId;          // 메일 발송 ID (PK, AUTO_INCREMENT)
    private Long brandId;             // 사업자 회원 ID (FK → brand.brand_id)
    private String templateType;      // 발송 유형 (COUPON / NEW_PRODUCT / RECOMMEND)
    private String sendType;          // 발송 시간 설정 (NOW / RESERVE)
    private Timestamp reserveDate;    // 예약 발송일
    private Timestamp sendDate;       // 실제 발송일
    private Long productId;           // 상품 ID (FK → product.product_id)
    private Integer categoryId;       // 상품 카테고리 (FK → category.id)
    private String imagePath;         // 업로드 이미지 경로 (FK → file_asset.path)
    private Timestamp regDate;        // 메일 발송 등록일
    private String status;            // 발송 상태 (SENT / RESERVED / FAILED)
    private String targetAge;         // 선택 연령대
    private String recentPurchasePeriod; // 최근 구매 기간 (1주/4주/8주/16주)
    private Long codeDetailId;        // 개인 맞춤 설정 ID (FK → code_detail)

    public MailSend() {
    }

    public Long getMailSendId() {
        return mailSendId;
    }
    public void setMailSendId(Long mailSendId) {
        this.mailSendId = mailSendId;
    }

    public Long getBrandId() {
        return brandId;
    }
    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public String getTemplateType() {
        return templateType;
    }
    public void setTemplateType(String templateType) {
        this.templateType = templateType;
    }

    public String getSendType() {
        return sendType;
    }
    public void setSendType(String sendType) {
        this.sendType = sendType;
    }

    public Timestamp getReserveDate() {
        return reserveDate;
    }
    public void setReserveDate(Timestamp reserveDate) {
        this.reserveDate = reserveDate;
    }

    public Timestamp getSendDate() {
        return sendDate;
    }
    public void setSendDate(Timestamp sendDate) {
        this.sendDate = sendDate;
    }

    public Long getProductId() {
        return productId;
    }
    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getImagePath() {
        return imagePath;
    }
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Timestamp getRegDate() {
        return regDate;
    }
    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getTargetAge() {
        return targetAge;
    }
    public void setTargetAge(String targetAge) {
        this.targetAge = targetAge;
    }

    public String getRecentPurchasePeriod() {
        return recentPurchasePeriod;
    }
    public void setRecentPurchasePeriod(String recentPurchasePeriod) {
        this.recentPurchasePeriod = recentPurchasePeriod;
    }

    public Long getCodeDetailId() {
        return codeDetailId;
    }
    public void setCodeDetailId(Long codeDetailId) {
        this.codeDetailId = codeDetailId;
    }

    @Override
    public String toString() {
        return "MailSend [mailSendId=" + mailSendId + ", brandId=" + brandId +
                ", templateType=" + templateType + ", sendType=" + sendType +
                ", reserveDate=" + reserveDate + ", sendDate=" + sendDate +
                ", productId=" + productId + ", categoryId=" + categoryId +
                ", imagePath=" + imagePath + ", regDate=" + regDate +
                ", status=" + status + ", targetAge=" + targetAge +
                ", recentPurchasePeriod=" + recentPurchasePeriod +
                ", codeDetailId=" + codeDetailId + "]";
    }
}
