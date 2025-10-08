package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.AdminPayment;
import dto.Membership;
import dto.MembershipPlan;
import dto.brand2.MembershipList;

public interface MembershipDAO {
	// 멤버십 결제 목록 조회
	List<MembershipList> selectMembershipList(Map<String, Object> params) throws Exception;

	// 멤버십 개수 조회
	Integer selectMembershipCount(Map<String, Object> params) throws Exception;

	// 멤버십 플랜 종류
	List<MembershipPlan> selectMembershipPlans();

	// 신규 멤버십 가입
	Long insertMembership(Membership membership);
	
	// admin_payment insert
	void insertAdminPayment(AdminPayment payment);

	// 멤버십 취소 (아직 시작 전)
	int cancelMembership(Long membershipId);

	// 브랜드별 현재 이용중 멤버십
	Membership selectCurrentMembership(Long brandId);

	// 브랜드별 예약된 멤버십
	Membership selectReservedMembership(Long brandId);
}
