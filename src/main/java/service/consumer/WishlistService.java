package service.consumer;

import java.util.List;
import java.util.Map;

public interface WishlistService {
	// ================[소비자] 상품 찜 토글 ===================
	boolean toggleWishlist(Long memberId, Long productId) throws Exception;

	// ================[소비자] 위시리스트 목록 조회 ===================
    List<Map<String, Object>> getWishlistByMemberId(Long memberId) throws Exception;
    
    //페이징 조회
    List<Map<String, Object>> getWishlistByMemberIdWithPaging(Long memberId, int page, int pageSize) throws Exception;
    
    // ================[소비자] 찜 개수 조회 ===================
    int getWishlistCount(Long memberId) throws Exception;
}
