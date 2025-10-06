package service.brand;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand.CouponDAO;
import dao.brand.CouponDAOImpl;
import dao.brand.OrdersDAO;
import dao.brand.OrdersDAOImpl;
import dto.brand.CancelOrderItemDetail;
import dto.brand.CancelOrderList;
import dto.brand.CancelOrderSummary;
import dto.brand.ExchangeDetail;
import dto.brand.ExchangeOrderList;
import dto.brand.OrdersCoupon;
import dto.brand.OrdersItemDetail;
import dto.brand.OrdersList;
import dto.brand.OrdersSummary;
import dto.brand.ReturnItemDetail;
import dto.brand.ReturnOrderList;
import dto.brand.ReturnSummary;

public class OrdersServiceImpl implements OrdersService {

	private OrdersDAO ordersDAO;
	private CouponDAO couponDAO;

	public OrdersServiceImpl() {
		ordersDAO = new OrdersDAOImpl();
		couponDAO = new CouponDAOImpl();
	}

	// 주문 목록 조회
	@Override
	public Map<String, Object> ordersListByPage(Map<String, Object> params) throws Exception {
		// 주문 목록 조회
		List<OrdersList> ordersList = ordersDAO.selectOrdersListForBrand(params);

		// 총 상품 개수 조회
		int totalCount = ordersDAO.selectOrdersCountForBrand(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("ordersList", ordersList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// 주문 요약 조회 (단건)
	@Override
	public OrdersSummary ordersSummaryDetail(Long brandId, Long orderId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("brandId", brandId);
		params.put("orderId", orderId);
		return ordersDAO.selectOrderSummaryForBrand(params);
	}

	// 주문 상품 상세 조회
	@Override
	public List<OrdersItemDetail> ordersItemDetail(Long brandId, Long orderId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("brandId", brandId);
		params.put("orderId", orderId);
		return ordersDAO.selectOrderItemsForBrand(params);
	}

	// 주문 사용 쿠폰 조회
	@Override
	public List<OrdersCoupon> ordersCouponDetail(Long orderId) throws Exception {
		return couponDAO.selectOrdersCouponForBrand(orderId);
	}

	// 주문 상세 (요약 + 상품 + 쿠폰) 종합 조회
	@Override
	public Map<String, Object> ordersDetail(Long brandId, Long orderId) throws Exception {
		Map<String, Object> result = new HashMap<>();

		// 주문 요약
		OrdersSummary summary = ordersSummaryDetail(brandId, orderId);
		result.put("summary", summary);

		// 주문 상품 상세
		List<OrdersItemDetail> items = ordersItemDetail(brandId, orderId);
		result.put("items", items);

		// 주문 사용 쿠폰
		List<OrdersCoupon> coupons = ordersCouponDetail(orderId);
		result.put("coupons", coupons);

		return result;
	}

	// 취소 주문 목록 조회
	@Override
	public Map<String, Object> cancelOrderListByPage(Map<String, Object> params) throws Exception {
		List<CancelOrderList> cancelOrderList = ordersDAO.selectCancelledOrdersList(params);

		// 총 상품 개수 조회
		int totalCount = ordersDAO.selectCancelledOrdersCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("cancelOrderList", cancelOrderList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// 취소 주문 요약 조회 (단건)
	@Override
	public CancelOrderSummary cancelOrderSummaryDetail(Long orderId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("orderId", orderId);
		return ordersDAO.selectCancelledOrderSummaryForBrand(params);
	}

	// 취소 상품 목록 조회
	@Override
	public List<CancelOrderItemDetail> cancelOrderItemDetail(Long orderId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("orderId", orderId);
		return ordersDAO.selectCancelledOrderItemsForBrand(params);
	}

	// 취소 주문 상세 (요약 + 상품) 종합 조회
	@Override
	public Map<String, Object> cancelOrderDetail(Long orderId) throws Exception {
		Map<String, Object> result = new HashMap<>();

		CancelOrderSummary summary = cancelOrderSummaryDetail(orderId);
		result.put("summary", summary);

		List<CancelOrderItemDetail> items = cancelOrderItemDetail(orderId);
		result.put("items", items);

		return result;
	}

	// 반품 주문 목록 조회
	@Override
	public Map<String, Object> returnOrderListByPage(Map<String, Object> params) throws Exception {
		List<ReturnOrderList> returnOrderList = ordersDAO.selectReturnedOrdersList(params);

		// 총 상품 개수 조회
		int totalCount = ordersDAO.selectReturnedOrdersCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("returnOrderList", returnOrderList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// 반품 주문 요약 조회 (단건)
	@Override
	public ReturnSummary returnSummaryDetail(Long orderId) throws Exception {
		return ordersDAO.selectReturnSummaryForBrand(orderId);
	}

	// 반품 상품 목록 조회
	@Override
	public List<ReturnItemDetail> returnItemDetail(Long orderId) throws Exception {
		return ordersDAO.selectReturnItemsForBrand(orderId);
	}

	// 반품 주문 상세 (요약 + 상품) 종합 조회
	@Override
	public Map<String, Object> returnDetail(Long orderId) throws Exception {
		Map<String, Object> result = new HashMap<>();

		ReturnSummary summary = returnSummaryDetail(orderId);
		result.put("summary", summary);

		List<ReturnItemDetail> items = returnItemDetail(orderId);
		result.put("items", items);

		return result;
	}

	// 반품 승인 (RETURN_APPROVED)
	@Override
	public void approveReturn(Long returnId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("returnId", returnId);
		params.put("status", "RETURN_APPROVED");
		ordersDAO.updateReturnStatus(params);
	}

	// 반품 거절
	@Override
	public void rejectReturn(Long returnId, String reason) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("returnId", returnId);
		params.put("reason", reason);
		ordersDAO.updateReturnRejection(params);
	}

	// 반품 배송중 처리 (RETURN_SHIPPING)
	@Override
	public void shipReturn(Long returnId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("returnId", returnId);
		ordersDAO.updateReturnTrackingNo(params);

		Map<String, Object> params2 = new HashMap<>();
		params2.put("returnId", returnId);
		params2.put("status", "RETURN_REFUNDING");
		ordersDAO.updateReturnStatus(params2);
	}

	// 자동 반품 완료 (RETURN_COMPLETED)
	@Override
	public void autoCompleteReturn(Long returnId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("returnId", returnId);
		ordersDAO.autoCompleteReturn(params);
	}

	// 교환 주문 목록 조회
	@Override
	public Map<String, Object> exchangeOrderListByPage(Map<String, Object> params) throws Exception {
		List<ExchangeOrderList> exchangeOrderList = ordersDAO.selectExchangeOrdersList(params);

		// 총 상품 개수 조회
		int totalCount = ordersDAO.selectExchangeOrdersCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("exchangeOrderList", exchangeOrderList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// 교환 상세 조회
	@Override
	public ExchangeDetail exchangeDetail(Long exchangeId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("exchangeId", exchangeId);
		return ordersDAO.selectExchangeDetailForBrand(params);
	}

	@Override
	public void rejectExchange(Long exchangeId, String rejectionReason) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("exchangeId", exchangeId);
		params.put("rejectionReason", rejectionReason);
		ordersDAO.updateExchangeRejection(params);
	}

	@Override
	public void approveExchange(Long exchangeId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("exchangeId", exchangeId);
		ordersDAO.updateExchangeApprove(params);
	}

	@Override
	public void shipExchange(Long exchangeId, String shippingTrackingNo) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("exchangeId", exchangeId);
		params.put("shippingTrackingNo", shippingTrackingNo);
		ordersDAO.updateExchangeShipping(params);
	}

	@Override
	public void autoCompleteExchange(Long exchangeId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("exchangeId", exchangeId);
		ordersDAO.updateExchangeCompleted(params);
	}

}
