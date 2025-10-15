package service.admin;

import java.util.List;
import java.util.Map;

import dao.admin.DashboardDAO;
import dao.admin.DashboardDAOImpl;

public class DashboardServiceImpl implements DashboardService{
	private DashboardDAO dash_dao;

	public DashboardServiceImpl() {
		dash_dao = new DashboardDAOImpl();
	}
	
	Map<String, String> map = null;

	//기간별 총 주문건수 
	@Override
	public Map<String, Object> orderCntByPeriod() {
		return dash_dao.orderCntByPeriod();
	}

	//가입자수
	@Override
	public Map<String, Object> memberCntByPeriod() {
		return dash_dao.memberCntByPeriod();
	}
	
	//베스트셀러 TOP5
	@Override
	public List<Map<String, Object>> bestSellerTop5() {
		return dash_dao.bestSellerTop5();
	}


}
