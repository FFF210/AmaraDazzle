package dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Cancel {
    private Long cancelId;       // 취소 ID (PK, AUTO_INCREMENT)
    private Long paymentId;      // 원본 결제 ID (FK → payment.payment_id)
    private BigDecimal amount;   // 환불 금액 (CHECK >=0)
    private Timestamp updatedAt; // 취소 시각 (DEFAULT CURRENT_TIMESTAMP)

    public Cancel() {
    }

	public Long getCancelId() {
		return cancelId;
	}

	public void setCancelId(Long cancelId) {
		this.cancelId = cancelId;
	}

	public Long getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(Long paymentId) {
		this.paymentId = paymentId;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	@Override
	public String toString() {
		return "Cancel [cancelId=" + cancelId + ", paymentId=" + paymentId + ", amount=" + amount + ", updatedAt="
				+ updatedAt + "]";
	}
}

   
