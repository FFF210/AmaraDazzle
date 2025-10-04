package service.brand2;

import dao.brand2.UploadFileDAO;
import dao.brand2.UploadFileDAOImpl;
import dto.UploadFile;

public class UploadFileServiceImpl implements UploadFileService {
	private UploadFileDAO uploadFileDao = new UploadFileDAOImpl();

	@Override
	public void registerUploadFile(UploadFile uploadFile) {
		uploadFileDao.insertUploadFileWithAuto(uploadFile);
	}

	@Override
	public UploadFile getUploadFile(Long uploadFileId) {
		return uploadFileDao.selectUploadFileById(uploadFileId);
	}
}
