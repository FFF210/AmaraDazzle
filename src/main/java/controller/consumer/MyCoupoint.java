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
	private static final int PAGE_SIZE = 10;

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

			// ============== 1. 쿠폰 페이지 번호 받기 ==============
			String couponPageParam = request.getParameter("couponPage");
			int couponPage = 1;
			if (couponPageParam != null && !couponPageParam.isEmpty()) {
				try {
					couponPage = Integer.parseInt(couponPageParam);
					if (couponPage < 1)
						couponPage = 1;
				} catch (NumberFormatException e) {
					couponPage = 1;
				}
			}

			// ============== 2. 포인트 페이지 번호 받기 ==============
			String pointPageParam = request.getParameter("pointPage");
			int pointPage = 1;
			if (pointPageParam != null && !pointPageParam.isEmpty()) {
				try {
					pointPage = Integer.parseInt(pointPageParam);
					if (pointPage < 1)
						pointPage = 1;
				} catch (NumberFormatException e) {
					pointPage = 1;
				}
			}

			// ============== 3. 날짜 파라미터 받기 (포인트 필터용) ==============
			String startY = request.getParameter("drfStartY");
			String startM = request.getParameter("drfStartM");
			String startD = request.getParameter("drfStartD");
			String endY = request.getParameter("drfEndY");
			String endM = request.getParameter("drfEndM");
			String endD = request.getParameter("drfEndD");

			// ============== 4. 포인트 내역 조회 (기간별 또는 전체) ==============
			Map<String, Object> pointResult;

			if (startY != null && endY != null) {
				// 기간별 조회
				String startDateStr = startY + "-" + startM + "-" + startD + " 00:00:00";
				String endDateStr = endY + "-" + endM + "-" + endD + " 23:59:59";

				Timestamp startDate = Timestamp.valueOf(startDateStr);
				Timestamp endDate = Timestamp.valueOf(endDateStr);

				pointResult = pointService.getPointHistoryByPeriod(memberId, startDate, endDate, pointPage, PAGE_SIZE);
			} else {
				// 전체 조회
				pointResult = pointService.getPointHistory(memberId, pointPage, PAGE_SIZE);
			}

			// 포인트 결과 분리
			@SuppressWarnings("unchecked")
			List<Map<String, Object>> pointHistory = (List<Map<String, Object>>) pointResult.get("pointHistory");
			int pointTotalPages = (Integer) pointResult.get("totalPages");
			int pointTotalCount = (Integer) pointResult.get("totalCount");

			// ============== 5. 쿠폰 목록 조회  ==============
			Map<String, Object> couponResult = couponService.getMemberCouponList(memberId, couponPage, PAGE_SIZE);

			// 쿠폰 결과 분리
			@SuppressWarnings("unchecked")
			List<Map<String, Object>> couponList = (List<Map<String, Object>>) couponResult.get("couponList");
			int couponTotalPages = (Integer) couponResult.get("totalPages");
			int couponTotalCount = (Integer) couponResult.get("totalCount");

			// ============== 6. QueryString 생성 ==============
			// 쿠폰용 QueryString (날짜 파라미터 포함하지 않음)
			StringBuilder queryStringCoupon = new StringBuilder();
			if (pointPageParam != null) {
				queryStringCoupon.append("&pointPage=").append(pointPage);
			}
			if (startY != null)
				queryStringCoupon.append("&drfStartY=").append(startY);
			if (startM != null)
				queryStringCoupon.append("&drfStartM=").append(startM);
			if (startD != null)
				queryStringCoupon.append("&drfStartD=").append(startD);
			if (endY != null)
				queryStringCoupon.append("&drfEndY=").append(endY);
			if (endM != null)
				queryStringCoupon.append("&drfEndM=").append(endM);
			if (endD != null)
				queryStringCoupon.append("&drfEndD=").append(endD);

			// 포인트용 QueryString (쿠폰 페이지 + 날짜 파라미터)
			StringBuilder queryStringPoint = new StringBuilder();
			if (couponPageParam != null) {
				queryStringPoint.append("&couponPage=").append(couponPage);
			}
			if (startY != null)
				queryStringPoint.append("&drfStartY=").append(startY);
			if (startM != null)
				queryStringPoint.append("&drfStartM=").append(startM);
			if (startD != null)
				queryStringPoint.append("&drfStartD=").append(startD);
			if (endY != null)
				queryStringPoint.append("&drfEndY=").append(endY);
			if (endM != null)
				queryStringPoint.append("&drfEndM=").append(endM);
			if (endD != null)
				queryStringPoint.append("&drfEndD=").append(endD);

			// ============== 7. 회원 정보 조회 ==============
			Map<String, Object> memberInfo = memberDAO.selectMemberInfo(memberId);
			int couponCount = couponService.getAvailableCouponCount(memberId);

			// ============== 8. JSP로 데이터 전달 ==============
			// 회원 정보
			request.setAttribute("memberInfo", memberInfo);
			request.setAttribute("couponCount", couponCount);

			// 쿠폰 관련
			request.setAttribute("couponList", couponList);
			request.setAttribute("couponPage", couponPage);
			request.setAttribute("couponTotalPages", couponTotalPages);
			request.setAttribute("couponTotalCount", couponTotalCount);
			request.setAttribute("queryStringCoupon", queryStringCoupon.toString());

			// 포인트 관련
			request.setAttribute("pointHistory", pointHistory);
			request.setAttribute("pointPage", pointPage);
			request.setAttribute("pointTotalPages", pointTotalPages);
			request.setAttribute("pointTotalCount", pointTotalCount);
			request.setAttribute("queryStringPoint", queryStringPoint.toString());

			// 날짜 파라미터 (다시 선택된 상태로 표시)
			request.setAttribute("startY", startY);
			request.setAttribute("startM", startM);
			request.setAttribute("startD", startD);
			request.setAttribute("endY", endY);
			request.setAttribute("endM", endM);
			request.setAttribute("endD", endD);

			request.getRequestDispatcher("/consumer/myCoupoint.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "쿠폰/포인트 조회 오류: " + e.getMessage());
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
