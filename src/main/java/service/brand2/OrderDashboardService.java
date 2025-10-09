package service.brand2;

import java.util.List;
import java.util.Map;

import dto.brand2.OrdersDashboard;

public interface OrderDashboardService {
	// 오늘 매출
    OrdersDashboard getSalesToday(Long brandId);

    // 어제 매출
    OrdersDashboard getSalesYesterday(Long brandId);

    // 이번 주 매출
    OrdersDashboard getSalesWeek(Long brandId);

    // 최근 30일 매출 (그래프용)
    List<OrdersDashboard> getSalesLast30Days(Long brandId);

    // 올해 vs 전년도 월별 매출 비교
    List<OrdersDashboard> getMonthlySalesCompare(Long brandId);
}
