package service;

import dao.UploadFileDAO;
import dao.UploadFileDAOImpl;
import dto.UploadFile;

public class UploadFileServiceImpl implements UploadFileService {
	
	private UploadFileDAO file_dao;
	public UploadFileServiceImpl() {
		file_dao = new UploadFileDAOImpl();
	}

	//파일 저장 
	@Override
	public int save_file(UploadFile f_dto) throws Exception {
		int result = file_dao.insertFile(f_dto);
		return result;
	}

	//저장된 파일의 id값 가져오기 
	@Override
	public Long select_fileId(String fileRename) throws Exception {
		Long result = file_dao.selectFileId(fileRename);
		return result;
	}

	

}
