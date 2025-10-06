package dto.brand;

public class DashboardSummary {
	private int todayOrderCount;
	private int refundExchangeCount;
	private int lowStockCount;
	private int badReviewCount;

	public int getTodayOrderCount() {
		return todayOrderCount;
	}

	public void setTodayOrderCount(int todayOrderCount) {
		this.todayOrderCount = todayOrderCount;
	}

	public int getRefundExchangeCount() {
		return refundExchangeCount;
	}

	public void setRefundExchangeCount(int refundExchangeCount) {
		this.refundExchangeCount = refundExchangeCount;
	}

	public int getLowStockCount() {
		return lowStockCount;
	}

	public void setLowStockCount(int lowStockCount) {
		this.lowStockCount = lowStockCount;
	}

	public int getBadReviewCount() {
		return badReviewCount;
	}

	public void setBadReviewCount(int badReviewCount) {
		this.badReviewCount = badReviewCount;
	}

}
