package service.brand;

import java.util.List;
import java.util.Map;

import dto.brand.SettlementDonut;
import dto.brand.SettlementSummary;
import dto.brand.SettlementTrend;

public interface SettlementService {
	// 브랜드 정산 목록 조회
	public Map<String, Object> settlementListByPage(Map<String, Object> params) throws Exception;

	// 정산 대시보드 - 정산 요약 조회
	public SettlementSummary getSettlementSummary(Long brandId) throws Exception;

	// 정산 대시보드 - 매출 도넛
	public SettlementDonut getSettlementDonut(Long brandId) throws Exception;

	// 정산 대시보드 - 월 단위 추이
	public List<SettlementTrend> getMonthlyTrend(Long brandId) throws Exception;
}
