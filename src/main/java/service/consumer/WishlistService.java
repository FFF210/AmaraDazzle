package service.consumer;

public interface WishlistService {
	// ================[소비자] 상품 찜 토글 ===================
	boolean toggleWishlist(Long memberId, Long productId) throws Exception;
}
