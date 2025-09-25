package dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Return {
    private Long returnId;           // 반품 ID (PK, AUTO_INCREMENT)
    private Long memberId;           // 회원 ID (FK → member.member_id)
    private Long ordersItemId;       // 주문 상품 ID (FK → order_item.order_item_id)
    private String reason;           // 반품 사유
    private BigDecimal shippingCost; // 배송비
    private String shippingCostPayer; // 배송비 부담 주체 (member, brand)
    private String returnCarrierName; // 회송 택배사 이름
    private String returnTrackingNo;  // 회송 운송장 번호
    private Timestamp updatedAt;      // 반품 요청/완료 시각 (DEFAULT CURRENT_TIMESTAMP)

    public Return() {
    }

    public Long getReturnId() {
        return returnId;
    }
    public void setReturnId(Long returnId) {
        this.returnId = returnId;
    }

    public Long getMemberId() {
        return memberId;
    }
    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public Long getOrdersItemId() {
        return ordersItemId;
    }
    public void setOrdersItemId(Long ordersItemId) {
        this.ordersItemId = ordersItemId;
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
        return "Return [returnId=" + returnId + ", memberId=" + memberId +
                ", ordersItemId=" + ordersItemId + ", reason=" + reason +
                ", shippingCost=" + shippingCost + ", shippingCostPayer=" + shippingCostPayer +
                ", returnCarrierName=" + returnCarrierName +
                ", returnTrackingNo=" + returnTrackingNo +
                ", updatedAt=" + updatedAt + "]";
    }
}
