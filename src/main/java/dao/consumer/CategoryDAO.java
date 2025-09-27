package dao.consumer;

import dto.Category;

public interface CategoryDAO {
	Category selectCategoryByCategoryId(Long categoryId) throws Exception;
}
