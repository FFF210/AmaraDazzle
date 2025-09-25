package dto;

import java.sql.Timestamp;

public class UploadFile {
    private Long uploadFileId;   // 고유 식별자 (PK, AUTO_INCREMENT)
    private String fileName;     // 원본 파일명
    private String fileRename;   // 리네임 파일명 (UNIQUE)
    private String storagePath;  // 서버/스토리지 경로
    private Timestamp createdAt; // 업로드 시각 (DEFAULT CURRENT_TIMESTAMP)

    public UploadFile() {
    }

    public Long getUploadFileId() {
        return uploadFileId;
    }
    public void setUploadFileId(Long uploadFileId) {
        this.uploadFileId = uploadFileId;
    }

    public String getFileName() {
        return fileName;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileRename() {
        return fileRename;
    }
    public void setFileRename(String fileRename) {
        this.fileRename = fileRename;
    }

    public String getStoragePath() {
        return storagePath;
    }
    public void setStoragePath(String storagePath) {
        this.storagePath = storagePath;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "UploadFile [uploadFileId=" + uploadFileId + ", fileName=" + fileName +
                ", fileRename=" + fileRename + ", storagePath=" + storagePath +
                ", createdAt=" + createdAt + "]";
    }
}
