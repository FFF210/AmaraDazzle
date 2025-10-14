package dao.consumer;

import org.apache.ibatis.session.SqlSession;

import dto.Category;
import util.MybatisSqlSessionFactory;

public class CategoryDAOImpl implements CategoryDAO {

	@Override
	public Category selectCategoryByCategoryId(Long categoryId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.category.selectCategoryByCategoryId", categoryId);
		}
	}

}
