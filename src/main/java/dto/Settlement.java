package dto;

import java.sql.Timestamp;

public class Settlement {
    private Long settlementId;     // 자동증가값 (PK)
    private Long brandId;        // 브랜드 ID (FK → brand.brand_id)
    private Timestamp startDate;   // 정산일자 시작일
    private Timestamp endDate;     // 정산일자 끝일
    private Long totalSales;       // 총매출
    private Long shippingCharge;   // 배송비
    private Long pCoupon;          // 플랫폼 쿠폰 사용액
    private Long bCoupon;          // 브랜드 쿠폰 사용액
    private Long point;            // 포인트
    private Long fee;              // 수수료
    private Long pureProfit;       // 순이익
    private Long finalAmount;      // 최종정산액
    private String calcedYN;       // 정산여부 (ENUM: Waiting, InProgress, Completed, Error)
    private Timestamp createdAt;   // 생성일자 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp depositedDate; // 정산완료일자
    private String writer;         // 정산책임자 (FK → admin_info.aid)

    public Settlement() {
    }

    public Long getSettlementId() {
        return settlementId;
    }
    public void setSettlementId(Long settlementId) {
        this.settlementId = settlementId;
    }

    public Long getBrandId() {
        return brandId;
    }
    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public Timestamp getStartDate() {
        return startDate;
    }
    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }
    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public Long getTotalSales() {
        return totalSales;
    }
    public void setTotalSales(Long totalSales) {
        this.totalSales = totalSales;
    }

    public Long getShippingCharge() {
        return shippingCharge;
    }
    public void setShippingCharge(Long shippingCharge) {
        this.shippingCharge = shippingCharge;
    }

    public Long getpCoupon() {
        return pCoupon;
    }
    public void setpCoupon(Long pCoupon) {
        this.pCoupon = pCoupon;
    }

    public Long getbCoupon() {
        return bCoupon;
    }
    public void setbCoupon(Long bCoupon) {
        this.bCoupon = bCoupon;
    }

    public Long getPoint() {
        return point;
    }
    public void setPoint(Long point) {
        this.point = point;
    }

    public Long getFee() {
        return fee;
    }
    public void setFee(Long fee) {
        this.fee = fee;
    }

    public Long getPureProfit() {
        return pureProfit;
    }
    public void setPureProfit(Long pureProfit) {
        this.pureProfit = pureProfit;
    }

    public Long getFinalAmount() {
        return finalAmount;
    }
    public void setFinalAmount(Long finalAmount) {
        this.finalAmount = finalAmount;
    }

    public String getCalcedYN() {
        return calcedYN;
    }
    public void setCalcedYN(String calcedYN) {
        this.calcedYN = calcedYN;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getDepositedDate() {
        return depositedDate;
    }
    public void setDepositedDate(Timestamp depositedDate) {
        this.depositedDate = depositedDate;
    }

    public String getWriter() {
        return writer;
    }
    public void setWriter(String writer) {
        this.writer = writer;
    }

    @Override
    public String toString() {
        return "Settlement [settlementId=" + settlementId + ", brandId=" + brandId +
                ", startDate=" + startDate + ", endDate=" + endDate +
                ", totalSales=" + totalSales + ", shippingCharge=" + shippingCharge +
                ", pCoupon=" + pCoupon + ", bCoupon=" + bCoupon +
                ", point=" + point + ", fee=" + fee + ", pureProfit=" + pureProfit +
                ", finalAmount=" + finalAmount + ", calcedYN=" + calcedYN +
                ", createdAt=" + createdAt + ", depositedDate=" + depositedDate +
                ", writer=" + writer + "]";
    }
}
