package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand2.SalesOverview;
import util.MybatisSqlSessionFactory;

public class SalesOverviewDAOImpl implements SalesOverviewDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	// 카테고리별 매출 추이 조회
	@Override
	public List<SalesOverview> selectCategorySalesTrend(Map<String, Object> params) {
		return sqlSession.selectList("mapper.orderItem.selectCategorySalesTrend", params);
	}

}
