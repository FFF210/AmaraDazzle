package dto;

import java.math.BigDecimal;

public class Payment {
    private Long paymentId;     // 결제 내역 ID (PK, AUTO_INCREMENT)
    private Long orderId;       // 주문 ID (FK → orders.orders_id)
    private String provider;    // 결제 업체 (예: toss)
    private String method;      // 결제 수단 (예: tosspay)
    private BigDecimal amount;  // 결제 금액
    private String status;      // 결제 상태 (AUTHORIZED, CANCELLED)
    private String paymentKey;  // PG사 결제 고유키 (UNIQUE)

    public Payment() {
    }

    public Long getPaymentId() {
        return paymentId;
    }
    public void setPaymentId(Long paymentId) {
        this.paymentId = paymentId;
    }

    public Long getOrderId() {
        return orderId;
    }
    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getProvider() {
        return provider;
    }
    public void setProvider(String provider) {
        this.provider = provider;
    }

    public String getMethod() {
        return method;
    }
    public void setMethod(String method) {
        this.method = method;
    }

    public BigDecimal getAmount() {
        return amount;
    }
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentKey() {
        return paymentKey;
    }
    public void setPaymentKey(String paymentKey) {
        this.paymentKey = paymentKey;
    }

    @Override
    public String toString() {
        return "Payment [paymentId=" + paymentId + ", orderId=" + orderId +
                ", provider=" + provider + ", method=" + method +
                ", amount=" + amount + ", status=" + status +
                ", paymentKey=" + paymentKey + "]";
    }
}
