package controller.consumer;

import java.io.IOException;
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
 * Servlet implementation class OrderList
 */
@WebServlet("/store/mypage/orderList")
public class OrderList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OrderList() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		try {
            // 1. 세션에서 회원 정보 가져오기
            HttpSession session = request.getSession();
            Long memberId = (Long) session.getAttribute("memberId");
            
            if (memberId == null) {
                // 로그인 안 된 경우 로그인 페이지로
                response.sendRedirect("/consumer/login.jsp");
                return;
            }
            
            // 2. 요청 파라미터 처리
            String startY = request.getParameter("drfStartY");
            String startM = request.getParameter("drfStartM");
            String startD = request.getParameter("drfStartD");
            String endY = request.getParameter("drfEndY");
            String endM = request.getParameter("drfEndM");
            String endD = request.getParameter("drfEndD");
            
            String pageParam = request.getParameter("page");
            int page = 1;
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            
            int pageSize = 10; // 페이지당 10개
            
            // Service 호출
            OrderService orderService = new OrderServiceImpl();
            Map<String, Object> result;
            
            // 조건부 조회
            if (startY != null && endY != null) {
                String startDateStr = startY + "-" + startM + "-" + startD + " 00:00:00";
                String endDateStr = endY + "-" + endM + "-" + endD + " 23:59:59";
                
                result = orderService.getOrderListByMember(memberId, null, startDateStr, endDateStr, page, pageSize);
            } else {
                result = orderService.getOrderListByMember(memberId, null, null, null, page, pageSize);
            }
            
            // 4. 주문 통계 정보도 가져오기 (상단 요약용)
            Map<String, Object> summary = orderService.getOrderSummaryByMember(memberId);
            
            // 5. JSP로 데이터 전달
            request.setAttribute("orderResult", result);
            request.setAttribute("orderSummary", summary);
            
            // 6. JSP로 포워드
            request.getRequestDispatcher("/consumer/orderList.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("err", "잘못된 페이지 번호입니다.");
            request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "주문 목록 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
        }
    }
}
