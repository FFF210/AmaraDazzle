package service.brand2;

import java.util.Map;

import dto.brand2.BannerForm;

public interface AdbannerService {
	
	// 배너 신청 등록
	void registerBanner(BannerForm bannerForm) throws Exception;
	
	// 배너 신청 목록 조회
	Map<String, Object> AdbannerListByPage(Map<String, Object> params) throws Exception;
}
