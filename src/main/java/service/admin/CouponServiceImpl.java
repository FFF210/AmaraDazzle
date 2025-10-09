package service.admin;

import java.util.List;
import java.util.Map;

import dao.admin.CouponDAO;
import dao.admin.CouponDAOImpl;
import dto.Coupon;
import dto.admin.SearchConditionDTO;
import util.Paging;
import util.SearchUtil;

public class CouponServiceImpl implements CouponService{
	private CouponDAO cp_dao;

	public CouponServiceImpl() {
		cp_dao = new CouponDAOImpl();
	}

	private Paging m_pg = new Paging();
	private SearchUtil search = new SearchUtil();
	
	
	// 쿠폰 발행 수 
	@Override
	public Integer pCouponCnt(Map<String, String> cntMap) {
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(cntMap);
	    return cp_dao.pCouponCnt(sc_DTO);
	}

	// 쿠폰 발행 리스트 보기 
	@Override
	public List<Coupon> pCouponAllList(int p_no) {
		Map<String, Object> listMap = m_pg.paging(p_no);
		return cp_dao.pCouponAllList(listMap);
	}

	// 검색된 발행쿠폰 리스트
	@Override
	public List<Coupon> pCouponSearchList(Map<String, String> searchContent, int p_no) {
	    Map<String, Object> searchlistMap = m_pg.paging(p_no);
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(searchContent);

	    // 페이징 추가 정보 세팅
	    sc_DTO.setStart_p((Integer) searchlistMap.get("start_p"));
	    sc_DTO.setPost_ea((Integer) searchlistMap.get("post_ea"));

	    return cp_dao.pCouponSearchList(sc_DTO);
	}

	//쿠폰 발행
	@Override
	public int insertPublCoupon(Coupon pCoupon) {
		if(pCoupon.getPch_noRestr() != null && !pCoupon.getPch_noRestr().isEmpty()) { // 사용조건 제한없음 체크된 경우 
			pCoupon.setAmountCondition("-");
		}
		return cp_dao.insertPublCoupon(pCoupon);
	}

	//발행 쿠폰 상세보기 
	@Override
	public Coupon publCouponDetail(int num) {
		return cp_dao.publCouponDetail(num);
	}

	//개별지급 쿠폰 전체 수 
	@Override
	public Integer iCouponCnt(Map<String, String> cntMap) {
		SearchConditionDTO sc_DTO = search.buildSearchDTO(cntMap);
	    return cp_dao.iCouponCnt(sc_DTO);
	}

	//개별지급 쿠폰 전체 목록 
	@Override
	public List<Coupon> iCouponAllList(Integer p_no) {
		Map<String, Object> listMap = m_pg.paging(p_no);
		return cp_dao.iCouponAllList(listMap);
	}

	//개별지급 쿠폰 검색 목록
	@Override
	public List<Coupon> iCouponSearchList(Map<String, String> searchContent, Integer p_no) {
		 Map<String, Object> searchlistMap = m_pg.paging(p_no);
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(searchContent);

	    // 페이징 추가 정보 세팅
	    sc_DTO.setStart_p((Integer) searchlistMap.get("start_p"));
	    sc_DTO.setPost_ea((Integer) searchlistMap.get("post_ea"));

	    return cp_dao.iCouponSearchList(sc_DTO);
	}

}
