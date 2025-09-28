package service.brand;

import dao.brand.ProductFilterMapDAO;
import dao.brand.ProductFilterMapDAOImpl;

public class ProductFilterMapServiceImpl implements ProductFilterMapService {

	private ProductFilterMapDAO productFilterMapDAO;

	public ProductFilterMapServiceImpl() {
		productFilterMapDAO = new ProductFilterMapDAOImpl();
	}

	// 필터 매핑 등록
	@Override
	public void insertProductFilter(Long productId, Long filterId) throws Exception {
		productFilterMapDAO.insertProductFilter(productId, filterId);
	}

	// 특정 상품의 필터 매핑 삭제
	@Override
	public void deleteProductFilters(Long productId) throws Exception {
		productFilterMapDAO.deleteProductFilters(productId);
	}

}
