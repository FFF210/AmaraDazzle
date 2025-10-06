package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ExchangeDetail {
	private Long orderId; // 주문 ID
	private Long exchangeId; // 교환 ID
	private String orderCode; // 주문번호
	private Timestamp exchangeRequestDate; // 교환 요청일
	private String exchangeStatus; // 교환 상태
	private String shippingCostPayer; // 배송비 부담 주체
	private BigDecimal shippingCost; // 추가 배송비
	private String returnInvoice; // 회수 송장번호
	private String exchangeInvoice; // 교환상품 송장번호
	private String productName; // 상품명
	private String originalOptionName; // 기존 옵션명
	private int quantity; // 수량
	private String desiredOptionName; // 희망 옵션명
	private String reason; // 교환 사유
	private Long image1FileId; // 교환 이미지1
	private Long image2FileId; // 교환 이미지2
	private Long image3FileId; // 교환 이미지3
	private String stockStatus; // 재고 상태
	private String rejectionReason; // 교환 거절 사유

	public Long getExchangeId() {
		return exchangeId;
	}

	public void setExchangeId(Long exchangeId) {
		this.exchangeId = exchangeId;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public Timestamp getExchangeRequestDate() {
		return exchangeRequestDate;
	}

	public void setExchangeRequestDate(Timestamp exchangeRequestDate) {
		this.exchangeRequestDate = exchangeRequestDate;
	}

	public String getExchangeStatus() {
		return exchangeStatus;
	}

	public void setExchangeStatus(String exchangeStatus) {
		this.exchangeStatus = exchangeStatus;
	}

	public String getShippingCostPayer() {
		return shippingCostPayer;
	}

	public void setShippingCostPayer(String shippingCostPayer) {
		this.shippingCostPayer = shippingCostPayer;
	}

	public BigDecimal getShippingCost() {
		return shippingCost;
	}

	public void setShippingCost(BigDecimal shippingCost) {
		this.shippingCost = shippingCost;
	}

	public String getReturnInvoice() {
		return returnInvoice;
	}

	public void setReturnInvoice(String returnInvoice) {
		this.returnInvoice = returnInvoice;
	}

	public String getExchangeInvoice() {
		return exchangeInvoice;
	}

	public void setExchangeInvoice(String exchangeInvoice) {
		this.exchangeInvoice = exchangeInvoice;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getOriginalOptionName() {
		return originalOptionName;
	}

	public void setOriginalOptionName(String originalOptionName) {
		this.originalOptionName = originalOptionName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getDesiredOptionName() {
		return desiredOptionName;
	}

	public void setDesiredOptionName(String desiredOptionName) {
		this.desiredOptionName = desiredOptionName;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Long getImage1FileId() {
		return image1FileId;
	}

	public void setImage1FileId(Long image1FileId) {
		this.image1FileId = image1FileId;
	}

	public Long getImage2FileId() {
		return image2FileId;
	}

	public void setImage2FileId(Long image2FileId) {
		this.image2FileId = image2FileId;
	}

	public Long getImage3FileId() {
		return image3FileId;
	}

	public void setImage3FileId(Long image3FileId) {
		this.image3FileId = image3FileId;
	}

	public String getStockStatus() {
		return stockStatus;
	}

	public void setStockStatus(String stockStatus) {
		this.stockStatus = stockStatus;
	}

	public String getRejectionReason() {
		return rejectionReason;
	}

	public void setRejectionReason(String rejectionReason) {
		this.rejectionReason = rejectionReason;
	}

}
