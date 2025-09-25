package enums;

public enum ProductStatus {
    ALL("전체"),        // 모든 상품 (필터링 없음)
    SALE("판매중"),     // stockQty > 0
    SOLD_OUT("품절"),   // stockQty == 0
    STOP_SALE("판매중지"); // isVisible = 1

    private final String description;

    ProductStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
