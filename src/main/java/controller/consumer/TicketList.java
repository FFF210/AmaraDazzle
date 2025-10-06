package controller.consumer;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Calendar;
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

@WebServlet("/store/mypage/ticketList")
public class TicketList extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public TicketList() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("utf-8");
        
        HttpSession session = request.getSession();
        Long memberId = (Long) session.getAttribute("memberId");
        String userType = "CONSUMER";
        
        // 로그인 체크
        if (memberId == null) {
            response.sendRedirect(request.getContextPath() + "/store/login");
            return;
        }
        
        try {
            // dateRangeFilterBox에서 전송되는 파라미터 받기
            String startY = request.getParameter("drfStartY");
            String startM = request.getParameter("drfStartM");
            String startD = request.getParameter("drfStartD");
            String endY = request.getParameter("drfEndY");
            String endM = request.getParameter("drfEndM");
            String endD = request.getParameter("drfEndD");
            
            Timestamp startDate = null;
            Timestamp endDate = null;
            
            // 날짜 파라미터가 있으면 Timestamp로 변환
            if (startY != null && startM != null && startD != null &&
                endY != null && endM != null && endD != null) {
                
                // Calendar로 시작 날짜 생성 (00:00:00)
                Calendar startCal = Calendar.getInstance();
                startCal.set(Calendar.YEAR, Integer.parseInt(startY));
                startCal.set(Calendar.MONTH, Integer.parseInt(startM) - 1);  // 월은 0부터 시작
                startCal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(startD));
                startCal.set(Calendar.HOUR_OF_DAY, 0);
                startCal.set(Calendar.MINUTE, 0);
                startCal.set(Calendar.SECOND, 0);
                startCal.set(Calendar.MILLISECOND, 0);
                startDate = new Timestamp(startCal.getTimeInMillis());
                
                // Calendar로 종료 날짜 생성 (23:59:59)
                Calendar endCal = Calendar.getInstance();
                endCal.set(Calendar.YEAR, Integer.parseInt(endY));
                endCal.set(Calendar.MONTH, Integer.parseInt(endM) - 1);
                endCal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(endD));
                endCal.set(Calendar.HOUR_OF_DAY, 23);
                endCal.set(Calendar.MINUTE, 59);
                endCal.set(Calendar.SECOND, 59);
                endCal.set(Calendar.MILLISECOND, 999);
                endDate = new Timestamp(endCal.getTimeInMillis());
            }
            
            // 서비스 호출
            TicketService service = new TicketServiceImpl();
            List<Ticket> ticketList = service.getMyTickets(memberId, userType, startDate, endDate);
            
            // JSP로 데이터 전달
            request.setAttribute("ticketList", ticketList);
            
            request.getRequestDispatcher("/consumer/ticketList.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "문의 목록 조회 오류");
            request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
        }
    }
}