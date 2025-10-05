package service.brand;

import java.util.List;
import java.util.Map;

import dto.brand.OrdersCoupon;
import dto.brand.OrdersItemDetail;
import dto.brand.OrdersSummary;

public interface OrdersService {
	// 주문 목록 조회
	Map<String, Object> ordersListByPage(Map<String, Object> params) throws Exception;

	// 주문 요약 조회 (단건)
	OrdersSummary ordersSummaryDetail(Long brandId, Long orderId) throws Exception;

	// 주문 상품 상세 조회
	List<OrdersItemDetail> ordersItemDetail(Long brandId, Long orderId) throws Exception;

	// 주문 사용 쿠폰 조회
	List<OrdersCoupon> ordersCouponDetail(Long orderId) throws Exception;

	// 주문 상세 (요약 + 상품 + 쿠폰) 종합 조회
	Map<String, Object> ordersDetail(Long brandId, Long orderId) throws Exception;

	// 취소 주문 목록 조회
	Map<String, Object> cancelOrderListByPage(Map<String, Object> params) throws Exception;

	// 반품 주문 목록 조회
	Map<String, Object> returnOrderListByPage(Map<String, Object> params) throws Exception;
}
