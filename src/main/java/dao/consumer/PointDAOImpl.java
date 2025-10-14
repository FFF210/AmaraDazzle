package dao.consumer;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Point;
import util.MybatisSqlSessionFactory;

public class PointDAOImpl implements PointDAO {

	private SqlSession sqlSession;

	public PointDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	// 포인트 내역 개수 조회 (전체)(페이징용)
	@Override
	public int countPointHistory(Long memberId) throws Exception {
		Integer count = sqlSession.selectOne("mapper.point.countPointHistory", memberId);
		return count != null ? count : 0;
	}

	// 회원의 포인트 내역 조회 (최근순)
	@Override
	public List<Map<String, Object>> selectPointHistory(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.point.selectPointHistory", params);
	}

	// 포인트 내역 개수 조회 (기간별)(페이징용)
	@Override
	public int countPointHistoryByPeriod(Map<String, Object> params) throws Exception {
		Integer count = sqlSession.selectOne("mapper.point.countPointHistoryByPeriod", params);
		return count != null ? count : 0;
	}

	// 특정 기간의 포인트 내역 조회
	@Override
	public List<Map<String, Object>> selectPointHistoryByPeriod(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.point.selectPointHistoryByPeriod", params);
	}

}
