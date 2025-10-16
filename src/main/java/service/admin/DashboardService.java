package service.admin;

import java.util.List;
import java.util.Map;

public interface DashboardService {

	Map<String, Object> orderCntByPeriod();	//주문건수 
	Map<String, Object> memberCntByPeriod(); //가입자수
	List<Map<String, Object>> bestSellerTop5(); //베스트셀러 TOP5

}
