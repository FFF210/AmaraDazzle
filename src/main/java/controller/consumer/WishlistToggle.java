package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.consumer.WishlistService;
import service.consumer.WishlistServiceImpl;

/**
 * Servlet implementation class WishlistAdd
 */
@WebServlet("/store/wishlistToggle")
public class WishlistToggle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private WishlistService service = new WishlistServiceImpl();

	public WishlistToggle() {
		super();
	}

	/**
	 * 상품 찜하기 토글 (POST)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json; charset=UTF-8");

		Long memberId = (Long) request.getSession().getAttribute("memberId");

		// 로그인 여부 체크
		if (memberId == null) {
			response.getWriter().write("{\"success\":false, \"requireLogin\":true}");
			return;
		}

		Long productId = Long.valueOf(request.getParameter("productId"));

		try {
			boolean isWished = service.toggleWishlist(memberId, productId);

			response.getWriter().write("{\"success\":true, \"isWished\":" + isWished + "}");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("{\"success\":false, \"message\":\"서버 오류\"}");
		}
	}

}
