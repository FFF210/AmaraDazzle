package service.brand;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand.NoticeDAO;
import dao.brand.NoticeDAOImpl;
import dto.brand.NoticeList;

public class NoticeServiceImpl implements NoticeService {

	private NoticeDAO noticeDAO;

	public NoticeServiceImpl() {
		noticeDAO = new NoticeDAOImpl();
	}

	@Override
	public Map<String, Object> noticeListByPage(Map<String, Object> params) throws Exception {
		List<NoticeList> noticeList = noticeDAO.selectNoticeList(params);

		// 총 상품 개수 조회
		int totalCount = noticeDAO.selectNoticeCount();

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 7);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("noticeList", noticeList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	@Override
	public NoticeList noticeDetail(long noticeId) throws Exception {
		return noticeDAO.selectNoticeById(noticeId);
	}

}
