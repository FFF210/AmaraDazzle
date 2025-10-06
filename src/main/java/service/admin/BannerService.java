package service.admin;

import java.util.List;
import java.util.Map;

import dto.Banner;

public interface BannerService {
		
		Integer bannerAllCnt(Map<String, String> searchContent) throws Exception; //전체 배너 개수 
		List<Banner> bannerAllList(Integer p_no) throws Exception; //전체 배너 신청 리스트
		List<Banner> bannerSearchList(Map<String, String> searchContent, Integer p_no) throws Exception; //전체 배너 중 검색 리스트
		int adminBannerWrite(Banner banner); // 배너 등록 
	
}
