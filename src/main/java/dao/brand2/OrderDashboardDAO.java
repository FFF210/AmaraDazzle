package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.brand2.OrdersDashboard;

public interface OrderDashboardDAO {
	// 오늘 매출
    OrdersDashboard selectSalesToday(Long brandId);

    // 어제 매출
    OrdersDashboard selectSalesYesterday(Long brandId);

    // 이번 주 매출
    OrdersDashboard selectSalesWeek(Long brandId);

    // 최근 30일 매출 리스트 (그래프용)
    List<OrdersDashboard> selectSalesLast30Days(Long brandId);

    // 올해 vs 전년도 월별 매출 비교
    List<OrdersDashboard> selectMonthlySalesCompare(Long brandId);
}
