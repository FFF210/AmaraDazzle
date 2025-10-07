package dto.brand2;

import java.sql.Timestamp;

public class EventList {

	private Long eventId; // 이벤트 ID (event.event_id)
	private Long brandId; // 브랜드 ID (event_application.brand_id)
	private Timestamp applyDate; // 신청일 (event_application.apply_date)
	private Timestamp startDate; // 이벤트 시작일 (event.start_date)
	private Timestamp endDate; // 이벤트 종료일 (event.end_date)
	private String eventName; // 이벤트명 (event.event_name)
	private String eventType; // 이벤트 유형 (event.event_type)
	private String status; // 이벤트 진행 상태 (event.status)
	private String managerName; // 담당자 이름 (event_application.manager_name)
	private String managerTel; // 담당자 연락처 (event_application.manager_tel)
	private String note; // 비고 (event_application.note) ← 필요하면 추가
	private String canApply; // 신청 가능 여부 ("Y" / "N")

	// 참여 여부 ("참여" / "미참여")
	// -> DB에 없으니 XML에서 CASE WHEN으로 넣어도 되고, Service에서 가공해도 됨
	private String participateYn;

	// JSP에서 버튼 상태 제어용
	private String actionType;

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

	public String getCanApply() {
		return canApply;
	}

	public void setCanApply(String canApply) {
		this.canApply = canApply;
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
		return "EventList [eventId=" + eventId + ", brandId=" + brandId + ", applyDate=" + applyDate + ", startDate="
				+ startDate + ", endDate=" + endDate + ", eventName=" + eventName + ", eventType=" + eventType
				+ ", status=" + status + ", managerName=" + managerName + ", managerTel=" + managerTel + ", note="
				+ note + ", canApply=" + canApply + ", participateYn=" + participateYn + ", actionType=" + actionType
				+ "]";
	}

}
