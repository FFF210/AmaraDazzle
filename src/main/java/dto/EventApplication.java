package dto;

import java.sql.Timestamp;

public class EventApplication {
    private Long eventApplicationId; // 신청 ID (PK, AUTO_INCREMENT)
    private Long eventId;            // 이벤트 ID (FK → event.event_id)
    private Long brandId;            // 신청 브랜드 ID (FK → brand.brand_id)
    private String managerName;      // 광고 담당자명
    private String managerTel;       // 담당자 연락처
    private String note;             // 관리자 전달용 비고
    private Timestamp applyDate;     // 신청일 (DEFAULT CURRENT_TIMESTAMP)

    public EventApplication() {
    }

    public Long getEventApplicationId() {
        return eventApplicationId;
    }
    public void setEventApplicationId(Long eventApplicationId) {
        this.eventApplicationId = eventApplicationId;
    }

    public Long getEventId() {
        return eventId;
    }
    public void setEventId(Long eventId) {
        this.eventId = eventId;
    }

    public Long getBrandId() {
        return brandId;
    }
    public void setBrandId(Long brandId) {
        this.brandId = brandId;
    }

    public String getManagerName() {
        return managerName;
    }
    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getManagerTel() {
        return managerTel;
    }
    public void setManagerTel(String managerTel) {
        this.managerTel = managerTel;
    }

    public String getNote() {
        return note;
    }
    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getApplyDate() {
        return applyDate;
    }
    public void setApplyDate(Timestamp applyDate) {
        this.applyDate = applyDate;
    }

    @Override
    public String toString() {
        return "EventApplication [eventApplicationId=" + eventApplicationId +
                ", eventId=" + eventId + ", brandId=" + brandId +
                ", managerName=" + managerName + ", managerTel=" + managerTel +
                ", note=" + note + ", applyDate=" + applyDate + "]";
    }
}
