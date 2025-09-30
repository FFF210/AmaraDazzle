package service.brand2;

import java.util.Map;

public interface MembershipService {
	
	// 멤버십 결제 목록 조회
	Map<String, Object> MembershipListByPage(Map<String, Object> params) throws Exception;
}
