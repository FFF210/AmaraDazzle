package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.Banner;

public interface BannerDAO {
	
	/*
	 * // 배너 폼 등록 void insertBanner(Banner banner) throws Exception;
	 */
	
	// 배너 신청 목록 조회
	List<Banner> selectAdbannerList(Map<String, Object> params) throws Exception;
	
	// 배너 개수 조회
	Integer selectAdbannerCount(Map<String, Object> params) throws Exception;
}
