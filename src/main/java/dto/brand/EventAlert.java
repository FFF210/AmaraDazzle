package dto.brand;

import java.sql.Timestamp;

public class EventAlert {
	private long eventId;
	private String eventName;
	private String eventType;
	private String status;
	private Timestamp startDate;
	private Timestamp endDate;
	private Integer daysUntilStart; // 시작까지 남은 일수
	private Integer daysUntilEnd; // 종료까지 남은 일수

	public long getEventId() {
		return eventId;
	}

	public void setEventId(long eventId) {
		this.eventId = eventId;
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

	public Integer getDaysUntilStart() {
		return daysUntilStart;
	}

	public void setDaysUntilStart(Integer daysUntilStart) {
		this.daysUntilStart = daysUntilStart;
	}

	public Integer getDaysUntilEnd() {
		return daysUntilEnd;
	}

	public void setDaysUntilEnd(Integer daysUntilEnd) {
		this.daysUntilEnd = daysUntilEnd;
	}

}
