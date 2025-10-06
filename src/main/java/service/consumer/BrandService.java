package service.consumer;

import java.util.List;

import dto.Brand;
import dto.consumer.MembershipBrand;

public interface BrandService {
	// 브랜드id로 브랜드 조회
	Brand selectBrandByBrandId(Long brandId) throws Exception;

	// 브랜드 팔로워 수 세기
	int countBrandFollowers(Long brandId) throws Exception;

	// <!-- ================[소비자] 멤버십 가입 브랜드 조회 =================== -->
	List<MembershipBrand> getActiveMembershipBrands(int limit) throws Exception;
}
