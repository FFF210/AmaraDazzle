package dao.brand;

import java.util.List;
import java.util.Map;

import dto.Settlement;
import dto.brand.SettlementDonut;
import dto.brand.SettlementSummary;
import dto.brand.SettlementTrend;

public interface SettlementDAO {
	// 정산 목록 조회
	List<Settlement> selectSettlementListForBrand(Map<String, Object> params) throws Exception;

	// 정산 목록 개수 조회
	Integer selectSettlementCountForBrand(Long brandId) throws Exception;

	// 정산 요약 조회
	SettlementSummary getSettlementSummary(Long brandId) throws Exception;

	// 매출 도넛
	SettlementDonut getDonutChartData(Long brandId) throws Exception;

	// 월 단위 정산 금액 추이
	List<SettlementTrend> getMonthlyTrend(Long brandId) throws Exception;
}
