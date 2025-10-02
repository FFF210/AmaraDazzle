package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import util.MybatisSqlSessionFactory;

public class BrandFollowDAOImpl implements BrandFollowDAO {

	private SqlSession sqlSession;

	public BrandFollowDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	// ================[소비자] 브랜드 팔로우 ===================
	@Override
	public void insertBrandFollow(Map<String, Object> params) throws Exception {
		sqlSession.insert("mapper.brandfollow.insertBrandFollow", params);
		sqlSession.commit();

	}

	// ================[소비자] 이미 팔로우한 브랜드인지 확인 ===================
	@Override
	public int existsBrandFollow(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.brandfollow.existsBrandFollow", params);
	}

	// ================[소비자] 브랜드 팔로우 취소 ===================
	@Override
	public void deleteBrandFollow(Map<String, Object> params) throws Exception {
		sqlSession.delete("mapper.brandfollow.deleteBrandFollow", params);
		sqlSession.commit();
	}

	// ================[소비자] 팔로우 브랜드 목록 조회 ===================
	@Override
	public List<Map<String, Object>> selectBrandFollowByMemberId(Long memberId) throws Exception {
		 return sqlSession.selectList("mapper.brandfollow.selectBrandFollowByMemberId", memberId);
	}

	// ================[소비자] 팔로우 브랜드 개수 조회 ===================
	@Override
	public int countBrandFollowByMemberId(Long memberId) throws Exception {
		 return sqlSession.selectOne("mapper.brandfollow.countBrandFollowByMemberId", memberId);
	}

}
