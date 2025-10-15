package service.brand2;

import java.util.List;
import java.util.Map;

import dto.Category;
import dto.brand2.SalesOverview;
import dto.brand2.SalesStatusRow;

public interface SalesOverviewService {
	/**
	 * 카테고리별 매출 추이 조회
	 * 
	 * @param params (brandId, startDate, endDate)
	 * @return List<SalesOverview>
	 */
	List<SalesOverview> getCategorySalesTrend(Map<String, Object> params);
	
	// 대분류 카테고리 조회 (depth=1)
	List<Category> getLargeCategories() throws Exception;
	
	/**
     * 카테고리별 매출 현황 (테이블 pivot용)
     * @param params (brandId, startDate, endDate)
     * @return List<SalesStatusRow>
     */
    Map<String, Object> getSalesStatusRows(Map<String, Object> params) throws Exception;
	
}
