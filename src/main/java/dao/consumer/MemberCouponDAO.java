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
    int getAvailableCouponCount (Long memberId) throws Exception ;
    
    /**
     * 회원의 쿠폰 목록 조회 (최근순)
     * @param memberId 회원 ID
     * @return 쿠폰 목록
     */
    List<Map<String, Object>> selectMemberCouponList(Long memberId) throws Exception;}
