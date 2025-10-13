package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.MemberCoupon;

public interface MemberCouponDAO {
	/**
     * 회원의 사용 가능한 쿠폰 개수 조회
     * @param memberId 회원 ID
     * @return 사용 가능한 쿠폰 개수
     */
    int getAvailableCouponCount (Long memberId) throws Exception;
    
    // 총 쿠폰 개수 조회 (페이징용)
    int countMemberCouponList(Long memberId) throws Exception;
    
    /**
     * 회원의 쿠폰 목록 조회 (최근순)
     * @param memberId 회원 ID
     * @return 쿠폰 목록
     */
    List<Map<String, Object>> selectMemberCouponList(Map<String, Object> params) throws Exception;
    
    /**
     * 사용한 쿠폰 정보 조회
     * @param memberCouponId 회원 쿠폰 ID
     * @return 쿠폰 정보 (쿠폰명, 할인금액)
     */
    Map<String, Object> getCouponInfoByMemberCouponId(Long memberCouponId) throws Exception;
    
    //회원가입 축하 쿠폰 ID 조회
    Long getWelcomeCouponId() throws Exception;
    
    //회원가입 축하 쿠폰 발급
    void issueCoupon(Long memberId, Long couponId) throws Exception;
    
    
}


