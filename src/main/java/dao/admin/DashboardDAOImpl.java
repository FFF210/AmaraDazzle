package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import util.MybatisSqlSessionFactory;

public class DashboardDAOImpl implements DashboardDAO {
	private SqlSessionFactory factory = MybatisSqlSessionFactory.getSqlSessionFactory();
	
	//당일 총 주문건수 
	@Override
	public Map<String, Object> orderCntByPeriod() {
		SqlSession ss = factory.openSession();
		try {
			return ss.selectOne("mapper.adminMain.orderCntByPeriod");
			
		} finally {
			ss.close();
		}
	}

	//가입자수
	@Override
	public Map<String, Object> memberCntByPeriod() {
		SqlSession ss = factory.openSession();
		try {
			return ss.selectOne("mapper.adminMain.memberCntByPeriod");
			
		} finally {
			ss.close();
		}
	}
	
	//베스트셀러 TOP5
	@Override
	public List<Map<String, Object>> bestSellerTop5() {
		SqlSession ss = factory.openSession();
		try {
			return ss.selectList("mapper.adminMain.bestSellerTop5");
			
		} finally {
			ss.close();
		}
	}



	
}
