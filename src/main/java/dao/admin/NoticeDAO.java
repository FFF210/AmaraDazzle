package dao.admin;

import java.util.List;

import dto.Notice;

public interface NoticeDAO {

	Long insertNoticeSeller(Notice notice_DTO) throws Exception; //seller공지 작성 
	Notice noticeSellerDetail(int num) throws Exception; //seller 공지 상세보기
	Integer noticeCount(); //seller 공지 전체 게시글 수 
	List<Notice> sellerNoticeList(Integer row); //seller 공지 리스트 

}
