package service.admin;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.admin.NoticeDAO;
import dao.admin.NoticeDAOImpl;
import dto.Notice;
import util.PageInfo;
import util.Paging;

public class NoticeServiceImpl implements NoticeService {

	private NoticeDAO n_dao;
	public NoticeServiceImpl() {
		n_dao = new NoticeDAOImpl();
	}
	
	private Paging m_pg = new Paging();
	
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
		n_dao.viewCount(num);
		Notice notice_DTO = n_dao.noticeSellerDetail(num);
		
		return notice_DTO;
	}

	//seller 공지 게시글 총 개수 
	@Override
	public Integer noticeCount(String condition, String keyword) {
		Map<String, String> cntMap = new HashMap<String, String>();
		
		if(condition.equals("search")) { //검색어가 있는 경우 
			cntMap.put("part", "search");
			cntMap.put("keyword", keyword);
			
		}else { // 검색어가 없는 경우 
			cntMap.put("part", "total");
		}
				
		Integer sellerNoticeCnt = n_dao.noticeCount(cntMap); //전체 게시글 수 
		return sellerNoticeCnt;
	}
	
	//seller 공지 리스트 보기 
	@Override
	public List<Notice> sellerNoticeByPage(int p_no)  {
		Map<String, Object> listMap = m_pg.paging(p_no); 
		
		List<Notice> sellerNoticeList = n_dao.sellerNoticeList(listMap);
		return sellerNoticeList;
	}

	//검색된 seller 공지 리스트 
	@Override
	public List<Notice> search_post(String keyword, int p_no) {
		Map<String, Object> searchlistMap = m_pg.paging(p_no);
		searchlistMap.put("keyword" , keyword);  //map에 검색어 추가  

		List<Notice> search_nlist = n_dao.search_nlist(searchlistMap);
		return search_nlist;
	}


	
	
	

}
