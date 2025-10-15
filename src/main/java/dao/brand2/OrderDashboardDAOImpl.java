package dao.brand2;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.brand2.OrdersDashboard;
import util.MybatisSqlSessionFactory;

public class OrderDashboardDAOImpl implements OrderDashboardDAO {

	@Override
	public OrdersDashboard selectSalesToday(Long brandId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orderItem.selectSalesToday", brandId);
		}
	}

	@Override
	public OrdersDashboard selectSalesYesterday(Long brandId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orderItem.selectSalesYesterday", brandId);
		}
	}

	@Override
	public OrdersDashboard selectSalesWeek(Long brandId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orderItem.selectSalesWeek", brandId);
		}
	}

	@Override
	public List<OrdersDashboard> selectSalesLast30Days(Long brandId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orderItem.selectSalesLast30Days", brandId);
		}
	}

	@Override
	public List<OrdersDashboard> selectMonthlySalesCompare(Long brandId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orderItem.selectMonthlySalesCompare", brandId);
		}
	}

	// jsp에서 % than last month 부분
	@Override
	public Long selectTotalSales(Long brandId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orderItem.selectTotalSales", brandId);
		}
	}

	@Override
	public Long selectLastMonthSales(Long brandId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orderItem.selectLastMonthSales", brandId);
		}
	}
}
