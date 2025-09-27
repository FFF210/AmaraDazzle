package service.consumer;

import dao.consumer.CategoryDAO;
import dao.consumer.CategoryDAOImpl;
import dto.Category;

public class CategoryServiceImpl implements CategoryService {

	private CategoryDAO categoryDAO;

	public CategoryServiceImpl() {
		categoryDAO = new CategoryDAOImpl();
	}

	@Override
	public Category selectCategoryByCategoryId(Long categoryId) throws Exception {
		if (categoryId == null || categoryId <= 0) {
			throw new IllegalArgumentException("유효하지 않은 카테고리 ID입니다.");
		}

		Category category = categoryDAO.selectCategoryByCategoryId(categoryId);

		if (category == null) {
			throw new Exception("카테고리를 찾을 수 없습니다.");
		}
		return category;
	}

}
