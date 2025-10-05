package service.brand2;

import java.util.Map;

public interface EventService {
	// 이벤트 목록 조회
	Map<String, Object> getEventList(Map<String, Object> params);

}
