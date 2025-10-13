package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.MemberCoupon;

public interface MemberCouponDAO {

	//회원의 사용 가능한 쿠폰 개수 조회
    int getAvailableCouponCount (Long memberId) throws Exception;
    
    // 총 쿠폰 개수 조회 (페이징용)
    int countMemberCouponList(Long memberId) throws Exception;
    
     //회원의 쿠폰 목록 조회 (최근순)
    List<Map<String, Object>> selectMemberCouponList(Map<String, Object> params) throws Exception;
    
    //사용한 쿠폰 정보 조회
    Map<String, Object> getCouponInfoByMemberCouponId(Long memberCouponId) throws Exception;
    
    /**
     * 쿠폰 사용 가능 여부 체크 (조건 포함)
     * @param memberId 회원 ID
     * @param memberCouponId 회원 쿠폰 ID
     * @return 쿠폰 정보 (사용 불가하면 null)
     */
    Map<String, Object> checkCouponAvailable(Long memberId, Long memberCouponId) throws Exception;

    //쿠폰 사용 처리
    boolean useCoupon(Long memberId, Long memberCouponId, Long orderId) throws Exception;
    
    //회원가입 축하 쿠폰 ID 조회
    Long getWelcomeCouponId() throws Exception;
    
    //회원가입 축하 쿠폰 발급
    void issueCoupon(Long memberId, Long couponId) throws Exception;    
}


