package dto.brand;

import java.util.List;

public class ReturnDetail {
	private ReturnSummary summary; // 반품 요약 정보 (공통 정보)
	private List<ReturnItemDetail> items; // 반품 상품 상세 목록

	public ReturnSummary getSummary() {
		return summary;
	}

	public void setSummary(ReturnSummary summary) {
		this.summary = summary;
	}

	public List<ReturnItemDetail> getItems() {
		return items;
	}

	public void setItems(List<ReturnItemDetail> items) {
		this.items = items;
	}

}
