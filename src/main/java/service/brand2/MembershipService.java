package service.brand2;

import java.util.List;
import java.util.Map;

import dto.AdminPayment;
import dto.MembershipPlan;
import dto.brand2.MembershipList;

public interface MembershipService {

	// 멤버십 결제 목록 조회 (페이징)
    Map<String, Object> MembershipListByPage(Map<String, Object> params) throws Exception;

    // 멤버십 플랜 종류
    List<MembershipPlan> getMembershipPlans();
    
 // 💡 멤버십 + 결제 동시 처리
    Long createMembershipWithPayment(AdminPayment adminPayment, String planId, String orderName);

    // 현재 이용 중인 멤버십
    MembershipList getCurrentMembership(Long brandId);

    // 예약된 멤버십
    MembershipList getReservedMembership(Long brandId);

    // 멤버십 취소 (아직 시작 전)
    void cancelMembership(Long membershipId);
}