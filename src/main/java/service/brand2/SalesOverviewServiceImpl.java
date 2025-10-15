package service.brand2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.CategoryDAO;
import dao.CategoryDAOImpl;
import dao.brand2.SalesOverviewDAO;
import dao.brand2.SalesOverviewDAOImpl;
import dto.Category;
import dto.brand2.SalesOverview;
import dto.brand2.SalesStatusRow;

public class SalesOverviewServiceImpl implements SalesOverviewService {
	
	private SalesOverviewDAO salesOverviewDAO;
	private CategoryDAO categoryDAO;
	
	public SalesOverviewServiceImpl() {
        this.salesOverviewDAO = new SalesOverviewDAOImpl();
        this.categoryDAO = new CategoryDAOImpl();
    }
	
	@Override
	public List<SalesOverview> getCategorySalesTrend(Map<String, Object> params) {
		return salesOverviewDAO.selectCategorySalesTrend(params);
	}

	@Override
    public List<Category> getLargeCategories() throws Exception {
        return categoryDAO.selectLargeCategories();
    }
	
	// 매출지표 목록 조회 (페이징 처리 포함)
	@Override
	public Map<String, Object> getSalesStatusRows(Map<String, Object> params) throws Exception {
	    // 매출지표 목록 조회
	    List<SalesStatusRow> salesList = salesOverviewDAO.selectSalesStatusRows(params);

	    // 총 매출지표 개수 조회
	    int totalCount = salesOverviewDAO.selectSalesOverviewCount(params);

	    // 총 페이지 수 계산
	    int limit = (int) params.getOrDefault("limit", 10);
	    int totalPages = (int) Math.ceil((double) totalCount / limit);

	    // 결과 Map 구성
	    Map<String, Object> result = new HashMap<>();
	    result.put("salesList", salesList);   // 실제 데이터 목록
	    result.put("totalCount", totalCount); // 전체 개수
	    result.put("totalPages", totalPages); // 총 페이지 수

	    return result;
	}
}
