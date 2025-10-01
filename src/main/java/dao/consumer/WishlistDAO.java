package dao.consumer;

import java.util.Map;

public interface WishlistDAO {
	// ================[소비자] 상품 찜 버튼 클릭 ===================
	void insertWishlist(Map<String, Object> params);

	// ================[소비자] 이미 찜한 상품인지 확인 ===================
	int existsWishlist(Map<String, Object> params);

	// ================[소비자] 찜 취소 ===================
	void deleteWishlist(Map<String, Object> params) throws Exception;
}
