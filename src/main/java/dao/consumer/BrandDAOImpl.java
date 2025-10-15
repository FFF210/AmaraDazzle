package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Brand;
import dto.consumer.BrandSearchResult;
import dto.consumer.MembershipBrand;
import util.MybatisSqlSessionFactory;

public class BrandDAOImpl implements BrandDAO {

	// 브랜드 아이디로 브랜드 조회
	@Override
	public Brand selectBrandByBrandId(Long brandId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.brand.selectBrandByBrandId", brandId);
		}
	}
	
	// 브랜드의 진행 중인 이벤트 조회
	@Override
	public List<Map<String, Object>> selectEventsByBrandId(Long brandId) throws Exception {
	    try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return session.selectList("mapper.event.selectEventsByBrandId", brandId);
	    }
	}

	// 브랜드 팔로워수 세기
	@Override
	public int countBrandFollowers(Long brandId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.brandFollow.countBrandFollowers", brandId);
		}
	}

	// <!-- ================[소비자] 멤버십 가입 브랜드 조회 =================== -->
	@Override
	public List<MembershipBrand> selectActiveMembershipBrands(Integer limit) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.brand.selectActiveMembershipBrands", limit);
		}
	}

	// ======================= [소비자] 검색 페이지 - 브랜드 검색 =======================
	@Override
	public List<BrandSearchResult> searchBrandListForConsumer(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.brand.searchBrandListForConsumer", params);
		}
	}

}
