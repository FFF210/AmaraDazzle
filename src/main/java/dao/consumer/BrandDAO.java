package dao.consumer;

import dto.Brand;

public interface BrandDAO {
	Brand selectBrandByBrandId(Long brandId) throws Exception;
}
