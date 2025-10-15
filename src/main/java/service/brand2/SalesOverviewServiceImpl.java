package service.brand2;

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
	
	@Override
    public List<SalesStatusRow> getSalesStatusRows(Map<String, Object> params) {
        return salesOverviewDAO.selectSalesStatusRows(params);
    }
}
