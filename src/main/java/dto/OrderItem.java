package dto;

import java.math.BigDecimal;

public class OrderItem {
    private Long orderItemId;     // 주문 상품 ID (PK, AUTO_INCREMENT)
    private Long orderId;         // 주문 ID (FK → orders.orders_id)
    private Long brandId;         // 브랜드 ID (FK → brand.brand_id)
    private Long productId;       // 상품 ID (FK → product.product_id)
    private Long optionId;        // 옵션 ID (FK → product_option.product_option_id)
    private BigDecimal unitPrice; // 한 상품의 주문 금액 (CHECK >=0)
    private Integer quantity;     // 수량 (CHECK >0)
    private BigDecimal lineSubtotal; // 라인 소계 (unit_price * quantity)
    private BigDecimal discount;  // 할인 금액 (DEFAULT 0)
    private BigDecimal total;     // 최종 금액 (subtotal - discount)
    private String trackingNo;    // 운송장 번호
    private String carrierName;   // 택배사 이름
    private String status;        // 주문 상태 (PAID, PREPARING, SHIPPING, ...)

    public OrderItem() {
    }

    public Long getOrderItemId() {
        return orderItemId;
    }
    public void setOrderItemId(Long orderItemId) {
        this.orderItemId = orderItemId;
    }

    public Long getOrderId() {
        return orderId;
    }
    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Long getBrandId() {
        return brandId;
    }
    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public Long getProductId() {
        return productId;
    }
    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Long getOptionId() {
        return optionId;
    }
    public void setOptionId(Long optionId) {
        this.optionId = optionId;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }
    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Integer getQuantity() {
        return quantity;
    }
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getLineSubtotal() {
        return lineSubtotal;
    }
    public void setLineSubtotal(BigDecimal lineSubtotal) {
        this.lineSubtotal = lineSubtotal;
    }

    public BigDecimal getDiscount() {
        return discount;
    }
    public void setDiscount(BigDecimal discount) {
        this.discount = discount;
    }

    public BigDecimal getTotal() {
        return total;
    }
    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public String getTrackingNo() {
        return trackingNo;
    }
    public void setTrackingNo(String trackingNo) {
        this.trackingNo = trackingNo;
    }

    public String getCarrierName() {
        return carrierName;
    }
    public void setCarrierName(String carrierName) {
        this.carrierName = carrierName;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "OrderItem [orderItemId=" + orderItemId + ", orderId=" + orderId +
                ", brandId=" + brandId + ", productId=" + productId +
                ", optionId=" + optionId + ", unitPrice=" + unitPrice +
                ", quantity=" + quantity + ", lineSubtotal=" + lineSubtotal +
                ", discount=" + discount + ", total=" + total +
                ", trackingNo=" + trackingNo + ", carrierName=" + carrierName +
                ", status=" + status + "]";
    }
}
