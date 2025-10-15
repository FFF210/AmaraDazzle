package service.consumer;

import java.util.List;
import java.util.Map;

import dao.consumer.BrandDAO;
import dao.consumer.BrandDAOImpl;
import dto.Brand;
import dto.consumer.BrandSearchResult;
import dto.consumer.MembershipBrand;

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
	
	// 브랜드의 진행 중인 이벤트 조회
	@Override
	public List<Map<String, Object>> getEventsByBrandId(Long brandId) throws Exception {
	    return brandDAO.selectEventsByBrandId(brandId);
	}

	// 브랜드 팔로워수 세기 (mapper는 brandFollow에서)
	@Override
	public int countBrandFollowers(Long brandId) throws Exception {
		return brandDAO.countBrandFollowers(brandId);
	}

	// <!-- ================[소비자] 멤버십 가입 브랜드 조회 =================== -->
	@Override
	public List<MembershipBrand> getActiveMembershipBrands(int limit) throws Exception {
		return brandDAO.selectActiveMembershipBrands(limit);
	}

	// ======================= [소비자] 검색 페이지 - 브랜드 검색 =======================
	@Override
	public List<BrandSearchResult> getBrandListForSearch(Map<String, Object> params) throws Exception {
		return brandDAO.searchBrandListForConsumer(params);
	}

}
