package service;

import java.util.List;

import dto.Category;

public interface CategoryService {
	// 대분류 목록 조회
	List<Category> getLargeCategories() throws Exception;

	// 특정 대분류에 속한 중분류 목록 조회
	List<Category> getMiddleCategories(Long parentId) throws Exception;

	// 특정 중분류에 속한 소분류 목록 조회
	List<Category> getSmallCategories(Long parentId) throws Exception;
}
