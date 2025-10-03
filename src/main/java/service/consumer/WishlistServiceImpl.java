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
	@Override
	public List<Map<String, Object>> getWishlistByMemberId(Long memberId) throws Exception {
		return wishlistDAO.selectWishlistByMemberId(memberId);
	}

	// ================[소비자] 찜 개수 조회 ===================
	@Override
	public int getWishlistCount(Long memberId) throws Exception {
		 return wishlistDAO.countWishlistByMemberId(memberId);
	}

}
