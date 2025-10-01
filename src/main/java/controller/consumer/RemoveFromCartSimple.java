package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.consumer.CartItemService;
import service.consumer.CartItemServiceImpl;

/**
 * Servlet implementation class RemoveFromCartSimple
 */
@WebServlet("/removeFromCartSimple")
public class RemoveFromCartSimple extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveFromCartSimple() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        request.setCharacterEncoding("utf-8");
	        
	        try {
	            HttpSession session = request.getSession(false);
	            Long memberId = (Long) session.getAttribute("memberId");
	            Long cartItemId = Long.parseLong(request.getParameter("cartItemId"));
	            
	            CartItemService service = new CartItemServiceImpl();
	            service.removeFromCart(cartItemId, memberId);
	            
	            // 장바구니 페이지로 리다이렉트
	            response.sendRedirect("/store/mypage/cart");
	            
	        } catch(Exception e) {
	            e.printStackTrace();
	            request.setAttribute("err", "삭제 오류");
	            request.getRequestDispatcher("/error.jsp").forward(request, response);
	        }
	}

}
