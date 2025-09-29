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

	// 회원의 포인트 내역 조회 (최근순)
	@Override
	public List<Point> selectPointHistory(Long memberId) throws Exception {
		return sqlSession.selectList("mapper.point.selectPointHistory", memberId);
	}

	//특정 기간의 포인트 내역 조회
	@Override
	public List<Point> selectPointHistoryByPeriod(Long memberId, Timestamp startDate, Timestamp endDate)
			throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("startDate", startDate);
		params.put("endDate", endDate);

		return sqlSession.selectList("mapper.point.selectPointHistoryByPeriod", params);
	}

}
