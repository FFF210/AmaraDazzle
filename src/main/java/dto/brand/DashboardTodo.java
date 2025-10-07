package dto.brand;

public class DashboardTodo {
	private int paidOrderCount;
	private int preparingOrderCount;
	private int returnRequestedCount;
	private int exchangeRequestedCount;
	private int unansweredInquiryCount;

	public int getPaidOrderCount() {
		return paidOrderCount;
	}

	public void setPaidOrderCount(int paidOrderCount) {
		this.paidOrderCount = paidOrderCount;
	}

	public int getPreparingOrderCount() {
		return preparingOrderCount;
	}

	public void setPreparingOrderCount(int preparingOrderCount) {
		this.preparingOrderCount = preparingOrderCount;
	}

	public int getReturnRequestedCount() {
		return returnRequestedCount;
	}

	public void setReturnRequestedCount(int returnRequestedCount) {
		this.returnRequestedCount = returnRequestedCount;
	}

	public int getExchangeRequestedCount() {
		return exchangeRequestedCount;
	}

	public void setExchangeRequestedCount(int exchangeRequestedCount) {
		this.exchangeRequestedCount = exchangeRequestedCount;
	}

	public int getUnansweredInquiryCount() {
		return unansweredInquiryCount;
	}

	public void setUnansweredInquiryCount(int unansweredInquiryCount) {
		this.unansweredInquiryCount = unansweredInquiryCount;
	}

}
