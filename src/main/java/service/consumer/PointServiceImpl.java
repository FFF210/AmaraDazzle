package service.consumer;

import java.sql.Timestamp;
import java.util.List;

import dao.consumer.PointDAO;
import dao.consumer.PointDAOImpl;
import dto.MemberCoupon;
import dto.Point;

public class PointServiceImpl implements PointService {

private PointDAO pointDAO;
    
    // 생성자: DAO 초기화
    public PointServiceImpl() {
        pointDAO = new PointDAOImpl();
    }


	//회원의 포인트 내역
	@Override
	public List<Point> getPointHistory(Long memberId) throws Exception {
		return pointDAO.selectPointHistory(memberId);
	}

	//특정 기간의 포인트 내역
	@Override
	public List<Point> getPointHistoryByPeriod(Long memberId, Timestamp startDate, Timestamp endDate) throws Exception {
		 return pointDAO.selectPointHistoryByPeriod(memberId, startDate, endDate);
	}




}
