package service.consumer;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import dto.MemberCoupon;
import dto.Point;

public interface PointService {
    
    /**
     * 회원의 포인트 내역 조회
     * @param memberId 회원 ID
     * @return 포인트 내역 리스트
     */
    List<Point> getPointHistory(Long memberId) throws Exception;
    
    /**
     * 특정 기간의 포인트 내역 조회
     * @param memberId 회원 ID, startDate 시작일, endDate 종료일
     * @return 포인트 내역 리스트
     */
    List<Point> getPointHistoryByPeriod(Long memberId, Timestamp startDate, Timestamp endDate) throws Exception;
    
    /**
     * 회원의 쿠폰 목록 조회
     * @param memberId 회원 ID
     * @return 쿠폰 목록
     */

}
