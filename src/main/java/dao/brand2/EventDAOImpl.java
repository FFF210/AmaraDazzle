package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand2.EventList;
import util.MybatisSqlSessionFactory;

public class EventDAOImpl implements EventDAO {

	// 이벤트 목록 조회
	@Override
	public List<EventList> selectEventList(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.event.selectEventList", params);
		}
	}
}