package dao.consumer;

import java.sql.Timestamp;
import java.util.List;

import dto.Point;

public interface PointDAO {
	

    /**
     * 회원의 포인트 내역 조회 (최근순)
     * @param memberId 회원 ID
     * @return 포인트 내역 리스트
     */
    List<Point> selectPointHistory(Long memberId) throws Exception;
    
    
    /**
     * 특정 기간의 포인트 내역 조회
     * @param memberId 회원 ID, startDate 시작일, endDate 종료일
     * @return 포인트 내역 리스트
     */
    List<Point> selectPointHistoryByPeriod(Long memberId, Timestamp startDate, Timestamp endDate) throws Exception;

}
