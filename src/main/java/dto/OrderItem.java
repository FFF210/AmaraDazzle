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
    private Long memberCouponId;

    //조인용 컬럼 
    private String product_id;	//상품id
    private String product_name;	//상품명
    private String product_price;	//상품가격
    private String brand_name;	//브랜드명
    private String total_sold;	//총 판매량
    
    public OrderItem() {}

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

    
    public Long getMemberCouponId() {
		return memberCouponId;
	}

	public void setMemberCouponId(Long memberCouponId) {
		this.memberCouponId = memberCouponId;
	}
	
	public String getProduct_id() {
		return product_id;
	}

	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getProduct_price() {
		return product_price;
	}

	public void setProduct_price(String product_price) {
		this.product_price = product_price;
	}

	public String getBrand_name() {
		return brand_name;
	}

	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}

	public String getTotal_sold() {
		return total_sold;
	}

	public void setTotal_sold(String total_sold) {
		this.total_sold = total_sold;
	}

	@Override
	public String toString() {
		return "OrderItem [orderItemId=" + orderItemId + ", orderId=" + orderId + ", brandId=" + brandId
				+ ", productId=" + productId + ", optionId=" + optionId + ", unitPrice=" + unitPrice + ", quantity="
				+ quantity + ", lineSubtotal=" + lineSubtotal + ", discount=" + discount + ", total=" + total
				+ ", trackingNo=" + trackingNo + ", carrierName=" + carrierName + ", status=" + status
				+ ", memberCouponId=" + memberCouponId + "]";
	}


}
