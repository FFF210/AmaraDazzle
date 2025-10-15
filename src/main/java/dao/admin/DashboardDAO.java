package dao.admin;

import java.util.List;
import java.util.Map;

public interface DashboardDAO {

	Map<String, Object> orderCntByPeriod();	//기간별 총 주문건수 
	Map<String, Object> memberCntByPeriod();//가입자수
	List<Map<String, Object>> bestSellerTop5();//베스트셀러 TOP5

}
