package dto.brand;

public class SettlementDonut {
	private long discountAmount; // 쿠폰/포인트 합계
	private long pureProfit; // 순수 매출액
	private long fee; // 수수료
	private long totalSales; // 총 주문 금액

	public long getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(long discountAmount) {
		this.discountAmount = discountAmount;
	}

	public long getPureProfit() {
		return pureProfit;
	}

	public void setPureProfit(long pureProfit) {
		this.pureProfit = pureProfit;
	}

	public long getFee() {
		return fee;
	}

	public void setFee(long fee) {
		this.fee = fee;
	}

	public long getTotalSales() {
		return totalSales;
	}

	public void setTotalSales(long totalSales) {
		this.totalSales = totalSales;
	}

}
