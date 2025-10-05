package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.brand2.EventList;

public interface EventDAO {
	// 이벤트 목록 조회
	List<EventList> selectEventList(Map<String, Object> params);

	// 이벤트 개수 조회
	public Integer selectEventCount(Map<String, Object> params);
}
