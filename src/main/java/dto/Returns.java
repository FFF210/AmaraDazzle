package dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Returns {
    private Long returnsId;          // 반품 ID (PK, AUTO_INCREMENT)
    private Long memberId;           // 회원 ID (FK → member.member_id)
    private Long orderId;            // 주문 ID (FK → orders.order_id)
    private Long orderItemId;        // 주문 상품 ID (FK → order_item.order_item_id)
    private Long image1FileId;       // 입증 이미지 1
    private Long image2FileId;       // 입증 이미지 2  
    private Long image3FileId;       // 입증 이미지 3
    private String rejectionReason;  // 반품 거부 사유 (브랜드의)
    private String reason;           // 반품 사유
    private BigDecimal shippingCost; // 배송비
    private String shippingCostPayer; // 배송비 부담 주체 (member, brand)
    private String returnCarrierName; // 회송 택배사 이름
    private String returnTrackingNo;  // 회송 운송장 번호
    private Timestamp updatedAt;      // 반품 요청/완료 시각 (DEFAULT CURRENT_TIMESTAMP)

    public Returns() {
    }

    public Long getReturnsId() {
        return returnsId;
    }
    public void setReturnsId(Long returnsId) {
        this.returnsId = returnsId;
    }

    public Long getMemberId() {
        return memberId;
    }
    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public Long getOrderItemId() {
        return orderItemId;
    }
    public void setOrderItemId(Long ordersItemId) {
        this.orderItemId = ordersItemId;
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

	public String getRejectionReason() {
		return rejectionReason;
	}

	public void setRejectionReason(String rejectionReason) {
		this.rejectionReason = rejectionReason;
	}

	public String getReason() {
        return reason;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }

    public BigDecimal getShippingCost() {
        return shippingCost;
    }
    public void setShippingCost(BigDecimal shippingCost) {
        this.shippingCost = shippingCost;
    }

    public String getShippingCostPayer() {
        return shippingCostPayer;
    }
    public void setShippingCostPayer(String shippingCostPayer) {
        this.shippingCostPayer = shippingCostPayer;
    }

    public String getReturnCarrierName() {
        return returnCarrierName;
    }
    public void setReturnCarrierName(String returnCarrierName) {
        this.returnCarrierName = returnCarrierName;
    }

    public String getReturnTrackingNo() {
        return returnTrackingNo;
    }
    public void setReturnTrackingNo(String returnTrackingNo) {
        this.returnTrackingNo = returnTrackingNo;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Returns [returnsId=" + returnsId + ", memberId=" + memberId +
        		", orderId" + orderId +
                ", orderItemId=" + orderItemId + 
                ", image1FileId=" + image1FileId +        
                ", image2FileId=" + image2FileId +          
                ", image3FileId=" + image3FileId +        
                ", rejectionReason=" + rejectionReason +  
                ", reason=" + reason +
                ", shippingCost=" + shippingCost + ", shippingCostPayer=" + shippingCostPayer +
                ", returnCarrierName=" + returnCarrierName +
                ", returnTrackingNo=" + returnTrackingNo +
                ", updatedAt=" + updatedAt + "]";
    }
}
