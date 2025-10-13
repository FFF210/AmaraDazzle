package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import util.MybatisSqlSessionFactory;

public class BrandFollowDAOImpl implements BrandFollowDAO {

	// ================[소비자] 브랜드 팔로우 ===================
	@Override
	public void insertBrandFollow(Map<String, Object> params) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.insert("mapper.brandFollow.insertBrandFollow", params);
			session.commit();
		}
	}

	// ================[소비자] 이미 팔로우한 브랜드인지 확인 ===================
	@Override
	public int existsBrandFollow(Map<String, Object> params) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.brandFollow.existsBrandFollow", params);
		}
	}

	// ================[소비자] 브랜드 팔로우 취소 ===================
	@Override
	public void deleteBrandFollow(Map<String, Object> params) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.delete("mapper.brandFollow.deleteBrandFollow", params);
			session.commit();
		}
	}

	// ================[소비자] 팔로우 브랜드 목록 조회 ===================
	@Override
	public List<Map<String, Object>> selectBrandFollowByMemberId(Long memberId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectList("mapper.brandFollow.selectBrandFollowByMemberId", memberId);
		}
	}

	// ================[소비자] 팔로우 브랜드 개수 조회 ===================
	@Override
	public int countBrandFollowByMemberId(Long memberId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.brandFollow.countBrandFollowByMemberId", memberId);
		}
	}

}
