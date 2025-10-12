package service;

import dao.UploadFileDAO;
import dao.UploadFileDAOImpl;
import dto.UploadFile;

public class UploadFileServiceImpl implements UploadFileService {

	private UploadFileDAO file_dao;

	public UploadFileServiceImpl() {
		file_dao = new UploadFileDAOImpl();
	}

	// 파일 저장
	@Override
	public int save_file(UploadFile f_dto) throws Exception {
		int result = file_dao.insertFile(f_dto);
		return result;
	}

	// 저장된 파일의 id값 가져오기
	@Override
	public Long select_fileId(String fileRename) throws Exception {
		Long result = file_dao.selectFileId(fileRename);
		return result;
	}

	// 파일 id값으로 UploadFile 객체 가져오기
	@Override
	public UploadFile selectFileById(Long uploadFileId) throws Exception {
		return file_dao.selectFileById(uploadFileId);
	}

	// ===== 파일 저장 후 생성된 ID 반환 =====
	@Override
	public Long insertFile(UploadFile f_dto) throws Exception {
		 return file_dao.insertFileAndGetId(f_dto);
	}

	//DB 파일 삭제 
	@Override
	public void deleteFile(String fRename) {
		 file_dao.deleteFile(fRename);
		
	}
}
