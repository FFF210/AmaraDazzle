package service.brand;

import java.util.List;

import dao.brand.ProductOptionDAO;
import dao.brand.ProductOptionDAOImpl;
import dto.ProductOption;

public class ProductOptionServiceImpl implements ProductOptionService {

	private ProductOptionDAO productOptionDAO;

	public ProductOptionServiceImpl() {
		productOptionDAO = new ProductOptionDAOImpl();
	}

	// 옵션 등록
	@Override
	public void addOption(ProductOption option) throws Exception {
		productOptionDAO.insertOption(option);
	}

	// 특정 상품 옵션 목록
	@Override
	public List<ProductOption> getOptions(String productId) throws Exception {
		return productOptionDAO.selectOptionsByProductId(productId);
	}

	// 특정 상품 옵션 삭제
	@Override
	public void deleteOption(Long productId) throws Exception {
		productOptionDAO.deleteOption(productId);
	}

}
