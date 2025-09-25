package dto;

import java.sql.Timestamp;

public class Point {
    private Long pointId;        // 포인트 ID (PK, AUTO_INCREMENT)
    private String pointHistory; // 포인트 내역
    private String memberId;     // 회원 ID (FK → member.member_id)
    private String amount;       // 금액 (사용은 -, 적립은 +로 표기)
    private String writer;       // 포인트 지급자 (FK → admin_info.aid)
    private String orderId;      // 주문번호 (FK → orders.order_id, UNIQUE)
    private Timestamp createdAt; // 일자

    public Point() {
    }

    public Long getPointId() {
        return pointId;
    }
    public void setPointId(Long pointId) {
        this.pointId = pointId;
    }

    public String getPointHistory() {
        return pointHistory;
    }
    public void setPointHistory(String pointHistory) {
        this.pointHistory = pointHistory;
    }

    public String getMemberId() {
        return memberId;
    }
    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getAmount() {
        return amount;
    }
    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getWriter() {
        return writer;
    }
    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getOrderId() {
        return orderId;
    }
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Point [pointId=" + pointId + ", pointHistory=" + pointHistory +
                ", memberId=" + memberId + ", amount=" + amount +
                ", writer=" + writer + ", orderId=" + orderId +
                ", createdAt=" + createdAt + "]";
    }
}
