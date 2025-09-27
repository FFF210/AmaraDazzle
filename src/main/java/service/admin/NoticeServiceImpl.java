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
	
	//seller공지 작성 
	@Override
	public Long noticeSellerWrite(Notice notice_DTO) throws Exception  {
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
	    Long noticePk = n_dao.insertNoticeSeller(notice_DTO);
	    
	    return noticePk;
	}

	//seller 공지 상세보기 
	@Override
	public Notice noticeSellerDetail(int num) throws Exception {
//		n_dao.viewCount(num);
		Notice notice_DTO = n_dao.noticeSellerDetail(num);
		
		return notice_DTO;
	}
	
	

}
