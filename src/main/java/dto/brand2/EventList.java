package dto.brand2;

import java.sql.Timestamp;

public class EventList {

    private Long eventId;          // 이벤트 ID
    private Timestamp applyDate;   // 신청일 (event_application.created_at 기준 가정)
    private Timestamp startDate;   // 이벤트 시작일
    private Timestamp endDate;     // 이벤트 종료일
    private String eventName;      // 이벤트명
    private String eventType;      // 이벤트 유형 (COUPON, DISCOUNT, ...)
    private String status;         // 이벤트 진행 상태 (RECRUIT, ONGOING, FINISHED)
    private String writer;         // 이벤트 담당자
    private String participateYn;  // 참여 여부 ("참여" / "미참여")

    // 관리 조건용 (JSP에서 분기 처리할 때 쓰임)
    private String actionType;     // 관리 버튼 상태 (상세보기, 수정, 신청하기, -)

    // ===== Getter / Setter =====

    public Long getEventId() {
        return eventId;
    }

    public void setEventId(Long eventId) {
        this.eventId = eventId;
    }

    public Timestamp getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Timestamp applyDate) {
        this.applyDate = applyDate;
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

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getParticipateYn() {
        return participateYn;
    }

    public void setParticipateYn(String participateYn) {
        this.participateYn = participateYn;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

	@Override
	public String toString() {
		return "EventList [eventId=" + eventId + ", applyDate=" + applyDate + ", startDate=" + startDate + ", endDate="
				+ endDate + ", eventName=" + eventName + ", eventType=" + eventType + ", status=" + status + ", writer="
				+ writer + ", participateYn=" + participateYn + ", actionType=" + actionType + "]";
	}
    
    
}
