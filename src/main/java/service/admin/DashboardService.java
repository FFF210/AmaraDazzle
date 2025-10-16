package service.admin;

import java.util.List;
import java.util.Map;

public interface DashboardService {

	Map<String, Object> orderCntByPeriod();	//주문건수 
	Map<String, Object> memberCntByPeriod(); //가입자수
	List<Map<String, Object>> bestSellerTop5(); //베스트셀러 TOP5
	List<Map<String, Object>> bestBrandTop5(); //베스트브랜드 TOP5
	List<Map<String, Object>> selectCategoryRatio(); //판매상품 카테고리별 비율
	List<Map<String, Object>> selectSkinRatio(); // 고객 피부타입별 비율
}
