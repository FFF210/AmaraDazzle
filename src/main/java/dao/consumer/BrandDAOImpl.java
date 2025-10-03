package dao.consumer;

import org.apache.ibatis.session.SqlSession;

import dto.Brand;
import util.MybatisSqlSessionFactory;

public class BrandDAOImpl implements BrandDAO {

	private SqlSession sqlSession;

	public BrandDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	//브랜드 아이디로 브랜드 조회
	@Override
	public Brand selectBrandByBrandId(Long brandId) throws Exception {
		return sqlSession.selectOne("mapper.brand.selectBrandByBrandId", brandId);
	}

	//브랜드 팔로워수 세기
	@Override
	public int countBrandFollowers(Long brandId) {
		return sqlSession.selectOne("mapper.brandFollow.countBrandFollowers", brandId);
	}

}
