package dao.consumer;

import dto.Brand;

public interface BrandDAO {
	//브랜드 아이디로 브랜드 조회
	Brand selectBrandByBrandId(Long brandId) throws Exception;
	
	//브랜드 팔로워수 세기 (mapper는 brandFollow에서 가져왔음)
	int countBrandFollowers(Long brandId);
}
