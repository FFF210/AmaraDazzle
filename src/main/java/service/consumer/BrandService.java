package service.consumer;

import dto.Brand;

public interface BrandService {
	Brand selectBrandByBrandId(Long brandId) throws Exception;
}
