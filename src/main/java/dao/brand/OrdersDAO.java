package dao.brand;

import java.util.List;
import java.util.Map;

import dto.brand.CancelOrderItemDetail;
import dto.brand.CancelOrderList;
import dto.brand.CancelOrderSummary;
import dto.brand.ExchangeDetail;
import dto.brand.ExchangeOrderList;
import dto.brand.OrdersItemDetail;
import dto.brand.OrdersList;
import dto.brand.OrdersSummary;
import dto.brand.ReturnItemDetail;
import dto.brand.ReturnOrderList;
import dto.brand.ReturnSummary;

public interface OrdersDAO {
	// 주문 목록 조회
	List<OrdersList> selectOrdersListForBrand(Map<String, Object> params) throws Exception;

	// 주문 개수 조회
	Integer selectOrdersCountForBrand(Map<String, Object> params) throws Exception;

	// 주문 요약 조회
	OrdersSummary selectOrderSummaryForBrand(Map<String, Object> params) throws Exception;

	// 주문 상품 상세 조회
	List<OrdersItemDetail> selectOrderItemsForBrand(Map<String, Object> params) throws Exception;

	// ================================================================================================

	// 취소 주문 목록 조회
	List<CancelOrderList> selectCancelledOrdersList(Map<String, Object> params) throws Exception;

	// 취소 주문 개수 조회
	Integer selectCancelledOrdersCount(Map<String, Object> params) throws Exception;

	// 취소 주문 요약 조회
	CancelOrderSummary selectCancelledOrderSummaryForBrand(Map<String, Object> params) throws Exception;

	// 취소 상품 목록 조회
	List<CancelOrderItemDetail> selectCancelledOrderItemsForBrand(Map<String, Object> params) throws Exception;

	// ================================================================================================

	// 반품 주문 목록 조회
	List<ReturnOrderList> selectReturnedOrdersList(Map<String, Object> params) throws Exception;

	// 반품 주문 개수 조회
	Integer selectReturnedOrdersCount(Map<String, Object> params) throws Exception;

	// 반품 요약 조회
	ReturnSummary selectReturnSummaryForBrand(Long returnId) throws Exception;

	// 반품 상품 상세 조회
	List<ReturnItemDetail> selectReturnItemsForBrand(Long returnId) throws Exception;

	// 반품 상태 변경
	void updateReturnStatus(Map<String, Object> params) throws Exception;

	// 반품 거절 처리
	void updateReturnRejection(Map<String, Object> params) throws Exception;

	// 반품 송장 업데이트
	void updateReturnTrackingNo(Map<String, Object> params) throws Exception;

	// 반품 완료 처리
	void autoCompleteReturn(Map<String, Object> params) throws Exception;

	// ================================================================================================

	// 교환 주문 목록 조회
	List<ExchangeOrderList> selectExchangeOrdersList(Map<String, Object> params) throws Exception;

	// 교환 주문 개수 조회
	Integer selectExchangeOrdersCount(Map<String, Object> params) throws Exception;

	// 교환 상세 조회
	ExchangeDetail selectExchangeDetailForBrand(Map<String, Object> params) throws Exception;

	// 교환 거절
	void updateExchangeRejection(Map<String, Object> params) throws Exception;

	// 교환 승인
	void updateExchangeApprove(Map<String, Object> params) throws Exception;

	// 교환 배송
	void updateExchangeShipping(Map<String, Object> params) throws Exception;

	// 교환 완료
	void updateExchangeCompleted(Map<String, Object> params) throws Exception;
}
