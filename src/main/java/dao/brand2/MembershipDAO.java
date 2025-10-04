package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.MembershipPlan;
import dto.brand2.MembershipList;

public interface MembershipDAO {
	// 멤버십 결제 목록 조회
	List<MembershipList> selectMembershipList(Map<String, Object> params) throws Exception;
	
	// 멤버십 개수 조회
	Integer selectMembershipCount(Map<String, Object> params) throws Exception;
	
	// 멤버십 플랜 종류
	List<MembershipPlan> selectMembershipPlans();
}
