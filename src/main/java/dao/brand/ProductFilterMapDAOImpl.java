package dao.brand;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import util.MybatisSqlSessionFactory;

public class ProductFilterMapDAOImpl implements ProductFilterMapDAO {

	// 필터 매핑 등록
	@Override
	public void insertProductFilter(Long productId, Long filterId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("productId", productId);
			param.put("filterId", filterId);

			sqlSession.insert("mapper.productFilterMap.insertProductFilter", param);
			sqlSession.commit();
		}
	}

	// 특정 상품의 필터 매핑 삭제
	@Override
	public void deleteProductFilters(Long productId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.delete("mapper.productFilterMap.deleteProductFilters", productId);
			sqlSession.commit();
		}
	}

}
