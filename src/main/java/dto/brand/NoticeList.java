package dto.brand;

import java.sql.Timestamp;

public class NoticeList {
	private Long noticeId;
	private Long typeId;
	private String typeName;
	private String title;
	private String content;
	private Long image1FileId;
	private Long image2FileId;
	private Long image3FileId;
	private Long docFileId;
	private String writer;
	private Long targetTypeId;
	private Long viewCnt;
	private Boolean isExposed;
	private Timestamp createdAt;
	private Timestamp updatedAt;

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

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
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

	public Long getDocFileId() {
		return docFileId;
	}

	public void setDocFileId(Long docFileId) {
		this.docFileId = docFileId;
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

	public Long getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(Long viewCnt) {
		this.viewCnt = viewCnt;
	}

	public Boolean getIsExposed() {
		return isExposed;
	}

	public void setIsExposed(Boolean isExposed) {
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

}
