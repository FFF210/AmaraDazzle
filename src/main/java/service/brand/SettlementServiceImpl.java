package service.brand;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand.SettlementDAO;
import dao.brand.SettlementDAOImpl;
import dto.Settlement;

public class SettlementServiceImpl implements SettlementService {

	private SettlementDAO settlementDAO;

	public SettlementServiceImpl() {
		settlementDAO = new SettlementDAOImpl();
	}

	// 브랜드 정산 목록 조회
	@Override
	public Map<String, Object> settlementListByPage(Map<String, Object> params) throws Exception {
		List<Settlement> settlementList = settlementDAO.selectSettlementListForBrand(params);

		// Long brandId = Long.parseLong(params.get("brandId").toString());
		Long brandId = 1L;

		// 총 상품 개수 조회
		int totalCount = settlementDAO.selectSettlementCountForBrand(brandId);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("settlementList", settlementList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}
}
