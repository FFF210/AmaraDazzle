package dao.brand2;

import dto.UploadFile;

public interface UploadFileDAO {
	
	void insertUploadFileWithAuto(UploadFile uploadFile);
    UploadFile selectUploadFileById(Long uploadFileId);
}
