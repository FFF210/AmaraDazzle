package dao.brand2;

import dto.UploadFile;

public interface UploadFileDAO {
	
	void insertUploadFileWithAuto(UploadFile uploadFile);
    UploadFile selectUploadFileById(Long uploadFileId);
    
    // 배너 상세보기 이미지파일
    UploadFile selectFileById(Long uploadFileId) throws Exception;
}
