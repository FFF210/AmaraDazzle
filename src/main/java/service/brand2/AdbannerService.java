package service.brand2;

import java.util.List;
import java.util.Map;

import dto.Banner;
import dto.brand2.AdminToss;
import dto.brand2.BannerForm;

public interface AdbannerService {
	
	// 배너 신청 등록
	void registerBanner(BannerForm bannerForm) throws Exception;
	
	// 배너 신청 목록 조회
	Map<String, Object> AdbannerListByPage(Map<String, Object> params) throws Exception;
	
	// AdminToss 결제 저장
	void savePayment(AdminToss payment) throws Exception;

	//전체 배너 개수 
	Integer bannerAllCnt(Map<String, String> searchContent) throws Exception;

	//전체 배너 신청 리스트 
	List<Banner> bannerAllList(Integer p_no) throws Exception;

	//전체 배너 중 검색 리스트
	List<Banner> bannerSearchList(Map<String, String> searchContent, Integer p_no) throws Exception;
	
	
}
