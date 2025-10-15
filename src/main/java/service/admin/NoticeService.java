package service.admin;

import java.util.List;
import java.util.Map;

import dto.Notice;

public interface NoticeService {

	Long noticeSellerWrite(Notice notice_DTO) throws Exception; //seller 공지 작성 
	Notice noticeSellerDetail(int num) throws Exception; //seller 공지 상세보기
	Integer noticeCount(Map<String, String> searchContent); // seller 공지 전체 게시글 수 
	List<Notice> sellerNoticeByPage(int p_no); //seller 공지 리스트 보기 
	List<Notice> search_post(Map<String, String> searchContent, int p_no); //검색된 seller 공지 리스트 
	int noticeSellerEdit(Notice notice_DTO); // seller 공지 수정 
	int noticeSellerDelete(Long num); //seller 공지 삭제 
	int noticeExposeChange(Long num); //게시상태 변경 
	

}
