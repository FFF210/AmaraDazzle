package dao.consumer;

import org.apache.ibatis.session.SqlSession;

import dto.Brand;
import util.MybatisSqlSessionFactory;

public class BrandDAOImpl implements BrandDAO {

	private SqlSession sqlSession;

	public BrandDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	@Override
	public Brand selectBrandByBrandId(Long brandId) throws Exception {
		return sqlSession.selectOne("mapper.brand.selectBrandByBrandId", brandId);
	}

}
