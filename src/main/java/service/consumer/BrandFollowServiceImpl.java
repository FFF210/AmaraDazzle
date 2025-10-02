package service.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.BrandFollowDAO;
import dao.consumer.BrandFollowDAOImpl;

public class BrandFollowServiceImpl implements BrandFollowService {

	private BrandFollowDAO brandFollowDAO;

	public BrandFollowServiceImpl() {
        brandFollowDAO = new BrandFollowDAOImpl();
	}

     // ================[소비자] 브랜드 팔로우 토글 ===================
	@Override
	public boolean toggleBrandFollow(Long memberId, Long brandId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("brandId", brandId);

		if (brandFollowDAO.existsBrandFollow(params) > 0) {
			brandFollowDAO.deleteBrandFollow(params);
			return false; // 팔로우 취소됨
		} else {
			brandFollowDAO.insertBrandFollow(params);
			return true; // 팔로우 추가됨
		}
	}

	// ================[소비자] 팔로우 브랜드 목록 조회 ===================
	@Override
	public List<Map<String, Object>> getBrandFollowByMemberId(Long memberId) throws Exception {
		return brandFollowDAO.selectBrandFollowByMemberId(memberId);
	}

	// ================[소비자] 팔로우 브랜드 개수 조회 ===================
	@Override
	public int getBrandFollowCount(Long memberId) throws Exception {
		return brandFollowDAO.countBrandFollowByMemberId(memberId);
	}

}
