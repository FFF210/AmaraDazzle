package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.OrderItem;
import dto.Orders;

public interface OrderDAO {

	// 주문용 상품 정보 조회 (상품상세페이지에서 바로 주문할 때) - 상품 기본 정보 + 브랜드명 + 할인 정보
	// @param productId 상품 ID
	// @return 상품 정보 Map (상품명, 가격, 브랜드명, 할인 정보 등)
	Map<String, Object> getProductForDirectOrder(Long productId) throws Exception;

	// 상품 옵션 정보 조회 - 옵션이 있는 상품의 특정 옵션 정보
	// @param optionId 옵션 ID
	// @return 옵션 정보 Map (옵션명, 옵션가격, 재고 등)
	Map<String, Object> getProductOptionInfo(Long optionId) throws Exception;

	// 주문 코드 자동 생성 - 형식: YYYYMMDD-XXXXXX (예: 20250915-000001)
	// @return 주문 코드 생성
	String generateOrderCode() throws Exception;

	// 새로운 주문 생성 - orders 테이블에 주문 정보 저장
	// @param order 주문 정보 객체
	// @return 생성 성공 시 1, 실패 시 0
	void createOrder(Orders order) throws Exception;

	// 주문 상품 추가 - order_item 테이블에 주문 상품 정보 저장
	// @param orderItem 주문 상품 정보 객체
	// @return 생성 성공 시 1, 실패 시 0
	void createOrderItem(OrderItem orderItem) throws Exception;

	// 주문 정보 조회- 주문 완료 후 확인용=======현재는 미사용할 듯 (혹시 몰라 남겨둠...)
	// @param ordersId 주문 ID
	// @return Orders 객체
	Orders getOrderById(Long ordersId) throws Exception;

	// 주문 상품 목록 조회 (기본 정보만) - 특정 주문의 모든 상품 목록
	// @param orderId 주문 ID
	// @return 주문 상품 리스트
	List<OrderItem> getOrderItemsByOrderId(Long orderId) throws Exception;

	// 주문 상품 상세 정보 조회 (상품명, 브랜드명, 옵션명 포함)- 주문 완료 페이지에서 보여줄 상세 정보
	// @param orderId 주문 ID
	// @return 주문 상품 상세 정보 리스트 (Map 형태)
	List<Map<String, Object>> getOrderItemsWithProductInfo(Long orderId) throws Exception;

	
// ==================== 주문/배송 조회(orderList) 페이지용 ====================

	 //고객의 주문 상품 목록 조회 (기간 필터링, 페이징) - 마이페이지 주문/배송 조회용
	 //@param params Map (memberId, startDate, endDate, limit, offset)
	 //@return 주문 상품 상세 정보 리스트 (주문정보 + 상품정보 + 브랜드정보 포함)
	List<Map<String, Object>> getOrderItemsByMemberWithPeriod(Map<String, Object> params) throws Exception;


	 //고객의 주문 상품 총 개수 조회 (페이징용) - 기간 필터링 적용
	 //@param params Map (memberId, startDate, endDate)
	 //@return 총 주문 상품 개수
	int getOrderItemCountByMember(Map<String, Object> params) throws Exception;
	
	// orderStatusCard 반영 용도
	Map<String, Object> getOrderStatusCountByMember(Long memberId) throws Exception;
}
