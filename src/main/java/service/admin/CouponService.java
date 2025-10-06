package service.admin;

import java.util.List;
import java.util.Map;

import dto.Coupon;

public interface CouponService {
	
	Integer pCouponCnt(Map<String, String> searchContent); // 쿠폰 발행 수 
	List<Coupon> pCouponAllList(int p_no); //쿠폰 발행 리스트 보기 
	List<Coupon> pCouponSearchList(Map<String, String> searchContent, int p_no); //검색된 발행쿠폰 리스트 
	int insertPublCoupon(Coupon pCoupon); // 쿠폰 발행 

}
