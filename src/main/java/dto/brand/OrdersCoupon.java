package dto.brand;

public class OrdersCoupon {
	private Long memberCouponId; // 회원 쿠폰 ID (PK, member_coupon.member_coupon_id)
	private String couponStatus; // 쿠폰 상태 (USED, AVAILABLE, EXPIRED)
	private String usedDate; // 쿠폰 사용일자 (timestamp)

	private Long couponId; // 쿠폰 ID (coupon.coupon_id)
	private String cname; // 쿠폰명
	private Integer amount; // 할인 금액
	private String amountCondition;// 금액 조건 (예: 30000 이상 사용 가능)

	private String startDate; // 쿠폰 시작일자
	private String endDate; // 쿠폰 종료일자
	private String reason; // 지급 사유
	private String provision; // 지급 대상 유형 (모든회원, VIP, GOLD, ...)
}
