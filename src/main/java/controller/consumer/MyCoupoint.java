package controller.consumer;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.consumer.MemberDAO;
import dao.consumer.MemberDAOImpl;
import dto.Point;
import service.consumer.MemberCouponService;
import service.consumer.MemberCouponServiceImpl;
import service.consumer.PointService;
import service.consumer.PointServiceImpl;

/**
 * Servlet implementation class MyCoupoint
 */
@WebServlet("/store/mypage/myCoupoint")
public class MyCoupoint extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MyCoupoint() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 세션에서 로그인한 회원 ID 가져오기
		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");

		// 로그인 체크
		if (memberId == null) {
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		try {
			 // DAO/Service 생성
	        MemberDAO memberDAO = new MemberDAOImpl();
	        PointService pointService = new PointServiceImpl();
	        MemberCouponService couponService = new MemberCouponServiceImpl();
	        
	     // 날짜 파라미터 받기=====dateRangeFilter용
	        String startY = request.getParameter("drfStartY");
	        String startM = request.getParameter("drfStartM");
	        String startD = request.getParameter("drfStartD");
	        String endY = request.getParameter("drfEndY");
	        String endM = request.getParameter("drfEndM");
	        String endD = request.getParameter("drfEndD");
	        
	        List<Point> pointHistory;
	        
	        // 조건부 조회
	        if (startY != null && endY != null) {
	            String startDateStr = startY + "-" + startM + "-" + startD + " 00:00:00";
	            String endDateStr = endY + "-" + endM + "-" + endD + " 23:59:59";
	            
	            Timestamp startDate = Timestamp.valueOf(startDateStr);
	            Timestamp endDate = Timestamp.valueOf(endDateStr);
	            
	            pointHistory = pointService.getPointHistoryByPeriod(memberId, startDate, endDate);
	        } else {
	            pointHistory = pointService.getPointHistory(memberId);
	        }
	        //==================
	        
	        // 데이터 조회
	        Map<String, Object> memberInfo = memberDAO.selectMemberInfo(memberId);
	        int couponCount = couponService.getAvailableCouponCount(memberId);
	        List<Map<String, Object>> couponList = couponService.getMemberCouponList(memberId);
	        
	        // JSP로 데이터 전달
	        request.setAttribute("memberInfo", memberInfo);
	        request.setAttribute("couponCount", couponCount);
	        request.setAttribute("pointHistory", pointHistory);
	        request.setAttribute("couponList", couponList);
	        
	        request.getRequestDispatcher("/consumer/myCoupoint.jsp").forward(request, response);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("err", "쿠폰/포인트 조회 오류: " + e.getMessage());
	        request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
	    }
	}

}
