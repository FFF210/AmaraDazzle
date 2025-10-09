package service.brand2;

import java.util.List;
import java.util.Map;

import dao.brand2.OrderDashboardDAO;
import dao.brand2.OrderDashboardDAOImpl;
import dto.brand2.OrdersDashboard;

public class OrderDashboardServiceImpl implements OrderDashboardService {

	private OrderDashboardDAO orderDashboardDAO;
	
	public OrderDashboardServiceImpl() {
        this.orderDashboardDAO = new OrderDashboardDAOImpl();
    }

	
	@Override
	public OrdersDashboard getSalesToday(Long brandId) {
		return orderDashboardDAO.selectSalesToday(brandId);
	}

	@Override
	public OrdersDashboard getSalesYesterday(Long brandId) {
		return orderDashboardDAO.selectSalesYesterday(brandId);
	}

	@Override
	public OrdersDashboard getSalesWeek(Long brandId) {
		return orderDashboardDAO.selectSalesWeek(brandId);
	}

	@Override
	public List<OrdersDashboard> getSalesLast30Days(Long brandId) {
		return orderDashboardDAO.selectSalesLast30Days(brandId);
	}
	
	@Override
    public List<OrdersDashboard> getMonthlySalesCompare(Long brandId) {
        return orderDashboardDAO.selectMonthlySalesCompare(brandId);
    }
	
	// jsp
	@Override
	public Long getTotalSales(Long brandId) {
	    return orderDashboardDAO.selectTotalSales(brandId);
	}

	@Override
	public Long getLastMonthSales(Long brandId) {
	    return orderDashboardDAO.selectLastMonthSales(brandId);
	}

}
