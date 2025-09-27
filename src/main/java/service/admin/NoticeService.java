package service.admin;

import dto.Notice;

public interface NoticeService {

	Long noticeSellerWrite(Notice notice_DTO) throws Exception; //seller공지 작성 
	Notice noticeSellerDetail(int num) throws Exception; //seller 공지 상세보기

}
