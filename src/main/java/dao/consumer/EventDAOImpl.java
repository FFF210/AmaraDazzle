package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Event;
import dto.consumer.EventDetail;
import dto.consumer.EventDetailProduct;
import util.MybatisSqlSessionFactory;

public class EventDAOImpl implements EventDAO {

	// 이벤트 목록 조회
	@Override
	public List<Event> selectEventListForConsumer(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.event.selectEventListForConsumer", params);
		}
	}

	// 이벤트 목록 개수
	@Override
	public Integer selectEventCountForConsumer(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.event.selectEventCountForConsumer", params);
		}
	}

	// 이벤트 상세 조회
	@Override
	public EventDetail selectEventDetail(Long eventId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.event.selectEventDetail", eventId);
		}
	}

	// 이벤트 참여 상품 조회
	@Override
	public List<EventDetailProduct> selectEventDetailProducts(Long eventId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.event.selectEventDetailProducts", eventId);
		}
	}
}
