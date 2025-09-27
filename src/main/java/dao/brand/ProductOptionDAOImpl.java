package dao.brand;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.ProductOption;
import util.MybatisSqlSessionFactory;

public class ProductOptionDAOImpl implements ProductOptionDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true);

	// 옵션 등록
	@Override
	public void insertOption(ProductOption option) throws Exception {
		sqlSession.insert("mapper.productOption.insertOption", option);
		sqlSession.commit();
	}

	// 특정 상품 옵션 목록
	@Override
	public List<ProductOption> selectOptionsByProductId(String productId) throws Exception {
		return sqlSession.selectList("mapper.productOption.selectOptionsByProductId", productId);
	}

	// 특정 상품 옵션 삭제
	@Override
	public void deleteOption(Long productId) throws Exception {
		sqlSession.delete("mapper.productOption.deleteOption", productId);
	}
}
