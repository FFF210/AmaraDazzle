package service.consumer;

import dto.Category;

public interface CategoryService {
	Category selectCategoryByCategoryId(Long categoryId) throws Exception;
}
