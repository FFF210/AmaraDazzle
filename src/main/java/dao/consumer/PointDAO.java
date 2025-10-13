package dao.consumer;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import dto.Point;

public interface PointDAO {
    
    // 포인트 내역 개수 조회 (페이징용)
    int countPointHistory(Long memberId) throws Exception;
	
    //회원의 포인트 내역 조회 (최근순)
    List<Map<String, Object>> selectPointHistory(Map<String, Object> params) throws Exception;

    // 특정 기간 내의 포인트 내역 개수 조회(페이징용)
    int countPointHistoryByPeriod(Map<String, Object> params) throws Exception;
        
    //특정 기간의 포인트 내역 조회
    List<Map<String, Object>> selectPointHistoryByPeriod(Map<String, Object> params) throws Exception;
}
