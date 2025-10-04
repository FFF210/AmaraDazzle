package dao.consumer;

import java.util.List;

import dto.Brand;
import dto.consumer.MembershipBrand;

public interface BrandDAO {
	// 브랜드 아이디로 브랜드 조회
	Brand selectBrandByBrandId(Long brandId) throws Exception;

	// 브랜드 팔로워수 세기 (mapper는 brandFollow에서 가져왔음)
	int countBrandFollowers(Long brandId);

	// <!-- ================[소비자] 멤버십 가입 브랜드 조회 =================== -->
	List<MembershipBrand> selectActiveMembershipBrands(Integer limit);
}
