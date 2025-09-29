package dto.brand;

import java.util.List;

public class OrdersDetail {
	private OrdersSummary summary; // 주문 요약 정보 (공통 정보)
	private List<OrdersItemDetail> items; // 주문 상품 상세 목록
	private List<OrdersCoupon> coupons; // 주문 사용 쿠폰 목록
}
