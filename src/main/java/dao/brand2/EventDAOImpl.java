package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Coupon;
import dto.EventApplication;
import dto.brand2.EventDetail;
import dto.brand2.EventList;
import util.MybatisSqlSessionFactory;

public class EventDAOImpl implements EventDAO {

	/* eventList */

	// 이벤트 목록 조회
	@Override
	public List<EventList> selectEventList(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
		return sqlSession.selectList("mapper.event.selectEventList", params);
		}
	}

	// 이벤트 개수 조회
	@Override
	public Integer selectEventCount(Map<String, Object> params) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
		return sqlSession.selectOne("mapper.event.selectEventCount", params);
		}
	}

	/* eventForm */
	/* < selectEventById, selectAvailableProducts(->ProductDAO) >, insertEventApplication, updateProductsEvent */
	// ========== event ==========
	
	// 신청하기 버튼
    @Override
    public EventDetail selectEventById(Long eventId) throws Exception {
        try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
    	return sqlSession.selectOne("mapper.event.selectEventById", eventId);
        }
    }
    
    // 상세보기 버튼
    @Override
    public EventDetail selectEventDetailById(Map<String, Object> params) throws Exception {
        try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
    	return sqlSession.selectOne("mapper.event.selectEventDetailById", params);
        }
    }

    // 취소하기 버튼 (product.eventId 삭제)
    @Override
    public void resetProductsForEvent(Long eventId) throws Exception {
        try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
    	sqlSession.update("mapper.event.resetProductsForEvent", eventId);
        sqlSession.commit();
        }
    }
    
    
    // 이벤트 신청 시 상품 연결
    /* Product.xml의 updateProductForEvent = event_application.xml의 updateProductsEvent
    @Override
	public void updateProductForEvent(Map<String, Object> params) throws Exception {
    	try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            sqlSession.update("mapper.product.updateProductForEvent", params); // product.xml 사용
            sqlSession.commit();
        }
	}
	*/

	// ========== event_application ==========
    // 이벤트 신청 저장
    @Override
    public void insertEventApplication(EventApplication application) throws Exception {
        try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
        	sqlSession.insert("mapper.eventApplication.insertEventApplication", application);
        	sqlSession.commit();
        }
    }
    // product update
    @Override
    public void updateProductsEvent(Map<String, Object> params) throws Exception {
        try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
    	sqlSession.update("mapper.eventApplication.updateProductsEvent", params);
        sqlSession.commit();
        }
    }

    // 취소하기 버튼
    @Override
    public void deleteEventApplication(Long eventApplicationId) throws Exception {
        try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
    	sqlSession.delete("mapper.eventApplication.deleteEventApplication", eventApplicationId);
        sqlSession.commit();
        }
    }

    // ========== coupon ==========
    @Override
    public List<Coupon> selectCouponsForEvent(Map<String, Object> params) throws Exception {
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectList("mapper.coupon.selectCouponsForEvent", params);
        }
    }
}