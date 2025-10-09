package service.brand2;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand2.MembershipDAO;
import dao.brand2.MembershipDAOImpl;
import dto.AdminPayment;
import dto.Membership;
import dto.MembershipPlan;
import dto.brand2.MembershipList;

public class MembershipServiceImpl implements MembershipService {

	private MembershipDAO membershipDAO;

	public MembershipServiceImpl() {
		membershipDAO = new MembershipDAOImpl();
	}

	// 멤버십 결제 목록 조회
	@Override
	public Map<String, Object> MembershipListByPage(Map<String, Object> params) throws Exception {
		// 신청 목록 조회
		List<MembershipList> membershipList = membershipDAO.selectMembershipList(params);

		// auto 플랜이면, 다음 결제일 계산
		for (MembershipList m : membershipList) {
			if (m.getPlanId() != null && m.getPlanId().contains("AUTO") && m.getStartDate() != null) {
				LocalDateTime next = m.getStartDate().toLocalDateTime().plusMonths(1);
				m.setNextPayDate(Timestamp.valueOf(next));
			}
		}

		// 페이징
		int totalCount = membershipDAO.selectMembershipCount(params); // 총 멤버십 개수 조회
		int limit = (int) params.getOrDefault("limit", 10); // 총 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("membershipList", membershipList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// 멤버십 플랜 종류
	@Override
	public List<MembershipPlan> getMembershipPlans() {
		return membershipDAO.selectMembershipPlans();
	}

	// 멤버십 + 결제 동시 처리 (Membership은 Service 안에서 생성)
    @Override
    public Long createMembershipWithPayment(AdminPayment adminPayment, String planId, String orderName) {
    	// planId는 JSP에서 선택된 PLAN_1M, PLAN_3M 등
        int months;
        int quota;
        
        switch (planId) {
            case "PLAN_3M":
                months = 3; quota = 30000; break;
            case "PLAN_6M":
                months = 6; quota = 60000; break;
            case "PLAN_12M":
                months = 12; quota = 120000; break;
            default:
                months = 1; quota = 10000; break;
        }

        LocalDateTime now = LocalDateTime.now();
        Timestamp startDate = Timestamp.valueOf(now);
        Timestamp endDate = Timestamp.valueOf(now.plusMonths(months));

        // Service 내부에서 Membership 생성
        Membership membership = new Membership();
        membership.setBrandId(adminPayment.getBrandId());
        membership.setPlanId(planId);   // ✅ PLAN_1M 같은 코드값 저장
        membership.setStartDate(startDate);
        membership.setEndDate(endDate);
        membership.setStatus("ACTIVE");
        membership.setRemainQuota(quota);

        // membership insert → PK 리턴
        Long newMembershipId = membershipDAO.insertMembership(membership);

        // AdminPayment FK 세팅 + insert
        adminPayment.setMembershipId(newMembershipId);
        adminPayment.setOrderName(orderName);          // 사람이 보는 "1개월 이용권"
        membershipDAO.insertAdminPayment(adminPayment);

        return newMembershipId;
    }
	
	// 현재 이용 중인 멤버십
	@Override
	public MembershipList getCurrentMembership(Long brandId) {
		return membershipDAO.selectCurrentMembership(brandId);
	}

	// 예약된 멤버십
	@Override
	public MembershipList getReservedMembership(Long brandId) {
		return membershipDAO.selectReservedMembership(brandId);
	}

	// 멤버십 취소
	@Override
	public void cancelMembership(Long membershipId) {
		membershipDAO.cancelMembership(membershipId);
	}

}