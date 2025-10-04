package dao.brand2;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import dto.Banner;
import dto.admin.SearchConditionDTO;

public interface BannerDAO {
	
	// 배너 신청
	public void insertBannerForm(Banner banner) throws Exception;
	
	// 배너 신청 목록 조회
	List<Banner> selectAdbannerList(Map<String, Object> params) throws Exception;
	
	// 배너 개수 조회
	Integer selectAdbannerCount(Map<String, Object> params) throws Exception;
	
	// 배너 상세보기 버튼
	Banner selectBannerById(@Param("bannerId")long bannerId) throws Exception;
	
	// 배너 취소 버튼
	public void updateBannerStatus(Map<String, Object> params);
	
	//전체 배너 총 개수 
	Integer bannerAllCount(SearchConditionDTO sc_DTO) throws Exception;
	//전체 배너 신청 리스트
	List<Banner> bannerAllList(Map<String, Object> listMap) throws Exception;
	//전체 배너 중 검색 리스트
	List<Banner> bannerSearchList(SearchConditionDTO sc_DTO) throws Exception;
}
