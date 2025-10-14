package service.consumer;

import java.util.List;
import java.util.Map;

public interface BrandFollowService {
	// ================[소비자] 브랜드 팔로우 토글 ===================
    boolean toggleBrandFollow(Long memberId, Long brandId) throws Exception;
    
    // ================[소비자] 팔로우 브랜드 목록 조회 ===================
    List<Map<String, Object>> getBrandFollowByMemberId(Long memberId) throws Exception;
    
    // ================[소비자] 팔로우 브랜드 개수 조회 ===================
    int getBrandFollowCount(Long memberId) throws Exception;
    
    // 팔로우 여부
    boolean isBrandFollowed(Long memberId, Long brandId) throws Exception;
}
