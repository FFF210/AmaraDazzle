package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Category;
import util.MybatisSqlSessionFactory;

public class CategoryDAOImpl implements CategoryDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	// 대분류 목록 조회
	@Override
	public List<Category> selectLargeCategories() throws Exception {
		return sqlSession.selectList("mapper.category.selectLargeCategories");
	}

	// 특정 대분류에 속한 중분류 목록 조회
	@Override
	public List<Category> selectMiddleCategories(Long parentId) throws Exception {
		return sqlSession.selectList("mapper.category.selectMiddleCategories", parentId);
	}

	// 특정 중분류에 속한 소분류 목록 조회
	@Override
	public List<Category> selectSmallCategories(Long parentId) throws Exception {
		return sqlSession.selectList("mapper.category.selectSmallCategories", parentId);
	}

}
