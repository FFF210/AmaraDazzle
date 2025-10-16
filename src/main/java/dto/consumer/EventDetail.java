package dto.consumer;

import java.util.Date;

public class EventDetail {
	private Long eventId; // 이벤트 ID
	private String eventType; // 이벤트 유형
	private Date startDate; // 시작일자
	private Date endDate; // 종료일자
	private String eventName; // 이벤트명
	private String status; // 상태 (RECRUIT, ONGOING, FINISHED)
	private Long thumbnailFileId; // 배너 이미지 파일 ID
	private Long detailFileId; // 상세 이미지 파일 ID
	private Long categoryId; // 카테고리 ID
	private String content; // 이벤트 내용
	private Long writer; // 작성자 ID
	private Integer exposeYn; // 노출 여부
	private Date createdAt; // 생성일
	private Date updatedAt; // 수정일

	//조인용 컬럼 
	private String thumbFileName; //썸네일 파일리네임
	private String detailFileName;	//디테일 파일리네임

	public Long getEventId() {
		return eventId;
	}

	public void setEventId(Long eventId) {
		this.eventId = eventId;
	}

	public String getEventType() {
		return eventType;
	}

	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getThumbnailFileId() {
		return thumbnailFileId;
	}

	public void setThumbnailFileId(Long thumbnailFileId) {
		this.thumbnailFileId = thumbnailFileId;
	}

	public Long getDetailFileId() {
		return detailFileId;
	}

	public void setDetailFileId(Long detailFileId) {
		this.detailFileId = detailFileId;
	}

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getWriter() {
		return writer;
	}

	public void setWriter(Long writer) {
		this.writer = writer;
	}

	public Integer getExposeYn() {
		return exposeYn;
	}

	public void setExposeYn(Integer exposeYn) {
		this.exposeYn = exposeYn;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getThumbFileName() {
		return thumbFileName;
	}

	public void setThumbFileName(String thumbFileName) {
		this.thumbFileName = thumbFileName;
	}

	public String getDetailFileName() {
		return detailFileName;
	}

	public void setDetailFileName(String detailFileName) {
		this.detailFileName = detailFileName;
	}
	
}
