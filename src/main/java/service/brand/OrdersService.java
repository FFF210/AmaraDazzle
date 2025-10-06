package service.brand;

import java.util.List;
import java.util.Map;

import dto.brand.CancelOrderItemDetail;
import dto.brand.CancelOrderSummary;
import dto.brand.ExchangeDetail;
import dto.brand.OrdersCoupon;
import dto.brand.OrdersItemDetail;
import dto.brand.OrdersSummary;
import dto.brand.ReturnItemDetail;
import dto.brand.ReturnSummary;

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

	// ================================================================================================

	// 취소 주문 목록 조회
	Map<String, Object> cancelOrderListByPage(Map<String, Object> params) throws Exception;

	// 취소 주문 요약 조회 (단건)
	CancelOrderSummary cancelOrderSummaryDetail(Long orderId) throws Exception;

	// 취소 상품 목록 조회
	List<CancelOrderItemDetail> cancelOrderItemDetail(Long orderId) throws Exception;

	// 취소 주문 상세 (요약 + 상품) 종합 조회
	Map<String, Object> cancelOrderDetail(Long orderId) throws Exception;

	// ================================================================================================

	// 반품 주문 목록 조회
	Map<String, Object> returnOrderListByPage(Map<String, Object> params) throws Exception;

	// 반품 주문 요약 조회 (단건)
	ReturnSummary returnSummaryDetail(Long orderId) throws Exception;

	// 반품 상품 목록 조회
	List<ReturnItemDetail> returnItemDetail(Long orderId) throws Exception;

	// 반품 주문 상세 (요약 + 상품) 종합 조회
	Map<String, Object> returnDetail(Long orderId) throws Exception;

	// 반품 승인 (RETURN_APPROVED)
	void approveReturn(Long returnId) throws Exception;

	// 반품 거절
	void rejectReturn(Long returnId, String reason) throws Exception;

	// 반품 배송중 처리 (RETURN_SHIPPING)
	void shipReturn(Long returnId) throws Exception;

	// 자동 반품 완료 (RETURN_COMPLETED)
	void autoCompleteReturn(Long returnId) throws Exception;

	// ================================================================================================

	// 교환 주문 목록 조회
	Map<String, Object> exchangeOrderListByPage(Map<String, Object> params) throws Exception;

	// 교환 상세 조회
	ExchangeDetail exchangeDetail(Long exchangeId) throws Exception;

	// 교환 거절
	void rejectExchange(Long exchangeId, String rejectionReason) throws Exception;

	// 교환 승인
	void approveExchange(Long exchangeId) throws Exception;

	// 교환 배송
	void shipExchange(Long exchangeId, String shippingTrackingNo) throws Exception;

	// 교환 완료
	void autoCompleteExchange(Long exchangeId) throws Exception;
}
