package dao;

import dto.UploadFile;

public interface UploadFileDAO {

	// 파일 저장
	int insertFile(UploadFile f_dto) throws Exception;

	// 저장된 파일의 id값 가져오기
	Long selectFileId(String fileRename) throws Exception;

	// 파일 id 값으로 UploadFile 객체 가져오기
	UploadFile selectFileById(Long uploadFileId) throws Exception;
}
