package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.consumer.CouponList;

public interface CouponDAO {
	// ======================= [소비자] 다운 가능한 쿠폰 목록 조회 =======================
	List<CouponList> selectAvailableCoupons(Map<String, Object> params) throws Exception;

	// ======================= [소비자] 해당 브랜드 쿠폰 목록 조회 =======================
	List<CouponList> selectAvailableCouponsForBrand(Map<String, Object> params) throws Exception;

	// ======================= [소비자] 쿠폰 다운로드 =======================
	void insertMemberCoupon(Map<String, Object> params) throws Exception;

	// ======================= [소비자] 쿠폰 제한 수량 감소 =======================
	void decreaseCouponLimit(Long couponId) throws Exception;
}
