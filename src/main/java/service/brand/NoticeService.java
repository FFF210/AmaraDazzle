package service.brand;

import java.util.Map;

import dto.brand.NoticeList;

public interface NoticeService {
	// 공지 목록 조회
	Map<String, Object> noticeListByPage(Map<String, Object> params) throws Exception;

	// 공지 단일 조회
	NoticeList noticeDetail(long noticeId) throws Exception;
}
