package service.brand;

import java.util.List;
import java.util.Map;

import dto.brand.OrdersCoupon;
import dto.brand.OrdersItemDetail;
import dto.brand.OrdersSummary;

public interface OrdersService {
	// 주문 목록 조회 (브랜드별)
	List<Map<String, Object>> getOrdersListForBrand(Long brandId);

	// 주문 요약 조회 (단건)
	OrdersSummary getOrderSummaryForBrand(Long brandId, Long orderId);

	// 주문 상품 상세 조회
	List<OrdersItemDetail> getOrderItemsForBrand(Long brandId, Long orderId);

	// 주문 사용 쿠폰 조회
	List<OrdersCoupon> getOrderCouponsForBrand(Long orderId);

	// 주문 상세 (요약 + 상품 + 쿠폰) 종합 조회
	Map<String, Object> getOrderDetailForBrand(Long brandId, Long orderId);
}
