package dto;

import java.sql.Timestamp;

public class MemberCoupon {
    private Long memberCouponId; // 쿠폰 내역 ID (PK, AUTO_INCREMENT)
    private Long couponId;       // 쿠폰 ID (FK → coupon.coupon_id)
    private Long memberId;     // 고객 ID (FK → member.member_id)
    private String status;       // 쿠폰 상태 (USED, AVAILABLE, EXPIRED)
    private Timestamp usedDate;  // 사용일자
    private String orderId;      // 주문번호 (FK → orders.order_id)
    private Timestamp createdAt; // 발급받은 일자

    public MemberCoupon() {
    }

    public Long getMemberCouponId() {
        return memberCouponId;
    }
    public void setMemberCouponId(Long memberCouponId) {
        this.memberCouponId = memberCouponId;
    }

    public Long getCouponId() {
        return couponId;
    }
    public void setCouponId(Long couponId) {
        this.couponId = couponId;
    }

    public Long getMemberId() {
        return memberId;
    }
    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getUsedDate() {
        return usedDate;
    }
    public void setUsedDate(Timestamp usedDate) {
        this.usedDate = usedDate;
    }

    public String getOrderId() {
        return orderId;
    }
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "MemberCoupon [memberCouponId=" + memberCouponId + ", couponId=" + couponId +
                ", memberId=" + memberId + ", status=" + status +
                ", usedDate=" + usedDate + ", orderId=" + orderId +
                ", createdAt=" + createdAt + "]";
    }
}
