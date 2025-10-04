package service.brand2;

import java.util.List;
import java.util.Map;

import dto.Banner;
import dto.AdminPayment;
import dto.Banner;

public interface AdbannerService {
	
	// 배너 신청 등록
	public void registerBanner(Banner banner) throws Exception;
	
	// 배너 신청 목록 조회
	Map<String, Object> AdbannerListByPage(Map<String, Object> params) throws Exception;
	
	// 배너 상세보기 버튼
	Banner getBannerById(long bannerId) throws Exception;
	
	// 배너 취소 버튼
	void cancelBanner(Map<String, Object> params) throws Exception;
	
	// AdminToss 결제 저장
	void savePayment(AdminPayment adminPayment) throws Exception;

	//전체 배너 개수 
	Integer bannerAllCnt(Map<String, String> searchContent) throws Exception;

	//전체 배너 신청 리스트 
	List<Banner> bannerAllList(Integer p_no) throws Exception;

	//전체 배너 중 검색 리스트
	List<Banner> bannerSearchList(Map<String, String> searchContent, Integer p_no) throws Exception;
	
	
}
