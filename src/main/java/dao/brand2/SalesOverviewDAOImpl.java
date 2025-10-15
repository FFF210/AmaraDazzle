package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand2.SalesOverview;
import dto.brand2.SalesStatusRow;
import util.MybatisSqlSessionFactory;

public class SalesOverviewDAOImpl implements SalesOverviewDAO {

	// 카테고리별 매출 추이 조회
	@Override
	public List<SalesOverview> selectCategorySalesTrend(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orderItem.selectCategorySalesTrend", params);
		}
	}

	// ================== 테이블용 (날짜별 pivot) ==================
	@Override
	public List<SalesStatusRow> selectSalesStatusRows(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orderItem.selectSalesStatusRows", params);
		}
	}
}
