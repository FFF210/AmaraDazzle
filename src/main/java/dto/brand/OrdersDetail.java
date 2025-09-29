package dto.brand;

import java.util.List;

public class OrdersDetail {
	private OrdersSummary summary; // 주문 요약 정보 (공통 정보)
	private List<OrdersItemDetail> items; // 주문 상품 상세 목록
	private List<OrdersCoupon> coupons; // 주문 사용 쿠폰 목록

	public OrdersSummary getSummary() {
		return summary;
	}

	public void setSummary(OrdersSummary summary) {
		this.summary = summary;
	}

	public List<OrdersItemDetail> getItems() {
		return items;
	}

	public void setItems(List<OrdersItemDetail> items) {
		this.items = items;
	}

	public List<OrdersCoupon> getCoupons() {
		return coupons;
	}

	public void setCoupons(List<OrdersCoupon> coupons) {
		this.coupons = coupons;
	}
}
