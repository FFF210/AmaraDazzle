package service.consumer;

import java.util.List;
import java.util.Map;

public interface MemberCouponService {
	/**
	 * 회원의 사용 가능한 쿠폰 개수 조회
	 * @param memberId 회원 ID
	 * @return 사용 가능한 쿠폰 개수
	 */
	int getAvailableCouponCount(Long memberId) throws Exception;

	/**
	 * 회원의 쿠폰 목록 조회
	 * @param memberId 회원 ID
	 * @return 쿠폰 목록
	 */
	Map<String, Object> getMemberCouponList(Long memberId, int page, int pageSize) throws Exception;
	}
