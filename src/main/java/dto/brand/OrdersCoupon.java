package dto.brand;

import java.sql.Timestamp;

public class OrdersCoupon {
	private Long memberCouponId; // 회원 쿠폰 ID (PK, member_coupon.member_coupon_id)
	private Timestamp usedDate; // 쿠폰 사용일자 (timestamp)
	private Long couponId; // 쿠폰 ID (coupon.coupon_id)
	private String cname; // 쿠폰명

	public Long getMemberCouponId() {
		return memberCouponId;
	}

	public void setMemberCouponId(Long memberCouponId) {
		this.memberCouponId = memberCouponId;
	}

	public Timestamp getUsedDate() {
		return usedDate;
	}

	public void setUsedDate(Timestamp usedDate) {
		this.usedDate = usedDate;
	}

	public Long getCouponId() {
		return couponId;
	}

	public void setCouponId(Long couponId) {
		this.couponId = couponId;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}
}
