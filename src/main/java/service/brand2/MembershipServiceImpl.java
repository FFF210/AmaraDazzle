package service.brand2;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dao.brand2.MembershipDAO;
import dao.brand2.MembershipDAOImpl;
import dto.AdminPayment;
import dto.Membership;
import dto.MembershipPlan;
import dto.brand2.MembershipList;
import util.MybatisSqlSessionFactory;

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

//			db에서 데이터 오는 지 확인
//			 System.out.println("[Service] selectMembershipList 결과 size = " + (membershipList == null ? "null" : membershipList.size()));
//			    if (membershipList != null) {
//			        for (Membership m : membershipList) {
//			            System.out.println("[Service] membership row = " + m);
//			        }
//			    }
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

	// 결제 성공 시 insert
	@Override
	public void applyMembership(AdminPayment payment) {
		int months = getPeriodByPlanId(payment.getPlanId());
		LocalDateTime now = LocalDateTime.now();

		// 기존 멤버십이 있어도 무조건 새 행 추가
		Timestamp startDate = Timestamp.valueOf(now);
		Timestamp endDate = Timestamp.valueOf(now.plusMonths(months));

		Membership membership = new Membership();
		membership.setBrandId(payment.getBrandId());
		membership.setPlanId(payment.getPlanId());
		membership.setStartDate(startDate);
		membership.setEndDate(endDate);
		membership.setStatus("ACTIVE");
		membership.setRemainQuota(getQuotaByPlanId(payment.getPlanId()));

		membershipDAO.insertMembership(membership);
	}

	// 현재 이용 중인 멤버십
	@Override
	public Membership getCurrentMembership(Long brandId) {
		return membershipDAO.selectCurrentMembership(brandId);
	}

	// 예약된 멤버십
	@Override
	public Membership getReservedMembership(Long brandId) {
		return membershipDAO.selectReservedMembership(brandId);
	}

	// 멤버십 취소
	@Override
	public void cancelMembership(Long membershipId) {
		membershipDAO.cancelMembership(membershipId);
	}

	// --- 내부 유틸 ---
	private int getPeriodByPlanId(String planId) {
		switch (planId) {
		case "PLAN_1M":
			return 1;
		case "PLAN_3M":
			return 3;
		case "PLAN_6M":
			return 6;
		case "PLAN_12M":
			return 12;
		default:
			return 1;
		}
	}

	private int getQuotaByPlanId(String planId) {
		switch (planId) {
		case "PLAN_1M":
			return 10000;
		case "PLAN_3M":
			return 30000;
		case "PLAN_6M":
			return 60000;
		case "PLAN_12M":
			return 120000;
		default:
			return 10000;
		}
	}
}