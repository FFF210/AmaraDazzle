package dto.brand;

public class SettlementSummary {

	private long currentFinalAmount; // 이번 달 정산 예정 금액
	private long currentFee; // 이번 달 수수료
	private long currentTotalSales; // 이번 달 총 주문 금액
	private long currentPureProfit; // 이번 달 순수 매출액
	private long previousFinalAmount; // 전월 정산 금액
	private long previousPureProfit; // 전월 순수 매출액
	private double profitChangeRate;// 전월 대비 순이익 증감률 (%)
	private double salesChangeRate;// 전월 대비 매출 증감률 (%)
	private int daysUntilSettlement;// 이번 달 정산 예정일까지 남은 일수
	private String brandName; // 브랜드명 (화면 표시용)

	public long getCurrentFinalAmount() {
		return currentFinalAmount;
	}

	public void setCurrentFinalAmount(long currentFinalAmount) {
		this.currentFinalAmount = currentFinalAmount;
	}

	public long getCurrentFee() {
		return currentFee;
	}

	public void setCurrentFee(long currentFee) {
		this.currentFee = currentFee;
	}

	public long getCurrentTotalSales() {
		return currentTotalSales;
	}

	public void setCurrentTotalSales(long currentTotalSales) {
		this.currentTotalSales = currentTotalSales;
	}

	public long getCurrentPureProfit() {
		return currentPureProfit;
	}

	public void setCurrentPureProfit(long currentPureProfit) {
		this.currentPureProfit = currentPureProfit;
	}

	public long getPreviousFinalAmount() {
		return previousFinalAmount;
	}

	public void setPreviousFinalAmount(long previousFinalAmount) {
		this.previousFinalAmount = previousFinalAmount;
	}

	public long getPreviousPureProfit() {
		return previousPureProfit;
	}

	public void setPreviousPureProfit(long previousPureProfit) {
		this.previousPureProfit = previousPureProfit;
	}

	public double getProfitChangeRate() {
		return profitChangeRate;
	}

	public void setProfitChangeRate(double profitChangeRate) {
		this.profitChangeRate = profitChangeRate;
	}

	public double getSalesChangeRate() {
		return salesChangeRate;
	}

	public void setSalesChangeRate(double salesChangeRate) {
		this.salesChangeRate = salesChangeRate;
	}

	public int getDaysUntilSettlement() {
		return daysUntilSettlement;
	}

	public void setDaysUntilSettlement(int daysUntilSettlement) {
		this.daysUntilSettlement = daysUntilSettlement;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

}
