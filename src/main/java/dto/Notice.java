package dto;

import java.sql.Timestamp;
import java.util.List;

public class Notice {
    private Long noticeId;        // 자동증가값 (PK, AUTO_INCREMENT)
    private Long typeId;          // 공지 유형 타입 (FK → code_detail.code_detail_id)
    private String title;         // 공지 제목
    private String content;       // 공지 내용
    private Long image1FileId;    // 업로드된 이미지 파일 ID
    private Long image2FileId;    // 업로드된 이미지 파일 ID
    private Long image3FileId;    // 업로드된 이미지 파일 ID
    private String writer;        // 게시자(관리자 이름, FK → admin_info.aid)
    private Long targetTypeId;    // 노출 위치 타입 (FK → code_master.code_master_id)
    private Integer isExposed;    // 노출 여부 (tinyint, DEFAULT 1)
    private Timestamp createdAt;  // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp updatedAt;  // 수정 시각 (ON UPDATE CURRENT_TIMESTAMP)

    List<Long> imageFileIds;	//업로드된 이미지파일 id 모음 리스트 
    
   
	public Notice() {}
    public Notice(Long typeId, String title, String content, 
    				String writer, Long targetTypeId,
    				List<Long> imageFileIds) {
		this.typeId = typeId;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.targetTypeId = targetTypeId;
		this.imageFileIds = imageFileIds;
	}



    public Long getNoticeId() {
        return noticeId;
    }
    public void setNoticeId(Long noticeId) {
        this.noticeId = noticeId;
    }

    public Long getTypeId() {
        return typeId;
    }
    public void setTypeId(Long typeId) {
        this.typeId = typeId;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public Long getImage1FileId() {
        return image1FileId;
    }
    public void setImage1FileId(Long image1FileId) {
        this.image1FileId = image1FileId;
    }

    public Long getImage2FileId() {
        return image2FileId;
    }
    public void setImage2FileId(Long image2FileId) {
        this.image2FileId = image2FileId;
    }

    public Long getImage3FileId() {
        return image3FileId;
    }
    public void setImage3FileId(Long image3FileId) {
        this.image3FileId = image3FileId;
    }

    public String getWriter() {
        return writer;
    }
    public void setWriter(String writer) {
        this.writer = writer;
    }

    public Long getTargetTypeId() {
        return targetTypeId;
    }
    public void setTargetTypeId(Long targetTypeId) {
        this.targetTypeId = targetTypeId;
    }

    public Integer getIsExposed() {
        return isExposed;
    }
    public void setIsExposed(Integer isExposed) {
        this.isExposed = isExposed;
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
    
    public List<Long> getImageFileIds() {
		return imageFileIds;
	}
	public void setImageFileIds(List<Long> imageFileIds) {
		this.imageFileIds = imageFileIds;
	}

    @Override
    public String toString() {
        return "Notice [noticeId=" + noticeId + ", typeId=" + typeId +
                ", title=" + title + ", content=" + content +
                ", image1FileId=" + image1FileId + ", image2FileId=" + image2FileId +
                ", image3FileId=" + image3FileId + ", writer=" + writer +
                ", targetTypeId=" + targetTypeId + ", isExposed=" + isExposed +
                ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
    }
}
