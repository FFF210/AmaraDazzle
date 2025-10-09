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
		return sqlSession.selectOne("mapper.orderItem.selectSalesToday", brandId);
	}

	@Override
	public OrdersDashboard selectSalesYesterday(Long brandId) {
		return sqlSession.selectOne("mapper.orderItem.selectSalesYesterday", brandId);
	}

	@Override
	public OrdersDashboard selectSalesWeek(Long brandId) {
		return sqlSession.selectOne("mapper.orderItem.selectSalesWeek", brandId);
	}

	@Override
	public List<OrdersDashboard> selectSalesLast30Days(Long brandId) {
		return sqlSession.selectList("mapper.orderItem.selectSalesLast30Days", brandId);
	}
	
	@Override
    public List<OrdersDashboard> selectMonthlySalesCompare(Long brandId) {
        return sqlSession.selectList("mapper.orderItem.selectMonthlySalesCompare", brandId);
    }
	
	// jsp에서 % than last month 부분
	@Override
	public Long selectTotalSales(Long brandId) {
	    return sqlSession.selectOne("mapper.orderItem.selectTotalSales", brandId);
	}

	@Override
	public Long selectLastMonthSales(Long brandId) {
	    return sqlSession.selectOne("mapper.orderItem.selectLastMonthSales", brandId);
	}
}
