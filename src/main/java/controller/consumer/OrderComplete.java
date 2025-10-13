package controller.consumer;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;

@WebServlet("/store/orderComplete")
public class OrderComplete extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public OrderComplete() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // URL 파라미터에서 orderId 가져오기
            String orderIdStr = request.getParameter("orderId");
            
            if (orderIdStr == null || orderIdStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/consumer/error.jsp?message=주문정보없음");
                return;
            }

            Long orderId = Long.parseLong(orderIdStr);
            
            System.out.println("=== 주문 완료 페이지 ===");
            System.out.println("orderId: " + orderId);

            // 주문 정보 조회
            OrderService orderService = new OrderServiceImpl();
            Map<String, Object> orderInfo = orderService.getOrderCompleteInfo(orderId);

            // JSP로 데이터 전달
            request.setAttribute("orderInfo", orderInfo);
            request.setAttribute("orderId", orderId);

            // 주문완료 페이지로 포워드
            request.getRequestDispatcher("/consumer/orderComplete.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("잘못된 orderId 형식");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/consumer/error.jsp?message=잘못된주문번호");
        } catch (Exception e) {
            System.out.println("주문 완료 페이지 로딩 중 오류");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/consumer/error.jsp?message=" + e.getMessage());
        }
    }
}