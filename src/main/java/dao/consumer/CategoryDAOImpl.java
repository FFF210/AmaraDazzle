package dao.consumer;

import org.apache.ibatis.session.SqlSession;

import dto.Category;
import util.MybatisSqlSessionFactory;

public class CategoryDAOImpl implements CategoryDAO {

	private SqlSession sqlSession;

	public CategoryDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	@Override
	public Category selectCategoryByCategoryId(Long categoryId) throws Exception {
		 return sqlSession.selectOne("mapper.category.selectCategoryByCategoryId", categoryId);
	}

}
