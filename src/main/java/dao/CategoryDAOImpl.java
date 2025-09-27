package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Category;
import util.MybatisSqlSessionFactory;

public class CategoryDAOImpl implements CategoryDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public List<Category> selectLargeCategories() throws Exception {
		return sqlSession.selectList("mapper.category.selectLargeCategories");
	}

	@Override
	public List<Category> selectMiddleCategories(Long parentId) throws Exception {
		return sqlSession.selectList("mapper.category.selectMiddleCategories", parentId);
	}

	@Override
	public List<Category> selectSmallCategories(Long parentId) throws Exception {
		return sqlSession.selectList("mapper.category.selectSmallCategories", parentId);
	}

}
