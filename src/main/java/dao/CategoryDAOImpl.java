package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Category;
import util.MybatisSqlSessionFactory;

public class CategoryDAOImpl implements CategoryDAO {

	// 대분류 목록 조회
	@Override
	public List<Category> selectLargeCategories() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.category.selectLargeCategories");
		}
	}

	// 특정 대분류에 속한 중분류 목록 조회
	@Override
	public List<Category> selectMiddleCategories(Long parentId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.category.selectMiddleCategories", parentId);
		}
	}

	// 특정 중분류에 속한 소분류 목록 조회
	@Override
	public List<Category> selectSmallCategories(Long parentId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.category.selectSmallCategories", parentId);
		}
	}

	// id로 카테고리 이름 조회
	@Override
	public String selectCategorieName(Long categoryId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.category.selectCategorieName", categoryId);
		}

	}

}
