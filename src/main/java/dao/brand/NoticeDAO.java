package dao.brand;

import java.util.List;
import java.util.Map;

import dto.brand.NoticeList;

public interface NoticeDAO {
	// 공지 목록 조회
	List<NoticeList> selectNoticeList(Map<String, Object> params) throws Exception;

	// 공지 목록 개수
	Integer selectNoticeCount() throws Exception;

	// 공지 단일 조회
	NoticeList selectNoticeById(long noticeId) throws Exception;
}
