package service.admin;

import java.util.Collections;
import java.util.List;

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
		 //파일 pk 리스트가 null 이면 빈 리스트로 처리(NPE 방지)
	    List<Long> imageFiles = notice_DTO.getImageFileIds();
	    if (imageFiles == null) {
	        imageFiles = Collections.emptyList();
	    }

	    //DB 컬럼에 맞게 매핑
	    notice_DTO.setImage1FileId(imageFiles.size() > 0 ? imageFiles.get(0) : null);
	    notice_DTO.setImage2FileId(imageFiles.size() > 1 ? imageFiles.get(1) : null);
	    notice_DTO.setImage3FileId(imageFiles.size() > 2 ? imageFiles.get(2) : null);

	    //DAO 호출
	    int result = n_dao.insertNoticeSeller(notice_DTO);
	    
	    return result;
		
	}

}
