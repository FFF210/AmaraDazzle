package dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Orders {
    private Long ordersId;           // 고유 식별자 (PK, AUTO_INCREMENT)
    private String orderCode;        // 주문번호 (예: 20250915-001478, UNIQUE)
    private Long memberId;           // 회원 ID (FK → member.member_id)
    private String phone;            // 휴대폰 번호
    private BigDecimal subtotalAmount; // 상품금액 합계(할인 전, CHECK >= 0)
    private BigDecimal discountAmount; // 할인 금액(쿠폰, 포인트, DEFAULT 0)
    private BigDecimal shippingAmount; // 배송비 (DEFAULT 0)
    private BigDecimal totalAmount;    // 최종 결제 금액
    private String shipRecipient;    // 받는분
    private String shipPhone;        // 배송 연락처
    private String shipPostcode;     // 우편번호
    private String shipLine1;        // 주소
    private String shipLine2;        // 상세주소
    private String note;             // 배송 요청사항
    private String usingCoupon;      // 사용 쿠폰 ID (FK → member_coupon.member_coupon_id)
    private Integer usingPoint;      // 사용 포인트
    private Timestamp createdAt;     // 주문 시각 (DEFAULT CURRENT_TIMESTAMP)

    public Orders() {
    }

    public Long getOrdersId() {
        return ordersId;
    }
    public void setOrdersId(Long ordersId) {
        this.ordersId = ordersId;
    }

    public String getOrderCode() {
        return orderCode;
    }
    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public Long getMemberId() {
        return memberId;
    }
    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public BigDecimal getSubtotalAmount() {
        return subtotalAmount;
    }
    public void setSubtotalAmount(BigDecimal subtotalAmount) {
        this.subtotalAmount = subtotalAmount;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }
    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getShippingAmount() {
        return shippingAmount;
    }
    public void setShippingAmount(BigDecimal shippingAmount) {
        this.shippingAmount = shippingAmount;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getShipRecipient() {
        return shipRecipient;
    }
    public void setShipRecipient(String shipRecipient) {
        this.shipRecipient = shipRecipient;
    }

    public String getShipPhone() {
        return shipPhone;
    }
    public void setShipPhone(String shipPhone) {
        this.shipPhone = shipPhone;
    }

    public String getShipPostcode() {
        return shipPostcode;
    }
    public void setShipPostcode(String shipPostcode) {
        this.shipPostcode = shipPostcode;
    }

    public String getShipLine1() {
        return shipLine1;
    }
    public void setShipLine1(String shipLine1) {
        this.shipLine1 = shipLine1;
    }

    public String getShipLine2() {
        return shipLine2;
    }
    public void setShipLine2(String shipLine2) {
        this.shipLine2 = shipLine2;
    }

    public String getNote() {
        return note;
    }
    public void setNote(String note) {
        this.note = note;
    }

    public String getUsingCoupon() {
        return usingCoupon;
    }
    public void setUsingCoupon(String usingCoupon) {
        this.usingCoupon = usingCoupon;
    }

    public Integer getUsingPoint() {
        return usingPoint;
    }
    public void setUsingPoint(Integer usingPoint) {
        this.usingPoint = usingPoint;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Orders [ordersId=" + ordersId + ", orderCode=" + orderCode +
                ", memberId=" + memberId + ", phone=" + phone +
                ", subtotalAmount=" + subtotalAmount + ", discountAmount=" + discountAmount +
                ", shippingAmount=" + shippingAmount + ", totalAmount=" + totalAmount +
                ", shipRecipient=" + shipRecipient + ", shipPhone=" + shipPhone +
                ", shipPostcode=" + shipPostcode + ", shipLine1=" + shipLine1 +
                ", shipLine2=" + shipLine2 + ", note=" + note +
                ", usingCoupon=" + usingCoupon + ", usingPoint=" + usingPoint +
                ", createdAt=" + createdAt + "]";
    }
}
