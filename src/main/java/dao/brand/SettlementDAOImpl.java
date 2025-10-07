package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Settlement;
import dto.brand.SettlementDonut;
import dto.brand.SettlementSummary;
import dto.brand.SettlementTrend;
import util.MybatisSqlSessionFactory;

public class SettlementDAOImpl implements SettlementDAO {

	// 정산 목록 조회
	@Override
	public List<Settlement> selectSettlementListForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.settlement.selectSettlementListForBrand", params);
		}
	}

	// 정산 목록 개수 조회
	@Override
	public Integer selectSettlementCountForBrand(Long brandId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.settlement.selectSettlementCountForBrand", brandId);
		}
	}

	// 정산 요약 조회
	@Override
	public SettlementSummary getSettlementSummary(Long brandId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.settlement.getSettlementSummary", brandId);
		}
	}

	// 매출 도넛
	@Override
	public SettlementDonut getDonutChartData(Long brandId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.settlement.getDonutChartData", brandId);
		}
	}

	// 월 단위 정산 금액 추이
	@Override
	public List<SettlementTrend> getMonthlyTrend(Long brandId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.settlement.getMonthlyTrend", brandId);
		}
	}

}
