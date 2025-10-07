package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Returns;
import util.MybatisSqlSessionFactory;

public class ReturnDAOImpl implements ReturnDAO {
	
	// ================[소비자] 반품 신청 등록 ===================
	@Override
	public void insertReturns(Returns returns) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            sqlSession.insert("mapper.returns.insertReturns", returns);
            sqlSession.commit();
        }		
	}

	// ================[소비자] 반품 목록 조회 (회원별) ===================
	@Override
	public List<Map<String, Object>> selectReturnsListByMemberId(Long memberId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectList("mapper.returns.selectReturnsListByMemberId", memberId);
        }
	}

	// ================[소비자] 반품 상세 조회 ===================
	@Override
	public Returns selectReturnsById(Long returnsId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectOne("mapper.returns.selectReturnsById", returnsId);
        }
	}

	// ================[소비자] 주문 상품 상태 변경 ===================
	@Override
	public void updateOrderItemStatus(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            sqlSession.update("mapper.returns.updateOrderItemStatus", params);
            sqlSession.commit();
        }
		
	}

	 // ================[소비자] 특정 주문 상품의 반품 정보 조회 (중복 신청 체크) ===================
    @Override
	public Returns selectReturnsByOrderItemId(Long orderItemId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectOne("mapper.returns.selectReturnsByOrderItemId", orderItemId);
        }
	}

}
