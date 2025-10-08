package service.brand2;

import java.util.List;
import java.util.Map;

import dto.AdminPayment;
import dto.Membership;
import dto.MembershipPlan;

public interface MembershipService {

	// 멤버십 결제 목록 조회
	Map<String, Object> MembershipListByPage(Map<String, Object> params) throws Exception;

	// 멤버십 플랜 종류
	List<MembershipPlan> getMembershipPlans();

	// 결제 성공 시 insert, update
	void applyMembership(AdminPayment payment);

	// 현재 이용 중인 멤버십
	Membership getCurrentMembership(Long brandId);

	// 예약된 멤버십
	Membership getReservedMembership(Long brandId);

	// 멤버십 취소 (아직 시작 전)
	void cancelMembership(Long membershipId);
}