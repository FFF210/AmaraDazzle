package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Settlement;
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

}
