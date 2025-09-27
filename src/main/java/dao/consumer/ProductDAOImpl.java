package dao.consumer;

import org.apache.ibatis.session.SqlSession;

import dto.Product;
import util.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO {

	private SqlSession sqlSession;

	public ProductDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	@Override
	public Product selectProductByProductId(Long productId) throws Exception {
		return sqlSession.selectOne("mapper.product.selectProductByProductId", productId);
	}

}
