package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Coupon;
import dto.Event;
import dto.EventApplication;
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

	// 이벤트 신청
	@Override
	public int insertEventApplication(EventApplication application) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.insert("mapper.eventApplication.insertEventApplication", application);
		}
	}

	@Override
	public int insertEventProducts(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.insert("mapper.eventApplication.insertEventProducts", params);
		}
	}

	@Override
	public int insertCoupon(Coupon coupon) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.insert("mapper.eventApplication.insertCoupon", coupon);
		}
	}

	// 이벤트 종류
	@Override
	public List<String> selectEventTypes() {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.event.selectEventTypes");
		}
	}

	// 이벤트명
	@Override
	public List<Event> selectEventNamesByType(String type) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectList("mapper.event.selectEventNamesByType", type);
		}
	}
	
}