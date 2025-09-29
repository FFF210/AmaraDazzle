package dao.brand;

import java.util.List;
import java.util.Map;

import dto.brand.OrdersItemDetail;
import dto.brand.OrdersSummary;

public interface OrdersDAO {
	// 주문 목록 조회
	List<Map<String, Object>> selectOrdersListForBrand(Long brandId);

	// 주문 요약 조회
	OrdersSummary selectOrderSummaryForBrand(Map<String, Object> params);

	// 주문 상품 상세 조회
	List<OrdersItemDetail> selectOrderItemsForBrand(Map<String, Object> params);
}
