package dao.admin;

import java.util.List;
import java.util.Map;

import dto.Coupon;
import dto.admin.SearchConditionDTO;

public interface CouponDAO {
	
	Integer pCouponCnt(SearchConditionDTO sc_DTO); //쿠폰 발행 수 
	List<Coupon> pCouponAllList(Map<String, Object> listMap); //쿠폰 발행 리스트 보기 
	List<Coupon> pCouponSearchList(SearchConditionDTO sc_DTO); //검색된 발행쿠폰 리스트

}
