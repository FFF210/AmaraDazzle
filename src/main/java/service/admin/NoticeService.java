package service.admin;

import java.util.List;

import dto.Notice;

public interface NoticeService {

	Long noticeSellerWrite(Notice notice_DTO) throws Exception; //seller공지 작성 
	Notice noticeSellerDetail(int num) throws Exception; //seller 공지 상세보기
	Integer noticeCount(String condition, String keyword); // seller 공지 전체 게시글 수 
	List<Notice> sellerNoticeByPage(int p_no); //seller공지 리스트 보기 
	List<Notice> search_post(String keyword, int p_no); //검색된 seller 공지 리스트 
	

}
