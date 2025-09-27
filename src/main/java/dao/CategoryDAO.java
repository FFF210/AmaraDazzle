package dao;

import java.util.List;

import dto.Category;

public interface CategoryDAO {
	// 대분류 목록 조회
	List<Category> selectLargeCategories() throws Exception;

	// 특정 대분류에 속한 중분류 목록 조회
	List<Category> selectMiddleCategories(Long parentId) throws Exception;

	// 특정 중분류에 속한 소분류 목록 조회
	List<Category> selectSmallCategories(Long parentId) throws Exception;
}
