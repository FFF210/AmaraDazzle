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
    private Long docFileId;    		// 업로드된 문서 파일 ID
    private String writer;        // 게시자(관리자 이름, FK → admin_info.aid)
    private Long viewCnt;    		// 조회수 
    private Long targetTypeId;    // 노출 위치 타입 (FK → code_master.code_master_id)
    private Integer isExposed;    // 노출 여부 (tinyint, DEFAULT 1)
    private Timestamp createdAt;  // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp updatedAt;  // 수정 시각 (ON UPDATE CURRENT_TIMESTAMP)

    List<Long> imageFileIds;	//업로드된 이미지파일 id(pk) 모음 리스트 
    
    //join용 컬럼 
    private String name; //CodeDetail - 한글 코드 이름 (view 용)
    private String aname; //admin_info.aname
    
    private String fileName,image1FileName,image2FileName,image3FileName;     //UploadFile - 원본 파일명
    private String fileRename, image1FileRename, image2FileRename, image3FileRename;   //UploadFile - 리네임 파일명 (UNIQUE)
    private String storagePath, image1StoragePath, image2StoragePath, image3StoragePath;	 //UploadFile - 서버/스토리지 경로
   
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
	public Notice(Long typeId, String title, String content, String writer, Long targetTypeId,
			List<Long> imageFileIds, Long noticeId) {
		this.typeId = typeId;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.targetTypeId = targetTypeId;
		this.imageFileIds = imageFileIds;
		this.noticeId = noticeId;
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
	public Long getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(Long viewCnt) {
		this.viewCnt = viewCnt;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getImage1FileName() {
		return image1FileName;
	}
	public void setImage1FileName(String image1FileName) {
		this.image1FileName = image1FileName;
	}
	public String getImage2FileName() {
		return image2FileName;
	}
	public void setImage2FileName(String image2FileName) {
		this.image2FileName = image2FileName;
	}
	public String getImage3FileName() {
		return image3FileName;
	}
	public void setImage3FileName(String image3FileName) {
		this.image3FileName = image3FileName;
	}
	public String getFileRename() {
		return fileRename;
	}
	public void setFileRename(String fileRename) {
		this.fileRename = fileRename;
	}
	public String getImage1FileRename() {
		return image1FileRename;
	}
	public void setImage1FileRename(String image1FileRename) {
		this.image1FileRename = image1FileRename;
	}
	public String getImage2FileRename() {
		return image2FileRename;
	}
	public void setImage2FileRename(String image2FileRename) {
		this.image2FileRename = image2FileRename;
	}
	public String getImage3FileRename() {
		return image3FileRename;
	}
	public void setImage3FileRename(String image3FileRename) {
		this.image3FileRename = image3FileRename;
	}
	public String getStoragePath() {
		return storagePath;
	}
	public void setStoragePath(String storagePath) {
		this.storagePath = storagePath;
	}
	public String getImage1StoragePath() {
		return image1StoragePath;
	}
	public void setImage1StoragePath(String image1StoragePath) {
		this.image1StoragePath = image1StoragePath;
	}
	public String getImage2StoragePath() {
		return image2StoragePath;
	}
	public void setImage2StoragePath(String image2StoragePath) {
		this.image2StoragePath = image2StoragePath;
	}
	public String getImage3StoragePath() {
		return image3StoragePath;
	}
	public void setImage3StoragePath(String image3StoragePath) {
		this.image3StoragePath = image3StoragePath;
	}
	public String getAname() {
		return aname;
	}
	public void setAname(String aname) {
		this.aname = aname;
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
