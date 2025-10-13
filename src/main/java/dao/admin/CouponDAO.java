package dao.admin;

import java.util.List;
import java.util.Map;

import dto.Coupon;
import dto.admin.SearchConditionDTO;

public interface CouponDAO {
	
	Integer pCouponCnt(SearchConditionDTO sc_DTO); //쿠폰 발행 수 
	List<Coupon> pCouponAllList(Map<String, Object> listMap); //쿠폰 발행 리스트 보기 
	List<Coupon> pCouponSearchList(SearchConditionDTO sc_DTO); //검색된 발행쿠폰 리스트
	int insertPublCoupon(Coupon pCoupon); //쿠폰 발행
	Coupon publCouponDetail(int num); //발행쿠폰 상세보기
	Integer iCouponCnt(SearchConditionDTO sc_DTO);	//개별지급 쿠폰 전체 수 
	List<Coupon> iCouponAllList(Map<String, Object> listMap);	//개별지급 쿠폰 전체 목록 
	List<Coupon> iCouponSearchList(SearchConditionDTO sc_DTO);	//개별지급 쿠폰 검색 목록
	int provisionCoupon(Map<String, Object> map); //쿠폰 지급 

}
