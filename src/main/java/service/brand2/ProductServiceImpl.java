package service.brand2;

import java.util.List;
import java.util.Map;

import dao.brand2.ProductDAO;
import dao.brand2.ProductDAOImpl;
import dto.Product;

public class ProductServiceImpl implements ProductService {
    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    public List<Product> getAvailableProducts(Map<String, Object> params) throws Exception {
        return productDAO.selectAvailableProducts(params);
    }
}
