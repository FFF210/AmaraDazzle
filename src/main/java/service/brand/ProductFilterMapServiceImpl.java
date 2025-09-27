package service.brand;

import dao.brand.ProductFilterMapDAO;
import dao.brand.ProductFilterMapDAOImpl;

public class ProductFilterMapServiceImpl implements ProductFilterMapService {

	private ProductFilterMapDAO productFilterMapDAO;

	public ProductFilterMapServiceImpl() {
		productFilterMapDAO = new ProductFilterMapDAOImpl();
	}

	@Override
	public void insertProductFilter(Long productId, Long filterId) throws Exception {
		productFilterMapDAO.insertProductFilter(productId, filterId);
	}

	@Override
	public void deleteProductFilters(Long productId) throws Exception {
		productFilterMapDAO.deleteProductFilters(productId);
	}

}
