package dao.consumer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Qna;
import util.MybatisSqlSessionFactory;

public class QnaDAOImpl implements QnaDAO {

	private SqlSession sqlSession;

	public QnaDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	@Override
	public List<Qna> selectQnasByProductId(Long productId) throws Exception {
		return sqlSession.selectList("mapper.qna.selectQnasByProductId", productId);
	}

	@Override
	public Integer getQnaCountByProductId(Long productId) throws Exception {
		Integer count = sqlSession.selectOne("mapper.qna.getQnaCountByProductId", productId);
        return count != null ? count : 0;
	}

}
