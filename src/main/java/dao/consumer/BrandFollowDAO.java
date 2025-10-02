package dao.consumer;

import java.util.List;
import java.util.Map;

public interface BrandFollowDAO {
	// ================[소비자] 브랜드 팔로우 ===================
    void insertBrandFollow(Map<String, Object> params) throws Exception;

    // ================[소비자] 이미 팔로우한 브랜드인지 확인 ===================
    int existsBrandFollow(Map<String, Object> params) throws Exception;

    // ================[소비자] 브랜드 팔로우 취소 ===================
    void deleteBrandFollow(Map<String, Object> params) throws Exception;

    // ================[소비자] 팔로우 브랜드 목록 조회 ===================
    List<Map<String, Object>> selectBrandFollowByMemberId(Long memberId) throws Exception;

    // ================[소비자] 팔로우 브랜드 개수 조회 ===================
    int countBrandFollowByMemberId(Long memberId) throws Exception;
}
