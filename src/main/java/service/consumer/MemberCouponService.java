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
	
	/**
	 * 쿠폰 사용 가능 여부 체크 및 최소 금액 검증
	 * @param memberId 회원 ID
	 * @param memberCouponId 회원 쿠폰 ID
	 * @param orderAmount 주문 금액
	 * @return 사용 가능하면 쿠폰 정보, 불가하면 null
	 */
	Map<String, Object> validateCoupon(Long memberId, Long memberCouponId, int orderAmount) throws Exception;

	/**
	 * 쿠폰 사용 처리
	 */
	boolean applyCoupon(Long memberId, Long memberCouponId, Long orderId) throws Exception;
	}
