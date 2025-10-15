package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.brand2.SalesOverview;
import dto.brand2.SalesStatusRow;

public interface SalesOverviewDAO {
	 /**
     * 카테고리별 매출 추이 조회
     *
     * @param params (brandId, startDate, endDate, categories)
     *   - brandId: Long
     *   - startDate: String (yyyy-MM-dd)
     *   - endDate: String (yyyy-MM-dd)
     *   - categories: String (쉼표 구분된 categoryId 목록, 선택 사항)
     * @return 카테고리별 매출 리스트
     */
	
	// 차트용
	List<SalesOverview> selectCategorySalesTrend(Map<String, Object> params);
	
	// 테이블용
	List<SalesStatusRow> selectSalesStatusRows(Map<String, Object> params);
	
	// 테이블 페이징 개수 조회
	Integer selectSalesOverviewCount(Map<String, Object> params) throws Exception;
}
