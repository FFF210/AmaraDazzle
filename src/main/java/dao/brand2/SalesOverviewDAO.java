package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.brand2.SalesOverview;

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
	
	List<SalesOverview> selectCategorySalesTrend(Map<String, Object> params);
}
