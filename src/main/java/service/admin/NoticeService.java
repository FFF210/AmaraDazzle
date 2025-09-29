package service.admin;

import java.util.List;

import dto.Notice;
import util.PageInfo;

public interface NoticeService {

	Long noticeSellerWrite(Notice notice_DTO) throws Exception; //seller공지 작성 
	Notice noticeSellerDetail(int num) throws Exception; //seller 공지 상세보기
	Integer noticeCount(); // seller 공지 전체 게시글 수 
	List<Notice> sellerNoticeByPage(PageInfo pageInfo); //seller공지 리스트 보기 
	

}
