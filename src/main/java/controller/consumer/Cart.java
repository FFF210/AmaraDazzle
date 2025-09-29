package controller.consumer;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.consumer.CartItemService;
import service.consumer.CartItemServiceImpl;

/**
 * Servlet implementation class Cart
 */
@WebServlet("/store/mypage/cart")
public class Cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Cart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.setCharacterEncoding("utf-8");
        
        // 로그인 확인
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("memberId") == null) {
            response.sendRedirect(request.getContextPath() + "/consumer/login");
            return;
        }
        
        Long memberId = (Long) session.getAttribute("memberId");
        
        try {
            CartItemService service = new CartItemServiceImpl();
            
            // 장바구니 목록 조회
            List<Map<String, Object>> cartItems = service.getCartItems(memberId);
            
            // 총 금액 계산
            int totalAmount = calculateTotalAmount(cartItems);
            
            // request에 데이터 설정
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("itemCount", cartItems.size());
            
            // 장바구니 페이지로 포워드
            request.getRequestDispatcher("/consumer/cart.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "장바구니 조회 오류: " + e.getMessage());
            request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	/**
     * 장바구니 총 금액 계산
     */
    private int calculateTotalAmount(List<Map<String, Object>> cartItems) {
        int total = 0;
        
        for (Map<String, Object> item : cartItems) {
            Object finalPriceObj = item.get("finalPrice");
            Object optionPriceObj = item.get("optionPrice");
            Object quantityObj = item.get("quantity");
            
            if (finalPriceObj != null && quantityObj != null) {
                int finalPrice = 0;
                int optionPrice = 0;
                int quantity = 0;
                
                // BigDecimal 처리
                if (finalPriceObj instanceof BigDecimal) {
                    finalPrice = ((BigDecimal) finalPriceObj).intValue();
                } else if (finalPriceObj instanceof Integer) {
                    finalPrice = (Integer) finalPriceObj;
                }
                
                if (optionPriceObj instanceof BigDecimal) {
                    optionPrice = ((BigDecimal) optionPriceObj).intValue();
                } else if (optionPriceObj instanceof Integer) {
                    optionPrice = (Integer) optionPriceObj;
                }
                
                if (quantityObj instanceof Integer) {
                    quantity = (Integer) quantityObj;
                }
                
                total += (finalPrice + optionPrice) * quantity;
            }
        }
        
        return total;
    }

}
