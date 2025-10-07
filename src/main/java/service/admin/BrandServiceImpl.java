package service.admin;

import java.util.List;
import java.util.Map;

import dao.admin.BrandDAO;
import dao.admin.BrandDAOImpl;
import dto.Brand;
import dto.admin.SearchConditionDTO;
import util.Paging;
import util.SearchUtil;

public class BrandServiceImpl implements BrandService{
	private BrandDAO b_dao;

	public BrandServiceImpl() {
		b_dao = new BrandDAOImpl();
	}
	
	private Paging m_pg = new Paging();
	private SearchUtil search = new SearchUtil();

	//가입한 브랜드 총 개수 
	@Override
	public Integer brandAllCnt(Map<String, String> cntMap) {
		SearchConditionDTO sc_DTO = search.buildSearchDTO(cntMap);
	    return b_dao.brandAllCount(sc_DTO);
	}
	//브랜드 검색 리스트 
	@Override
	public List<Brand> brandSearchList(Map<String, String> searchContent, Integer p_no) {
		Map<String, Object> searchlistMap = m_pg.paging(p_no);
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(searchContent);

	    // 페이징 추가 정보 세팅
	    sc_DTO.setStart_p((Integer) searchlistMap.get("start_p"));
	    sc_DTO.setPost_ea((Integer) searchlistMap.get("post_ea"));

	    return b_dao.brandSearchList(sc_DTO);
	}
	
	//브랜드 회원 정보 상세보기 
	@Override
	public Brand selectBrandDetail(int num) {
		return b_dao.selectBrandDetail(num);
	}
	

}
