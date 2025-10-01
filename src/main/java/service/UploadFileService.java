package service;

import dto.UploadFile;

public interface UploadFileService {

	// 파일 저장
	int save_file(UploadFile f_dto) throws Exception;

	// 저장된 파일의 id값 가져오기
	Long select_fileId(String fileRename) throws Exception;

	// 파일 id값으로 UploadFile 객체 가져오기
	UploadFile selectFileById(Long uploadFileId) throws Exception;
}
