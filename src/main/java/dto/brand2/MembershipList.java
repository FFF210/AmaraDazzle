package dto.brand2;

import java.sql.Timestamp;

public class MembershipList {
	private Long membershipId; // 멤버십 ID
	private Timestamp startDate; // 멤버십 시작일
	private Timestamp endDate; // 멤버십 만료일

	private Timestamp createdAt; // 결제일 (membership.created_at)
	private Timestamp updatedAt; // 취소일 (membership.updated_at, CANCELLED 시점)
	private String status; // 상태 (ACTIVE, EXPIRED, CANCELLED)

	private String planId; // 요금제 ID (PLAN_1M, PLAN_3M ...)
	private Integer planPeriod; // membership_plan.plan_period

	private String paymentMethod; // 결제수단 (TOSS, CARD ...)
	private Integer remainQuota; // 남은 발송 건수 (현재 or 예약분 확인용)

	private Timestamp nextPayDate; // 다음 결제일 (PLAN_AUTO인 경우에만)

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

	public Integer getPlanPeriod() {
		return planPeriod;
	}

	public void setPlanPeriod(Integer planPeriod) {
		this.planPeriod = planPeriod;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public Integer getRemainQuota() {
		return remainQuota;
	}

	public void setRemainQuota(Integer remainQuota) {
		this.remainQuota = remainQuota;
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
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", status=" + status + ", planId=" + planId
				+ ", planPeriod=" + planPeriod + ", paymentMethod=" + paymentMethod + ", remainQuota=" + remainQuota
				+ ", nextPayDate=" + nextPayDate + "]";
	}
	
}