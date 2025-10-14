package controller.consumer;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;

/**
 * Servlet implementation class ExchangeReturnCancelList
 */
@WebServlet("/store/mypage/exchangeReturnCancelList")
public class ExchangeReturnCancelList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int PAGE_SIZE = 10;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ExchangeReturnCancelList() {
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

		// 로그인 체크
		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");

		if (memberId == null) {
			response.sendRedirect("/store/login");
			return;
		}

		try {
			// 페이지 번호 받기
			String pageParam = request.getParameter("page");
			int currentPage = 1; // 기본값 1페이지
			if (pageParam != null && !pageParam.isEmpty()) {
				try {
					currentPage = Integer.parseInt(pageParam);
					if (currentPage < 1) {
						currentPage = 1; // 1보다 작으면 1로
					}
				} catch (NumberFormatException e) {
					currentPage = 1; // 숫자가 아니면 1로
				}
			}

			// 날짜 필터 받아오기 (년/월/일 따로)
			String startY = request.getParameter("drfStartY");
			String startM = request.getParameter("drfStartM");
			String startD = request.getParameter("drfStartD");
			String endY = request.getParameter("drfEndY");
			String endM = request.getParameter("drfEndM");
			String endD = request.getParameter("drfEndD");

			// 날짜 조합 (YYYY-MM-DD 형식으로)
			String startDate = null;
			String endDate = null;

			if (startY != null && startM != null && startD != null) {
				startDate = String.format("%s-%02d-%02d", startY, Integer.parseInt(startM), Integer.parseInt(startD));
			}

			if (endY != null && endM != null && endD != null) {
				endDate = String.format("%s-%02d-%02d", endY, Integer.parseInt(endM), Integer.parseInt(endD));
			}

			// 취소/교환/반품 통합 목록 조회
			OrderService ordersService = new OrderServiceImpl();
			Map<String, Object> result = ordersService.getCancelExchangeReturnList(memberId, startDate, endDate,
					currentPage, PAGE_SIZE);

			@SuppressWarnings("unchecked")
			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("list");
			int totalPages = (Integer) result.get("totalPages");
			int totalCount = (Integer) result.get("totalCount");

			// 6. QueryString 생성 (페이지네이션 링크용) ✨
			StringBuilder queryString = new StringBuilder();
			if (startY != null)
				queryString.append("&drfStartY=").append(startY);
			if (startM != null)
				queryString.append("&drfStartM=").append(startM);
			if (startD != null)
				queryString.append("&drfStartD=").append(startD);
			if (endY != null)
				queryString.append("&drfEndY=").append(endY);
			if (endM != null)
				queryString.append("&drfEndM=").append(endM);
			if (endD != null)
				queryString.append("&drfEndD=").append(endD);

			// JSP로 데이터 전달
            request.setAttribute("list", list);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("queryString", queryString.toString());

            // 날짜 값 전달 (다시 선택된 상태로 표시)
            request.setAttribute("startY", startY);
            request.setAttribute("startM", startM);
            request.setAttribute("startD", startD);
            request.setAttribute("endY", endY);
            request.setAttribute("endM", endM);
            request.setAttribute("endD", endD);

			request.getRequestDispatcher("/consumer/exchangeReturnCancelList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "목록 조회 오류");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
