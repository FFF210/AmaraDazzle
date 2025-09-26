package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ProductList {
	private Long productId;          // 상품 PK
    private String name;             // 상품명
    private String categoryPath;     // 카테고리 "대분류 > 중분류 > 소분류"
    private BigDecimal price;        // 판매가
    private BigDecimal salePrice;    // 할인가
    private String status;			 // 판매상태 
    private Integer isVisible;       // 공개 여부
    private Integer stockQty;        // 재고 수
    private Integer salesQty;        // 누적 판매 수 (JOIN/집계)
    private Integer reviewCount;     // 리뷰 수 (JOIN/집계)
    private Timestamp createdAt;     // 등록일
    
	public Long getProductId() {
		return productId;
	}
	public void setProductId(Long productId) {
		this.productId = productId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategoryPath() {
		return categoryPath;
	}
	public void setCategoryPath(String categoryPath) {
		this.categoryPath = categoryPath;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public BigDecimal getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(BigDecimal salePrice) {
		this.salePrice = salePrice;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Integer getIsVisible() {
		return isVisible;
	}
	public void setIsVisible(Integer isVisible) {
		this.isVisible = isVisible;
	}
	public Integer getStockQty() {
		return stockQty;
	}
	public void setStockQty(Integer stockQty) {
		this.stockQty = stockQty;
	}
	public Integer getSalesQty() {
		return salesQty;
	}
	public void setSalesQty(Integer salesQty) {
		this.salesQty = salesQty;
	}
	public Integer getReviewCount() {
		return reviewCount;
	}
	public void setReviewCount(Integer reviewCount) {
		this.reviewCount = reviewCount;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "ProductList [productId=" + productId + ", name=" + name + ", categoryPath=" + categoryPath + ", price="
				+ price + ", salePrice=" + salePrice + ", status=" + status + ", isVisible=" + isVisible + ", stockQty="
				+ stockQty + ", salesQty=" + salesQty + ", reviewCount=" + reviewCount + ", createdAt=" + createdAt
				+ "]";
	}
}
