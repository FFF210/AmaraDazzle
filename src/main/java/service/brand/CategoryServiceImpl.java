package service.brand;

import java.util.List;

import dao.CategoryDAO;
import dao.CategoryDAOImpl;
import dto.Category;

public class CategoryServiceImpl implements CategoryService {

	private CategoryDAO categoryDAO;

	public CategoryServiceImpl() {
		categoryDAO = new CategoryDAOImpl();
	}

	// 대분류 목록 조회
	@Override
	public List<Category> getLargeCategories() throws Exception {
		return categoryDAO.selectLargeCategories();
	}

	// 특정 대분류에 속한 중분류 목록 조회
	@Override
	public List<Category> getMiddleCategories(Long parentId) throws Exception {
		return categoryDAO.selectMiddleCategories(parentId);
	}

	// 특정 중분류에 속한 소분류 목록 조회
	@Override
	public List<Category> getSmallCategories(Long parentId) throws Exception {
		return categoryDAO.selectSmallCategories(parentId);
	}

}
