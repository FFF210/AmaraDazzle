package service.consumer;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.PointDAO;
import dao.consumer.PointDAOImpl;
import dto.Point;

public class PointServiceImpl implements PointService {

	private PointDAO pointDAO;

	// 생성자: DAO 초기화
	public PointServiceImpl() {
		pointDAO = new PointDAOImpl();
	}

	// 회원의 포인트 내역
	@Override
	public Map<String, Object> getPointHistory(Long memberId, int page, int pageSize) throws Exception {
		if (memberId == null) {
			throw new Exception("회원 ID가 필요합니다.");
		}

		// 1. 파라미터 설정
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);

		// 2. 페이지네이션 설정
		int offset = (page - 1) * pageSize;
		params.put("limit", pageSize);
		params.put("offset", offset);

		// 3. 데이터 조회
		List<Map<String, Object>> pointHistory = pointDAO.selectPointHistory(params);
		int totalCount = pointDAO.countPointHistory(memberId);

		// 4. 페이지 정보 계산
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		// 5. 결과 반환
		Map<String, Object> result = new HashMap<>();
		result.put("pointHistory", pointHistory);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);
		result.put("currentPage", page);
		result.put("pageSize", pageSize);

		return result;
	}

	// 특정 기간의 포인트 내역
	@Override
	public Map<String, Object> getPointHistoryByPeriod(Long memberId, Timestamp startDate, Timestamp endDate, int page,
			int pageSize) throws Exception {
		if (memberId == null) {
			throw new Exception("회원 ID가 필요합니다.");
		}

        // 1. 파라미터 설정
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("startDate", startDate);
		params.put("endDate", endDate);

        // 2. 페이지네이션 설정
		int offset = (page - 1) * pageSize;
		params.put("limit", pageSize);
		params.put("offset", offset);

        // 3. 데이터 조회
		List<Map<String, Object>> pointHistory = pointDAO.selectPointHistoryByPeriod(params);
		int totalCount = pointDAO.countPointHistoryByPeriod(params);

        // 4. 페이지 정보 계산
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);
 
        // 5. 결과 반환
		Map<String, Object> result = new HashMap<>();
		result.put("pointHistory", pointHistory);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);
		result.put("currentPage", page);
		result.put("pageSize", pageSize);

		return result;
	}

}
