package service.brand2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand2.MembershipDAO;
import dao.brand2.MembershipDAOImpl;
import dto.Membership;

public class MembershipServiceImpl implements MembershipService {

	private MembershipDAO membershipDAO;
	
	public MembershipServiceImpl() {
		membershipDAO = new MembershipDAOImpl();
	}
	
	
	// 멤버십 결제 목록 조회
		@Override
		public Map<String, Object> MembershipListByPage(Map<String, Object> params) throws Exception {
			// 신청 목록 조회
			List<Membership> membershipList = membershipDAO.selectMembershipList(params);

//			db에서 데이터 오는 지 확인
//			 System.out.println("[Service] selectMembershipList 결과 size = " + (membershipList == null ? "null" : membershipList.size()));
//			    if (membershipList != null) {
//			        for (Membership m : membershipList) {
//			            System.out.println("[Service] membership row = " + m);
//			        }
//			    }
			
			// 총 멤버십 개수 조회
			int totalCount = membershipDAO.selectMembershipCount(params);

			// 총 페이지 수 계산
			int limit = (int) params.getOrDefault("limit", 10);
			int totalPages = (int) Math.ceil((double) totalCount / limit);

			Map<String, Object> result = new HashMap<>();
			result.put("membershipList", membershipList);
			result.put("totalCount", totalCount);
			result.put("totalPages", totalPages);

			return result;
		}

}
