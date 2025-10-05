package service.admin;

import java.util.List;
import java.util.Map;

import dao.admin.BannerDAO;
import dao.admin.BannerDAOImpl;
import dto.Banner;
import dto.admin.SearchConditionDTO;
import util.Paging;
import util.SearchUtil;

public class BannerServiceImpl implements BannerService {
	
	private BannerDAO bn_dao;

	public BannerServiceImpl() {
		bn_dao = new BannerDAOImpl();
	}

	private Paging m_pg = new Paging();
	private SearchUtil search = new SearchUtil();
	
	//전체 배너 총 개수 
	@Override
	public Integer bannerAllCnt(Map<String, String> cntMap) throws Exception {
		SearchConditionDTO sc_DTO = search.buildSearchDTO(cntMap);
	    return bn_dao.bannerAllCount(sc_DTO);
	}

	//전체 배너 신청 리스트 
	@Override
	public List<Banner> bannerAllList(Integer p_no) throws Exception {
		Map<String, Object> listMap = m_pg.paging(p_no);

		List<Banner> bannerAllList = bn_dao.bannerAllList(listMap);
		return bannerAllList;
	}

	//전체 배너 중 검색 리스트
	@Override
	public List<Banner> bannerSearchList(Map<String, String> searchContent, Integer p_no) throws Exception {
		Map<String, Object> searchlistMap = m_pg.paging(p_no);
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(searchContent);

	    // 페이징 추가 정보 세팅
	    sc_DTO.setStart_p((Integer) searchlistMap.get("start_p"));
	    sc_DTO.setPost_ea((Integer) searchlistMap.get("post_ea"));

	    return bn_dao.bannerSearchList(sc_DTO);
	}

	//배너 등록
	@Override
	public int adminBannerWrite(Banner banner) {
		return bn_dao.adminBannerWrite(banner);
	}

}
