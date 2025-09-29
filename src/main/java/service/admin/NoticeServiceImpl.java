package service.admin;

import java.util.List;

import dao.UploadFileDAO;
import dao.UploadFileDAOImpl;
import dao.admin.NoticeDAO;
import dao.admin.NoticeDAOImpl;
import dto.Notice;

public class NoticeServiceImpl implements NoticeService {

	private NoticeDAO n_dao;
	public NoticeServiceImpl() {
		n_dao = new NoticeDAOImpl();
	}
	
	@Override
	public int noticeSellerWrite(Notice notice_DTO) throws Exception  {
		List<Long> imageFiles = notice_DTO.getImageFileIds();
		
		Long img1 = imageFiles.size() > 0 ? imageFiles.get(0) : null;
		Long img2 = imageFiles.size() > 1 ? imageFiles.get(1) : null;
		Long img3 = imageFiles.size() > 2 ? imageFiles.get(2) : null;

		// DTO 컬럼에 세팅
		notice_DTO.setImage1FileId(img1);
		notice_DTO.setImage2FileId(img2);
		notice_DTO.setImage3FileId(img3);
		
		int result = n_dao.insertNoticeSeller(notice_DTO);
		return result;
		
	}

}
