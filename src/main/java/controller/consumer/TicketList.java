package controller.consumer;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Ticket;
import service.consumer.TicketService;
import service.consumer.TicketServiceImpl;

/**
 * Servlet implementation class TicketList
 */
@WebServlet("/store/mypage/ticketList")
public class TicketList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TicketList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
	        
	        HttpSession session = request.getSession();
	        Long userId = (Long) session.getAttribute("memberId");
	        String userType = "CONSUMER";
	        
	        // 로그인 체크
	        if (userId == null) {
	            response.sendRedirect(request.getContextPath() + "/store/login");
	            return;
	        }
	        
	        try {
	            // 기간 필터 파라미터 (1, 3, 6, 12 개월)
	            String period = request.getParameter("period");
	            
	            Timestamp startDate = null;
	            Timestamp endDate = new Timestamp(System.currentTimeMillis());
	            
	            // 기간 계산
	            if (period != null && !period.isEmpty()) {
	                int months = Integer.parseInt(period);
	                long millisInMonth = 30L * 24 * 60 * 60 * 1000;
	                startDate = new Timestamp(System.currentTimeMillis() - (months * millisInMonth));
	            }
	            
	            // 서비스 호출
	            TicketService service = new TicketServiceImpl();
	            List<Ticket> ticketList = service.getMyTickets(userId, userType, startDate, endDate);
	            
	            // JSP로 데이터 전달
	            request.setAttribute("ticketList", ticketList);
	            request.setAttribute("selectedPeriod", period);
	            
	            request.getRequestDispatcher("/consumer/ticketList.jsp").forward(request, response);
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            request.setAttribute("err", "문의 목록 조회 오류");
	            request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
	        }
	}

}
