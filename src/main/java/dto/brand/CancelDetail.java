package dto.brand;

import java.util.List;

public class CancelDetail {
	private CancelOrderSummary summary; // 취소 요약 정보 (공통 정보)
	private List<CancelOrderItemDetail> items; // 취소 상품 상세 목록

	public CancelOrderSummary getSummary() {
		return summary;
	}

	public void setSummary(CancelOrderSummary summary) {
		this.summary = summary;
	}

	public List<CancelOrderItemDetail> getItems() {
		return items;
	}

	public void setItems(List<CancelOrderItemDetail> items) {
		this.items = items;
	}

}
