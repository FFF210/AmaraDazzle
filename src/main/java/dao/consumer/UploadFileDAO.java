package dao.consumer;

import dto.UploadFile;

public interface UploadFileDAO {
	//파일 정보를 DB에 저장하고 생성된 fileId 반환
    Long insertFile(UploadFile uploadFile) throws Exception;
    
    //fileId로 파일 정보 조회
    UploadFile selectFileById(Long fileId) throws Exception;

}
