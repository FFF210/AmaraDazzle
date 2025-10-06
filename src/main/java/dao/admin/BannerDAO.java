package dao.admin;

import java.util.List;
import java.util.Map;

import dto.Banner;
import dto.admin.SearchConditionDTO;

public interface BannerDAO {
	
	Integer bannerAllCount(SearchConditionDTO sc_DTO) throws Exception;	//전체 배너 총 개수 
	List<Banner> bannerAllList(Map<String, Object> listMap) throws Exception;	//전체 배너 신청 리스트
	List<Banner> bannerSearchList(SearchConditionDTO sc_DTO) throws Exception;	//전체 배너 중 검색 리스트
	int adminBannerWrite(Banner banner); //어드민 배너 등록

}
