package dto.brand2;

public class AdminToss {
    private String orderId;
    private int amount;
    private String paymentKey;
    private Long brandId;
    
    public AdminToss() {
    }
    
    // 생성자
    public AdminToss(String orderId, int amount, String paymentKey, Long brandId) {
        this.orderId = orderId;
        this.amount = amount;
        this.paymentKey = paymentKey;
        this.brandId = brandId;
    }

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getPaymentKey() {
		return paymentKey;
	}

	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
	}

	public Long getBrandId() {
		return brandId;
	}

	public void setBrandId(Long brandId) {
		this.brandId = brandId;
	}
    
    
}
