package service.consumer;

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

	//회원의 쿠폰 목록 조회
	@Override
	public List<Map<String, Object>> getMemberCouponList(Long memberId) throws Exception {
	    return memberCouponDAO.selectMemberCouponList(memberId);
	}

}
