package service.brand2;

import dto.UploadFile;

public interface UploadFileService {
	void registerUploadFile(UploadFile uploadFile);

	UploadFile getUploadFile(Long uploadFileId);
}
