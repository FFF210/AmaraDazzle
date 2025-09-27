package dao.consumer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.ProductOption;
import util.MybatisSqlSessionFactory;

public class ProductOptionDAOImpl implements ProductOptionDAO {
	
private SqlSession sqlSession;
    
    public ProductOptionDAOImpl() {
        sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
    }

	@Override
	public List<ProductOption> selectProductOptionsByProductId(Long productId) throws Exception {
		return sqlSession.selectList("mapper.productOption.selectProductOptionsByProductId", productId);
	}

}
