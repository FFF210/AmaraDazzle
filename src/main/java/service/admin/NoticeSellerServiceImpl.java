package service.admin;

import java.util.List;

import dao.UploadFileDAO;
import dao.UploadFileDAOImpl;
import dao.admin.NoticeSellerDAO;
import dao.admin.NoticeSellerDAOImpl;
import dto.Notice;

public class NoticeSellerServiceImpl implements NoticeSellerService {

	private NoticeSellerDAO n_seller_dao;
	public NoticeSellerServiceImpl() {
		n_seller_dao = new NoticeSellerDAOImpl();
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
		
		int result = n_seller_dao.insertNoticeSeller(notice_DTO);
		return result;
		
	}

}
