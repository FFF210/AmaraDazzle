package service.admin;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.admin.NoticeDAO;
import dao.admin.NoticeDAOImpl;
import dto.Notice;
import dto.admin.SearchConditionDTO;
import util.Paging;

public class NoticeServiceImpl implements NoticeService {

	private NoticeDAO n_dao;

	public NoticeServiceImpl() {
		n_dao = new NoticeDAOImpl();
	}

	private Paging m_pg = new Paging();

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
	    SearchConditionDTO sc_DTO = buildSearchDTO(cntMap);
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
	    SearchConditionDTO sc_DTO = buildSearchDTO(searchContent);

	    // 페이징 추가 정보 세팅
	    sc_DTO.setStart_p((Integer) searchlistMap.get("start_p"));
	    sc_DTO.setPost_ea((Integer) searchlistMap.get("post_ea"));

	    return n_dao.search_nlist(sc_DTO);
	}

	//검색조건 DTO에 담기 
	private SearchConditionDTO buildSearchDTO(Map<String, String> paramMap) {
	    SearchConditionDTO sc_DTO = new SearchConditionDTO();

	    String s = paramMap.get("startDate");
	    String e = paramMap.get("endDate");

	    if ((s != null && !s.isEmpty()) && (e != null && !e.isEmpty())) {
	        Map<String, Timestamp> result = dateConversion(s, e);
	        sc_DTO.setStartDateTime(result.get("startLdt"));
	        sc_DTO.setEndDateTime(result.get("endExclusiveLdt"));
	    }

	    sc_DTO.setqCate_select(paramMap.get("q_select"));
	    sc_DTO.setTotalSearch(paramMap.get("totalSearch"));
	    sc_DTO.setKeyword(paramMap.get("keyword"));

	    return sc_DTO;
	}
	
	// 날짜 변환
	public Map<String, Timestamp> dateConversion(String s, String e) {
	    Map<String, Timestamp> map = new HashMap<>();
	    if ((s != null && !s.isEmpty()) && (e != null && !e.isEmpty())) {
	        LocalDate start = LocalDate.parse(s);
	        LocalDate end = LocalDate.parse(e);

	        LocalDateTime startLdt = start.atStartOfDay();
	        LocalDateTime endExclusiveLdt = end.plusDays(1).atStartOfDay();

	        map.put("startLdt", Timestamp.valueOf(startLdt));
	        map.put("endExclusiveLdt", Timestamp.valueOf(endExclusiveLdt));
	    } else {
	        map.put("startLdt", null);
	        map.put("endExclusiveLdt", null);
	    }
	    return map;
	}
}
