package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand2.OrdersDashboard;
import util.MybatisSqlSessionFactory;

public class OrderDashboardDAOImpl implements OrderDashboardDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	@Override
	public OrdersDashboard selectSalesToday(Long brandId) {
		return sqlSession.selectOne("mapper.orders.selectSalesToday");
	}

	@Override
	public OrdersDashboard selectSalesYesterday(Long brandId) {
		return sqlSession.selectOne("mapper.orders.selectSalesYesterday");
	}

	@Override
	public OrdersDashboard selectSalesWeek(Long brandId) {
		return sqlSession.selectOne("mapper.orders.selectSalesWeek");
	}

	@Override
	public List<OrdersDashboard> selectSalesLast30Days(Long brandId) {
		return sqlSession.selectList("mapper.orders.selectSalesLast30Days");
	}
	
	@Override
    public List<OrdersDashboard> selectMonthlySalesCompare(Long brandId) {
        return sqlSession.selectList("mapper.orders.selectMonthlySalesCompare", brandId);
    }
}
