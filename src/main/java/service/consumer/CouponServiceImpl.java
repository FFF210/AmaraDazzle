package service.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.CouponDAO;
import dao.consumer.CouponDAOImpl;
import dto.consumer.CouponList;

public class CouponServiceImpl implements CouponService {
	private CouponDAO couponDAO;

	public CouponServiceImpl() {
		this.couponDAO = new CouponDAOImpl();
	}

	// ======================= [소비자] 다운 가능한 쿠폰 목록 조회 =======================
	@Override
	public List<CouponList> getCounponList(Map<String, Object> params) throws Exception {
		return couponDAO.selectAvailableCoupons(params);
	}

	// ======================= [소비자] 쿠폰 다운로드 =======================
	@Override
	public void downloadCoupon(Long couponId, Long memberId) throws Exception {
		// coupon_limit 감소
		couponDAO.decreaseCouponLimit(couponId);

		Map<String, Object> params = new HashMap<>();
		params.put("couponId", couponId);
		params.put("memberId", memberId);

		couponDAO.insertMemberCoupon(params);
	}
}
