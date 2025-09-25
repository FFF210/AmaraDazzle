package dto;

import java.sql.Timestamp;

public class AdminPayment {
    private Long paymentId;         // 결제 내역 고유 ID (PK, AUTO_INCREMENT)
    private String paymentType;     // 결제 유형 (MEMBERSHIP / BANNER_AD)
    private String paymentKey;      // PG사 결제 고유키 (UNIQUE)
    private Long brandId;           // 결제한 브랜드 ID (FK → brand.brand_id)
    private Integer amount;         // 결제 금액 (원, CHECK >= 0, DEFAULT 0)
    private Long planId;            // 멤버십 요금제 ID (FK → membership_plan.membership_plan_id)
    private Long bannerId;          // 배너 광고 ID (FK → banner.banner_id)
    private Timestamp payDate;      // 결제일 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp lastAutopayDate; // 마지막 정기결제일

    public AdminPayment() {
    }

    public Long getPaymentId() {
        return paymentId;
    }
    public void setPaymentId(Long paymentId) {
        this.paymentId = paymentId;
    }

    public String getPaymentType() {
        return paymentType;
    }
    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getPaymentKey() {
        return paymentKey;
    }
    public void setPaymentKey(String paymentKey) {
        this.paymentKey = paymentKey;
    }

    public Long getBrandId() {
        return brandId;
    }
    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public Integer getAmount() {
        return amount;
    }
    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Long getPlanId() {
        return planId;
    }
    public void setPlanId(Long planId) {
        this.planId = planId;
    }

    public Long getBannerId() {
        return bannerId;
    }
    public void setBannerId(Long bannerId) {
        this.bannerId = bannerId;
    }

    public Timestamp getPayDate() {
        return payDate;
    }
    public void setPayDate(Timestamp payDate) {
        this.payDate = payDate;
    }

    public Timestamp getLastAutopayDate() {
        return lastAutopayDate;
    }
    public void setLastAutopayDate(Timestamp lastAutopayDate) {
        this.lastAutopayDate = lastAutopayDate;
    }

    @Override
    public String toString() {
        return "AdminPayment [paymentId=" + paymentId + ", paymentType=" + paymentType +
                ", paymentKey=" + paymentKey + ", brandId=" + brandId +
                ", amount=" + amount + ", planId=" + planId +
                ", bannerId=" + bannerId + ", payDate=" + payDate +
                ", lastAutopayDate=" + lastAutopayDate + "]";
    }
}
