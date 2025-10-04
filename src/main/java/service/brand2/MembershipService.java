package service.brand2;

import java.util.List;
import java.util.Map;

import dto.MembershipPlan;

public interface MembershipService {
	
	// 멤버십 결제 목록 조회
	Map<String, Object> MembershipListByPage(Map<String, Object> params) throws Exception;
	
	// 멤버십 플랜 종류
	List<MembershipPlan> getMembershipPlans();
}
