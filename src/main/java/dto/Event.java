package dto;

import java.sql.Timestamp;

public class Event {
    private Long eventId;         // 이벤트 ID (PK, AUTO_INCREMENT)
    private String eventType;     // 이벤트 유형 (COUPON, DISCOUNT, EXPERIENCE, PICK, ETC)
    private Timestamp startDate;  // 진행 시작일자
    private Timestamp endDate;    // 진행 종료일자
    private String eventName;     // 이벤트명
    private String status;        // 진행 상태 (RECRUIT, ONGOING, FINISHED)
    private Long thumbnailFileId; // 배너 이미지 파일 ID (FK → upload_file.upload_file_id)
    private Long detailFileId;    // 상세페이지 이미지 파일 ID (FK → upload_file.upload_file_id)
    private Long categoryId;      // 상품 카테고리
    private String content;       // 내용
    private Long writer;        // 작성자 (FK → admin_info.admin_info_id)
    private Integer exposeYn;     // 노출 여부 (DEFAULT 0)
    private Timestamp createdAt;  // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp updatedAt;  // 수정 시각
    private Long viewCnt;    		// 조회수 
    
    //조인용 컬럼
    private String brandName; // 브랜드명
    private String thumbFileName; //썸네일 파일리네임
    private String detailFileName;	//디테일 파일리네임

    public Event() {}
    public Event(String eventType, Timestamp startDate, Timestamp endDate, String eventName,
			Long thumbnailFileId, Long detailFileId, Long categoryId, String content, Long writer) {
		this.eventType = eventType;
		this.startDate = startDate;
		this.endDate = endDate;
		this.eventName = eventName;
		this.thumbnailFileId = thumbnailFileId;
		this.detailFileId = detailFileId;
		this.categoryId = categoryId;
		this.content = content;
		this.writer = writer;
	}


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

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	
	public Long getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(Long viewCnt) {
		this.viewCnt = viewCnt;
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
	@Override
    public String toString() {
        return "Event [eventId=" + eventId + ", eventType=" + eventType +
                ", startDate=" + startDate + ", endDate=" + endDate +
                ", eventName=" + eventName + ", status=" + status +
                ", thumbnailFileId=" + thumbnailFileId + ", detailFileId=" + detailFileId +
                ", categoryId=" + categoryId + ", content=" + content +
                ", writer=" + writer + ", exposeYn=" + exposeYn +
                ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
    }
}
