package dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ProductOption {
	private Long productOptionId; // 고유 식별자 (PK, AUTO_INCREMENT)
	private Long productId; // 상품 ID (FK → product.product_id)
	private String optionValue; // 옵션명 (예: 01호)
	private BigDecimal price; // 옵션가
	private Integer stockQty; // 옵션 재고 수량 (DEFAULT 0)
	private Timestamp createdAt; // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)
	private Timestamp updatedAt; // 수정 시각 (ON UPDATE CURRENT_TIMESTAMP)

	public ProductOption() {
	}

	public ProductOption(Long productId, String optionValue, BigDecimal price, Integer stockQty) {
		super();
		this.productId = productId;
		this.optionValue = optionValue;
		this.price = price;
		this.stockQty = stockQty;
	}

	public Long getProductOptionId() {
		return productOptionId;
	}

	public void setProductOptionId(Long productOptionId) {
		this.productOptionId = productOptionId;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public String getOptionValue() {
		return optionValue;
	}

	public void setOptionValue(String optionValue) {
		this.optionValue = optionValue;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Integer getStockQty() {
		return stockQty;
	}

	public void setStockQty(Integer stockQty) {
		this.stockQty = stockQty;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	@Override
	public String toString() {
		return "ProductOption [productOptionId=" + productOptionId + ", productId=" + productId + ", optionValue="
				+ optionValue + ", price=" + price + ", stockQty=" + stockQty + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + "]";
	}
}
