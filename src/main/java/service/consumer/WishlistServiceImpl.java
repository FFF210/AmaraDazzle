package service.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.WishlistDAO;
import dao.consumer.WishlistDAOImpl;

public class WishlistServiceImpl implements WishlistService {

	private WishlistDAO wishlistDAO;

	public WishlistServiceImpl() {
		wishlistDAO = new WishlistDAOImpl();
	}

	// ================[소비자] 상품 찜 토글 ===================
	@Override
	public boolean toggleWishlist(Long memberId, Long productId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("productId", productId);

		if (wishlistDAO.existsWishlist(params) > 0) {
			wishlistDAO.deleteWishlist(params);
			return false; // 찜 취소됨
		} else {
			wishlistDAO.insertWishlist(params);
			return true; // 찜 추가됨
		}
	}

	 // ================[소비자] 위시리스트 목록 조회 ===================
	// 기존: 전체 조회 (마이페이지 대시보드용)
	@Override
	public List<Map<String, Object>> getWishlistByMemberId(Long memberId) throws Exception {
	    Map<String, Object> params = new HashMap<>();
	    params.put("memberId", memberId);
	    // limit, offset 없음 → 전체 조회
	    return wishlistDAO.selectWishlistByMemberId(params);
	}

	// 추가: 페이징 조회 (좋아요 페이지용)
	@Override
	public List<Map<String, Object>> getWishlistByMemberIdWithPaging(Long memberId, int page, int pageSize) throws Exception {
	    Map<String, Object> params = new HashMap<>();
	    params.put("memberId", memberId);
	    params.put("limit", pageSize);
	    params.put("offset", (page - 1) * pageSize);
	    return wishlistDAO.selectWishlistByMemberId(params);
	}

	// ================[소비자] 찜 개수 조회 ===================
	@Override
	public int getWishlistCount(Long memberId) throws Exception {
		 return wishlistDAO.countWishlistByMemberId(memberId);
	}
	
	// 찜 여부
	@Override
	public boolean isProductWished(Long memberId, Long productId) throws Exception {
	    Map<String, Object> params = new HashMap<>();
	    params.put("memberId", memberId);
	    params.put("productId", productId);
	    return wishlistDAO.existsWishlist(params) > 0;
	}

}
