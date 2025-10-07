package service.brand;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand.SettlementDAO;
import dao.brand.SettlementDAOImpl;
import dto.Settlement;
import dto.brand.SettlementDonut;
import dto.brand.SettlementSummary;
import dto.brand.SettlementTrend;

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

	// 정산 대시보드 - 정산 요약 조회
	@Override
	public SettlementSummary getSettlementSummary(Long brandId) throws Exception {
		SettlementSummary summary = settlementDAO.getSettlementSummary(brandId);

		if (summary.getPreviousPureProfit() > 0) {
			double profitRate = ((double) (summary.getCurrentPureProfit() - summary.getPreviousPureProfit())
					/ summary.getPreviousPureProfit()) * 100;
			summary.setProfitChangeRate(Math.round(profitRate * 100) / 100.0);
		}

		if (summary.getPreviousFinalAmount() > 0) {
			double salesRate = ((double) (summary.getCurrentFinalAmount() - summary.getPreviousFinalAmount())
					/ summary.getPreviousFinalAmount()) * 100;
			summary.setSalesChangeRate(Math.round(salesRate * 100) / 100.0);
		}

		return summary;
	}

	// 정산 대시보드 - 매출 도넛
	@Override
	public SettlementDonut getSettlementDonut(Long brandId) throws Exception {
		return settlementDAO.getDonutChartData(brandId);
	}

	// 정산 대시보드 - 월 단위 추이
	@Override
	public List<SettlementTrend> getMonthlyTrend(Long brandId) throws Exception {
		return settlementDAO.getMonthlyTrend(brandId);
	}
}
