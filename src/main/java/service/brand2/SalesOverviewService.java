package service.brand2;

import java.util.List;
import java.util.Map;

import dto.Category;
import dto.brand2.SalesOverview;

public interface SalesOverviewService {
	/**
	 * 카테고리별 매출 추이 조회
	 * 
	 * @param params (brandId, startDate, endDate)
	 * @return List<SalesOverview>
	 */
	List<SalesOverview> getCategorySalesTrend(Map<String, Object> params);
	
	List<Category> getLargeCategories() throws Exception;
}
