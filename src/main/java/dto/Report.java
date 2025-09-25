package dto;

import java.sql.Timestamp;

public class Report {
    private Long reportId;       // 고유 식별자 (PK)
    private String targetType;   // 신고 대상 종류 (ENUM: REVIEW, QNA)
    private Long targetId;       // 대상 ID
    private Long reporterId;     // 신고한 관리자 ID (FK → brand.brand_id)
    private String reason;       // 신고 사유
    private String status;       // 처리 상태 (ENUM: SUBMITTED, IN_REVIEW, REJECTED, APPROVED)
    private Timestamp createdAt; // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)

    public Report() {
    }

    public Long getReportId() {
        return reportId;
    }
    public void setReportId(Long reportId) {
        this.reportId = reportId;
    }

    public String getTargetType() {
        return targetType;
    }
    public void setTargetType(String targetType) {
        this.targetType = targetType;
    }

    public Long getTargetId() {
        return targetId;
    }
    public void setTargetId(Long targetId) {
        this.targetId = targetId;
    }

    public Long getReporterId() {
        return reporterId;
    }
    public void setReporterId(Long reporterId) {
        this.reporterId = reporterId;
    }

    public String getReason() {
        return reason;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Report [reportId=" + reportId + ", targetType=" + targetType +
                ", targetId=" + targetId + ", reporterId=" + reporterId +
                ", reason=" + reason + ", status=" + status +
                ", createdAt=" + createdAt + "]";
    }
}
