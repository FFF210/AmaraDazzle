package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Coupon;
import dto.Event;
import dto.EventApplication;
import dto.brand2.EventDetail;
import dto.brand2.EventList;
import util.MybatisSqlSessionFactory;

public class EventDAOImpl implements EventDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	/* eventList */

	// 이벤트 목록 조회
	@Override
	public List<EventList> selectEventList(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.event.selectEventList", params);
	}

	// 이벤트 개수 조회
	@Override
	public Integer selectEventCount(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.event.selectEventCount", params);
	}

	/* eventForm */

	// 1. 이벤트 신청 저장
	@Override
	public void insertEventApplication(EventApplication application) throws Exception {
		sqlSession.insert("mapper.eventApplication.insertEventApplication", application);
		sqlSession.commit();
	}

	// 2-1. 이벤트 상품 여러 개 저장
	@Override
	public void insertEventProducts(Map<String, Object> params) throws Exception {
		sqlSession.insert("mapper.eventApplication.insertEventProducts", params);
		sqlSession.commit();
	}

	// 2-2.
	@Override
	public void updateProductsEvent(Map<String, Object> params) throws Exception {
		sqlSession.update("mapper.eventApplication.updateProductsEvent", params);
		sqlSession.commit();
	}

	// 3. 쿠폰 저장
	@Override
	public int insertCoupon(Coupon coupon) throws Exception {
		return sqlSession.insert("mapper.eventApplication.insertCoupon", coupon);
	}

	// 신청하기 버튼
	@Override
	public Event selectEventById(Long eventId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.event.selectEventById", eventId);
		}
	}

	// 이벤트 종료 시 product테이블에서 event_id 삭제 (1개만 들어갈 수 있기 때문에..)
	@Override
	public void resetProductsForEvent(Long eventId) throws Exception {
		sqlSession.update("mapper.event.resetProductsForEvent", eventId);
		sqlSession.commit();
	}

	// 이벤트 상세보기 버튼
	@Override
	public EventDetail selectEventDetailById(Long eventId) throws Exception {
		return sqlSession.selectOne("mapper.event.selectEventDetailById", eventId);
	}

}