package service.admin;

import java.util.List;
import java.util.Map;

import dto.Coupon;

public interface CouponService {
	
	Integer pCouponCnt(Map<String, String> searchContent); // 쿠폰 발행 수 
	List<Coupon> pCouponAllList(int p_no); //쿠폰 발행 리스트 보기 
	List<Coupon> pCouponSearchList(Map<String, String> searchContent, int p_no); //검색된 발행쿠폰 리스트 
	int insertPublCoupon(Coupon pCoupon); // 쿠폰 발행 
	Coupon publCouponDetail(int num); //발행 쿠폰 내용 상세보기 
	Integer iCouponCnt(Map<String, String> searchContent);	//개별지급 쿠폰 전체 수
	List<Coupon> iCouponAllList(Integer p_no);	//개별지급 쿠폰 전체 목록 
	List<Coupon> iCouponSearchList(Map<String, String> searchContent, Integer p_no);	//개별지급 쿠폰 검색 목록
	int provisionCoupon(long couponId,String provisionGrade, String startDate, String reason);  //쿠폰 지급 

}
