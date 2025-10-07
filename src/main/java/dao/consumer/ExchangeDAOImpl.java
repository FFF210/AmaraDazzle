package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Exchange;
import util.MybatisSqlSessionFactory;

public class ExchangeDAOImpl implements ExchangeDAO {

	// ================[소비자] 교환 신청 등록 ===================
	@Override
	public void insertExchange(Exchange exchange) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            sqlSession.insert("mapper.exchange.insertExchange", exchange);
            sqlSession.commit();
		}
	}

	// ================[소비자] 교환 목록 조회 (회원별) ===================
	@Override
	public List<Map<String, Object>> selectExchangeListByMemberId(Long memberId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectList("mapper.exchange.selectExchangeListByMemberId", memberId);
        }
	}

	// ================[소비자] 교환 상세 조회 ===================
	@Override
	public Map<String, Object> selectExchangeById(Long exchangeId) {
		 try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
		        return sqlSession.selectOne("mapper.exchange.selectExchangeById", exchangeId);
		    }
	}
	
	// ================[소비자] 주문 상품 상태 변경 ===================
	@Override
	public void updateOrderItemStatus(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            sqlSession.update("mapper.exchange.updateOrderItemStatus", params);
            sqlSession.commit();
        }
		
	}

	// ================[소비자] 특정 주문 상품의 교환 정보 조회 (중복 신청 체크) ===================
	@Override
	public Exchange selectExchangeByOrderItemId(Long orderItemId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectOne("mapper.exchange.selectExchangeByOrderItemId", orderItemId);
        }
	}

}
