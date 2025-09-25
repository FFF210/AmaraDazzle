package dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Exchange {
    private Long exchangeId;          // 교환 ID (PK, AUTO_INCREMENT)
    private Long memberId;            // 회원 ID (FK → member.member_id)
    private Long orderId;             // 주문 ID (FK → orders.order_id)
    private Long ordersItemId;        // 주문 상품 ID (FK → order_item.order_item_id)
    private String reason;            // 교환 사유
    private BigDecimal shippingCost;  // 배송비
    private String shippingCostPayer; // 배송비 부담 주체 (member, brand)
    private String note;              // 배송 요청사항
    private String returnCarrierName; // 회송 택배사 이름
    private String returnTrackingNo;  // 회송 운송장 번호
    private String shippingCarrierName; // 배송 택배사 이름
    private String shippingTrackingNo;  // 배송 운송장 번호
    private Timestamp updatedAt;      // 반품 요청/완료 시각 (DEFAULT CURRENT_TIMESTAMP)

    public Exchange() {
    }

    public Long getExchangeId() {
        return exchangeId;
    }
    public void setExchangeId(Long exchangeId) {
        this.exchangeId = exchangeId;
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

    public String getNote() {
        return note;
    }
    public void setNote(String note) {
        this.note = note;
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

    public String getShippingCarrierName() {
        return shippingCarrierName;
    }
    public void setShippingCarrierName(String shippingCarrierName) {
        this.shippingCarrierName = shippingCarrierName;
    }

    public String getShippingTrackingNo() {
        return shippingTrackingNo;
    }
    public void setShippingTrackingNo(String shippingTrackingNo) {
        this.shippingTrackingNo = shippingTrackingNo;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Exchange [exchangeId=" + exchangeId + ", memberId=" + memberId +
                ", orderId=" + orderId + ", ordersItemId=" + ordersItemId +
                ", reason=" + reason + ", shippingCost=" + shippingCost +
                ", shippingCostPayer=" + shippingCostPayer + ", note=" + note +
                ", returnCarrierName=" + returnCarrierName +
                ", returnTrackingNo=" + returnTrackingNo +
                ", shippingCarrierName=" + shippingCarrierName +
                ", shippingTrackingNo=" + shippingTrackingNo +
                ", updatedAt=" + updatedAt + "]";
    }
}
