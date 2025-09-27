package service.consumer;

import dao.consumer.BrandDAO;
import dao.consumer.BrandDAOImpl;
import dto.Brand;

public class BrandServiceImpl implements BrandService {
	
private BrandDAO brandDAO;
    
    public BrandServiceImpl() {
        this.brandDAO = new BrandDAOImpl();
    }

	@Override
	public Brand selectBrandByBrandId(Long brandId) throws Exception {
		 if (brandId == null || brandId <= 0) {
	            throw new IllegalArgumentException("유효하지 않은 브랜드 ID입니다.");
	        }
	        
	        Brand brand = brandDAO.selectBrandByBrandId(brandId);
	        
	        if (brand == null) {
	            throw new Exception("브랜드를 찾을 수 없습니다.");
	        }
	        
	        return brand;
	}

}
