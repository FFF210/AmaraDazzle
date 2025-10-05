package service.brand2;

import dto.UploadFile;

public interface UploadFileService {
	void registerUploadFile(UploadFile uploadFile);

	UploadFile getUploadFile(Long uploadFileId);
	
	// 배너 상세보기 업로드파일
	UploadFile getFileById(Long uploadFileId) throws Exception;
}
