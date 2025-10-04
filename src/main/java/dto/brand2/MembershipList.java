package dto.brand2;

import java.sql.Timestamp;

public class MembershipList {
    private Long membershipId;        // 멤버십 ID (PK, AUTO_INCREMENT)
    private Timestamp startDate;      // 멤버십 시작일
    private Timestamp endDate;        // 멤버십 만료일

    private Timestamp payDate;        // 결제일
    private Timestamp cancelDate;     // 취소일 (취소시만 값 존재)
    private String status;            // 결제 상태 (예: PAID, CANCELED)

    private String planId;            // 요금제 ID (PLAN_1M, PLAN_3M, ...)
    private String planName;          // 요금제명 (멤버십 1개월, 3개월 ...)
    
    private String paymentMethod;     // 결제수단 (TOSS, CARD, ...)
    private Timestamp nextPayDate;
    
    public MembershipList() {
    }
    
	public Long getMembershipId() {
		return membershipId;
	}
	public void setMembershipId(Long membershipId) {
		this.membershipId = membershipId;
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
	public Timestamp getPayDate() {
		return payDate;
	}
	public void setPayDate(Timestamp payDate) {
		this.payDate = payDate;
	}
	public Timestamp getCancelDate() {
		return cancelDate;
	}
	public void setCancelDate(Timestamp cancelDate) {
		this.cancelDate = cancelDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public Timestamp getNextPayDate() {
		return nextPayDate;
	}
	public void setNextPayDate(Timestamp nextPayDate) {
		this.nextPayDate = nextPayDate;
	}

	@Override
	public String toString() {
		return "MembershipList [membershipId=" + membershipId + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", payDate=" + payDate + ", cancelDate=" + cancelDate + ", status=" + status + ", planId=" + planId
				+ ", planName=" + planName + ", paymentMethod=" + paymentMethod + ", nextPayDate=" + nextPayDate + "]";
	}


}