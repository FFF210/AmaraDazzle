package dto;

public class MembershipPlan {
    private String membershipPlanId; // 요금제 ID (PK, UNIQUE)
    private Integer planPeriod;      // 기간(개월 단위, CHECK > 0)
    private Integer amount;          // 요금제 금액 (원, CHECK >= 0, DEFAULT 0)
    private String explain;          // 설명

    public MembershipPlan() {
    }

    public String getMembershipPlanId() {
        return membershipPlanId;
    }
    public void setMembershipPlanId(String membershipPlanId) {
        this.membershipPlanId = membershipPlanId;
    }

    public Integer getPlanPeriod() {
        return planPeriod;
    }
    public void setPlanPeriod(Integer planPeriod) {
        this.planPeriod = planPeriod;
    }

    public Integer getAmount() {
        return amount;
    }
    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public String getExplain() {
        return explain;
    }
    public void setExplain(String explain) {
        this.explain = explain;
    }

    @Override
    public String toString() {
        return "MembershipPlan [membershipPlanId=" + membershipPlanId +
                ", planPeriod=" + planPeriod + ", amount=" + amount +
                ", explain=" + explain + "]";
    }
}
