package service.brand2;

import java.util.List;
import java.util.Map;

import dto.Product;

public interface ProductService {
    List<Product> getAvailableProducts(Map<String, Object> params) throws Exception;
}