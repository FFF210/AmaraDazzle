package dao.admin;

import java.util.List;
import java.util.Map;

import dto.Notice;

public interface NoticeDAO {

	Long insertNoticeSeller(Notice notice_DTO) throws Exception; //seller공지 작성 
	Notice noticeSellerDetail(int num) throws Exception; //seller 공지 상세보기
	Integer noticeCount(Map<String, String> cntMap); //seller 공지 전체 게시글 수 
	List<Notice> sellerNoticeList(Map<String, Object> listMap); //seller 공지 리스트 
	List<Notice> search_nlist(Map<String, Object> searchlistMap); //검색된 seller 공지 리스트 
	void viewCount(int num);

}
