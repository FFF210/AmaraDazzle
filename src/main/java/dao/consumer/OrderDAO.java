package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.OrderItem;
import dto.Orders;

public interface OrderDAO {

	// 주문용 상품 정보 조회 (상품상세페이지에서 바로 주문할 때) - 상품 기본 정보 + 브랜드명 + 할인 정보
	Map<String, Object> getProductForDirectOrder(Long productId) throws Exception;

	// 상품 옵션 정보 조회 - 옵션이 있는 상품의 특정 옵션 정보
	Map<String, Object> getProductOptionInfo(Long optionId) throws Exception;

	// 주문 코드 자동 생성 - 형식: YYYYMMDD-XXXXXX (예: 20250915-000001)
	String generateOrderCode() throws Exception;

	// 새로운 주문 생성 - orders 테이블에 주문 정보 저장
	void createOrder(Orders order) throws Exception;

	// 주문 상품 추가 - order_item 테이블에 주문 상품 정보 저장
	void createOrderItem(OrderItem orderItem) throws Exception;

	// 주문 정보 조회- 주문 완료 후 확인용=======현재는 미사용할 듯 (혹시 몰라 남겨둠...)
	Orders getOrderById(Long ordersId) throws Exception;

	// 주문 상품 목록 조회 (기본 정보만) - 특정 주문의 모든 상품 목록
	List<OrderItem> getOrderItemsByOrderId(Long orderId) throws Exception;

	// 주문 상품 상세 정보 조회 (상품명, 브랜드명, 옵션명 포함)- 주문 완료 페이지에서 보여줄 상세 정보
	List<Map<String, Object>> getOrderItemsWithProductInfo(Long orderId) throws Exception;

	
// ==================== 주문/배송 조회(orderList) 페이지용 ====================

	 //고객의 주문 상품 목록 조회 (기간 필터링, 페이징) - 마이페이지 주문/배송 조회용
	List<Map<String, Object>> getOrderItemsByMemberWithPeriod(Map<String, Object> params) throws Exception;

	 //고객의 주문 상품 총 개수 조회 (페이징용) - 기간 필터링 적용
	int getOrderItemCountByMember(Map<String, Object> params) throws Exception;
	
	// orderStatusCard 반영 용도
	Map<String, Object> getOrderStatusCountByMember(Long memberId) throws Exception;

	// 주문 상품의 상태 업데이트 용도
	void updateOrderItemStatus(Long orderItemId, String status) throws Exception;
	
	// 주문 아이템 상태 조회
	String getOrderItemStatus(Long orderItemId) throws Exception;

	// 주문 아이템 취소
	int cancelOrderItem(Long orderItemId) throws Exception;
	
	// 재고 복구 (옵션)
	void restoreOptionStock(Long orderItemId) throws Exception;

	// 재고 복구 (일반)
	void restoreProductStock(Long orderItemId) throws Exception;
	
	// ================ 취소/교환/반품 페이지용 통합 목록 조회 ==========================
	List<Map<String, Object>> selectCancelExchangeReturnList(Map<String, Object> params);
	
	// ========== 교환/반품 신청용
	Map<String, Object> getOrderItemForApply(Long orderItemId) throws Exception;
}
