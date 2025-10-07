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
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExchangeReturnCancelList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.setCharacterEncoding("utf-8");
		
		// 로그인 체크
		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");
		
		if (memberId == null) {
			response.sendRedirect("/store/login");
			return;
		}
		
		try {
			// 날짜 필터 받아오기 (선택적)
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			
			// 취소/교환/반품 통합 목록 조회
			OrderService ordersService = new OrderServiceImpl();
			List<Map<String, Object>> list = ordersService.getCancelExchangeReturnList(memberId, startDate, endDate);
			
			// JSP로 데이터 전달
			request.setAttribute("list", list);
			request.getRequestDispatcher("/consumer/exchangeReturnCancelList.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "목록 조회 오류");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
