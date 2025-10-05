package service.admin;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import dao.admin.NoticeDAO;
import dao.admin.NoticeDAOImpl;
import dto.Notice;
import dto.admin.SearchConditionDTO;
import util.Paging;
import util.SearchUtil;

public class NoticeServiceImpl implements NoticeService {

	private NoticeDAO n_dao;

	public NoticeServiceImpl() {
		n_dao = new NoticeDAOImpl();
	}

	private Paging m_pg = new Paging();
	private SearchUtil search = new SearchUtil();
	
	// seller공지 작성
	@Override
	public Long noticeSellerWrite(Notice notice_DTO) throws Exception {
		// 파일 pk 리스트가 null 이면 빈 리스트로 처리(NPE 방지)
		List<Long> imageFiles = notice_DTO.getImageFileIds();
		if (imageFiles == null) {
			imageFiles = Collections.emptyList();
		}

		// DB 컬럼에 맞게 매핑
		notice_DTO.setImage1FileId(imageFiles.size() > 0 ? imageFiles.get(0) : null);
		notice_DTO.setImage2FileId(imageFiles.size() > 1 ? imageFiles.get(1) : null);
		notice_DTO.setImage3FileId(imageFiles.size() > 2 ? imageFiles.get(2) : null);

		// DAO 호출
		Long noticePk = n_dao.insertNoticeSeller(notice_DTO);

		return noticePk;
	}

	// seller 공지 상세보기
	@Override
	public Notice noticeSellerDetail(int num) throws Exception {
		n_dao.viewCount(num);
		Notice notice_DTO = n_dao.noticeSellerDetail(num);

		return notice_DTO;
	}

	// seller 공지 게시글 총 개수
	@Override
	public Integer noticeCount(Map<String, String> cntMap) {
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(cntMap);
	    return n_dao.noticeCount(sc_DTO);
	}

	// seller 공지 리스트 보기
	@Override
	public List<Notice> sellerNoticeByPage(int p_no) {
		Map<String, Object> listMap = m_pg.paging(p_no);

		List<Notice> sellerNoticeList = n_dao.sellerNoticeList(listMap);
		return sellerNoticeList;
	}

	// 검색된 seller 공지 리스트
	@Override
	public List<Notice> search_post(Map<String, String> searchContent, int p_no) {
	    Map<String, Object> searchlistMap = m_pg.paging(p_no);
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(searchContent);

	    // 페이징 추가 정보 세팅
	    sc_DTO.setStart_p((Integer) searchlistMap.get("start_p"));
	    sc_DTO.setPost_ea((Integer) searchlistMap.get("post_ea"));

	    return n_dao.search_nlist(sc_DTO);
	}

	
}
