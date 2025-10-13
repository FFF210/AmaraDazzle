package service.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.MemberCouponDAO;
import dao.consumer.MemberCouponDAOImpl;

public class MemberCouponServiceImpl implements MemberCouponService {
	
private MemberCouponDAO memberCouponDAO;
    
    public MemberCouponServiceImpl() {
        memberCouponDAO = new MemberCouponDAOImpl();
    }

    //회원의 사용 가능한 쿠폰 개수 조회
	@Override
	public int getAvailableCouponCount(Long memberId) throws Exception {
		 return memberCouponDAO.getAvailableCouponCount(memberId);
	}

	//회원의 쿠폰 목록 조회 (페이지네이션)
	@Override
	public Map<String, Object> getMemberCouponList(Long memberId, int page, int pageSize) throws Exception {
		if (memberId == null) {
			throw new Exception("회원 ID가 필요합니다.");
		}
		
		// 1. 파라미터 설정
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		
		// 2. 페이지네이션 설정
		int offset = (page - 1) * pageSize;
		params.put("limit", pageSize);
		params.put("offset", offset);
		
		// 3. 데이터 조회
		List<Map<String, Object>> couponList = memberCouponDAO.selectMemberCouponList(params);
		int totalCount = memberCouponDAO.countMemberCouponList(memberId);
		
		// 4. 페이지 정보 계산
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);
		
		// 5. 결과 반환
		Map<String, Object> result = new HashMap<>();
		result.put("couponList", couponList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);
		result.put("currentPage", page);
		result.put("pageSize", pageSize);
		
		return result;
	}

}
