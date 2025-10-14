package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Qna;
import util.MybatisSqlSessionFactory;

public class QnaDAOImpl implements QnaDAO {
	 
    // 상품ID별 문의 조회
    @Override
    public List<Qna> selectQnasByProductId(Long productId) throws Exception {
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectList("mapper.qna.selectQnasByProductId", productId);
        }
    }
    
 // 페이지네이션용 문의 목록 조회
 	@Override
 	public List<Map<String, Object>> selectQnasByProductIdWithPaging(Map<String, Object> params) throws Exception {
 	    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
 	        return sqlSession.selectList("mapper.qna.selectQnasByProductId", params);
 	    }
 	}
    
    // 문의 개수
    @Override
    public Integer getQnaCountByProductId(Long productId) throws Exception {
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Integer count = sqlSession.selectOne("mapper.qna.getQnaCountByProductId", productId);
            return count != null ? count : 0;
        }
    }
    
    // 문의 등록
    @Override
    public void insertQna(Qna qna) throws Exception {
        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            sqlSession.insert("mapper.qna.insertQna", qna);
            sqlSession.commit();
        }
    }
}
