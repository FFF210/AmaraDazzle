package controller.consumer;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Orders;
import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;

/**
 * Servlet implementation class ConsumerOrderDetail
 */
@WebServlet("/store/mypage/orderDetail")
public class OrderDetailConsumer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderDetailConsumer() {
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
                response.sendRedirect("/consumer/login.jsp");
                return;
            }
            
            // 2. 요청 파라미터 처리
            String orderIdParam = request.getParameter("orderId");
            if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
                request.setAttribute("err", "올바르지 않은 주문 정보입니다.");
                request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
                return;
            }
            
            Long orderId = Long.parseLong(orderIdParam);
            
            // 3. Service 호출
            OrderService orderService = new OrderServiceImpl();
            Map<String, Object> orderDetailInfo = orderService.getOrderDetailInfo(orderId);        

           // 4. 권한 확인 (본인 주문인지 확인)
            Orders order = (Orders) orderDetailInfo.get("order"); 
            Long orderMemberId = order.getMemberId();

            if (!memberId.equals(orderMemberId)) {
                request.setAttribute("err", "접근 권한이 없습니다.");
                request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
                return;
            }
            
            // 5. JSP로 데이터 전달
            request.setAttribute("orderDetailInfo", orderDetailInfo);
            
            // 6. JSP로 포워드
            request.getRequestDispatcher("/consumer/orderDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("err", "올바르지 않은 주문 번호입니다.");
            request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "주문 상세 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
        }
    }

}
