package dto.brand;

public class SettlementTrend {
	private String monthLabel; // 예: "2025-05"
	private long totalSales; // 총 매출
	private long fee; // 수수료
	private long pureProfit; // 순이익

	public String getMonthLabel() {
		return monthLabel;
	}

	public void setMonthLabel(String monthLabel) {
		this.monthLabel = monthLabel;
	}

	public long getTotalSales() {
		return totalSales;
	}

	public void setTotalSales(long totalSales) {
		this.totalSales = totalSales;
	}

	public long getFee() {
		return fee;
	}

	public void setFee(long fee) {
		this.fee = fee;
	}

	public long getPureProfit() {
		return pureProfit;
	}

	public void setPureProfit(long pureProfit) {
		this.pureProfit = pureProfit;
	}

}
