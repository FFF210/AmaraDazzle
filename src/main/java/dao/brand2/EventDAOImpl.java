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
	/* eventList */

	// 이벤트 목록 조회
	@Override
	public List<EventList> selectEventList(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.event.selectEventList", params);
		}
	}

	// 이벤트 개수 조회
	@Override
	public Integer selectEventCount(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.event.selectEventCount", params);
		}
	}

	/* eventForm */

	// 1. 이벤트 신청 저장
	@Override
	public int insertEventApplication(EventApplication application) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
			return sqlSession.insert("mapper.eventApplication.insertEventApplication", application);
		}
	}

	// 2-1. 이벤트 상품 여러 개 저장
	@Override
	public int insertEventProducts(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
			return sqlSession.insert("mapper.eventApplication.insertEventProducts", params);
		}
	}
	
	// 2-2. 
	@Override
	public int updateProductsEvent(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
			return sqlSession.update("mapper.eventApplication.updateProductsEvent", params);
		}
	}

	// 3. 쿠폰 저장
	@Override
	public int insertCoupon(Coupon coupon) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
			return sqlSession.insert("mapper.eventApplication.insertCoupon", coupon);
		}
	}

	// 신청하기 버튼
	@Override
	public Event selectEventById(Long eventId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.event.selectEventById", eventId);
		}
	}

}