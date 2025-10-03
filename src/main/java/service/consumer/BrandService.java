package service.consumer;

import dto.Brand;

public interface BrandService {
	//브랜드id로 브랜드 조회
	Brand selectBrandByBrandId(Long brandId) throws Exception;
	
	//브랜드 팔로워 수 세기
	int countBrandFollowers(Long brandId) throws Exception;
}
