package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand.MemberQnaList;
import util.MybatisSqlSessionFactory;

public class MemberQnaDAOImpl implements MemberQnaDAO {

	// 고객 문의 목록 조회
	@Override
	public List<MemberQnaList> selectMemberQnaListForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.qna.selectMemberQnaListForBrand", params);
		}
	}

	// 고객 문의 개수 조회
	@Override
	public Integer selectMemberQnaCountForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.qna.selectMemberQnaCountForBrand", params);
		}
	}

	// 고객 문의 상세 조회
	@Override
	public MemberQnaList selectMemberQnaDetail(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.qna.selectMemberQnaDetail", params);
		}
	}

	// 고객 문의 업데이트
	@Override
	public void updateMemberQnaAnswer(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.update("mapper.qna.updateMemberQnaAnswer", params);
			sqlSession.commit();
		}
	}

}
