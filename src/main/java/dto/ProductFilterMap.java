package dto;

public class ProductFilterMap {
    private Long productFilterMapId; // 고유 식별자 (PK, AUTO_INCREMENT)
    private String productId;        // 상품 ID (FK → product.product_id)
    private Long filterId;           // 필터 코드 ID (FK → code_detail.code_detail_id)

    public ProductFilterMap() {
    }

    public Long getProductFilterMapId() {
        return productFilterMapId;
    }
    public void setProductFilterMapId(Long productFilterMapId) {
        this.productFilterMapId = productFilterMapId;
    }

    public String getProductId() {
        return productId;
    }
    public void setProductId(String productId) {
        this.productId = productId;
    }

    public Long getFilterId() {
        return filterId;
    }
    public void setFilterId(Long filterId) {
        this.filterId = filterId;
    }

    @Override
    public String toString() {
        return "ProductFilterMap [productFilterMapId=" + productFilterMapId +
                ", productId=" + productId + ", filterId=" + filterId + "]";
    }
}
