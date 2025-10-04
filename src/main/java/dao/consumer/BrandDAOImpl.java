package dao.consumer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Brand;
import dto.consumer.MembershipBrand;
import util.MybatisSqlSessionFactory;

public class BrandDAOImpl implements BrandDAO {

	private SqlSession sqlSession;

	public BrandDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	// 브랜드 아이디로 브랜드 조회
	@Override
	public Brand selectBrandByBrandId(Long brandId) throws Exception {
		return sqlSession.selectOne("mapper.brand.selectBrandByBrandId", brandId);
	}

	// 브랜드 팔로워수 세기
	@Override
	public int countBrandFollowers(Long brandId) {
		return sqlSession.selectOne("mapper.brandFollow.countBrandFollowers", brandId);
	}

	// <!-- ================[소비자] 멤버십 가입 브랜드 조회 =================== -->
	@Override
	public List<MembershipBrand> selectActiveMembershipBrands(Integer limit) {
		return sqlSession.selectList("mapper.brand.selectActiveMembershipBrands", limit);
	}

}
