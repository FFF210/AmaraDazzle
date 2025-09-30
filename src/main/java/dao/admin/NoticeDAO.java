package dao.admin;

import java.util.List;
import java.util.Map;

import dto.Notice;
import dto.admin.SearchConditionDTO;

public interface NoticeDAO {

	Long insertNoticeSeller(Notice notice_DTO) throws Exception; //seller공지 작성 
	Notice noticeSellerDetail(int num) throws Exception; //seller 공지 상세보기
	Integer noticeCount(SearchConditionDTO sc_DTO); //seller 공지 전체 게시글 수 
	List<Notice> sellerNoticeList(Map<String, Object> listMap); //seller 공지 리스트 
	List<Notice> search_nlist(SearchConditionDTO sc_DTO); //검색된 seller 공지 리스트 
	void viewCount(int num);

}
