package service.consumer;

import java.util.List;
import java.util.Map;

import dto.consumer.CouponList;

public interface CouponService {
	// ======================= [소비자] 다운 가능한 쿠폰 목록 조회 =======================
	List<CouponList> getCounponList(Map<String, Object> params) throws Exception;

	// ======================= [소비자] 쿠폰 다운로드 =======================
	void downloadCoupon(Long couponId, Long memberId) throws Exception;
}
