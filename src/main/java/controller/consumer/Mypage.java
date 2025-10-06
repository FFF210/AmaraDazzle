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

import service.consumer.CartItemService;
import service.consumer.CartItemServiceImpl;
import service.consumer.MemberCouponService;
import service.consumer.MemberCouponServiceImpl;
import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;
import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;
import service.consumer.WishlistService;
import service.consumer.WishlistServiceImpl;

/**
 * Servlet implementation class Mypage
 */
@WebServlet("/store/mypage")
public class Mypage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Mypage() {
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

		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");

		// 로그인 체크
		if (memberId == null) {
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		try {
			// 서비스
			OrderService orderService = new OrderServiceImpl();
			MemberService memberService = new MemberServiceImpl();
			MemberCouponService couponService = new MemberCouponServiceImpl();
			WishlistService wishlistService = new WishlistServiceImpl();
			CartItemService service = new CartItemServiceImpl();
			
			//userInfo용
			Map<String, Object> memberInfo = memberService.getHeaderInfo(memberId);
			int couponCount = couponService.getAvailableCouponCount(memberId);			
			// 주문 통계 정보 가져오기 (orderStatusCard 정보)
			Map<String, Object> summary = orderService.getOrderSummaryByMember(memberId);
			// 좋아요
			List<Map<String, Object>> wishlist = wishlistService.getWishlistByMemberId(memberId);
			// 장바구니
			List<Map<String, Object>> cartItems = service.getCartItems(memberId);

			request.setAttribute("memberInfo", memberInfo);
			request.setAttribute("couponCount", couponCount);
			request.setAttribute("orderSummary", summary);
			request.setAttribute("cartItems", cartItems);
			request.setAttribute("wishlist", wishlist);

			// 마이페이지로 포워드
			request.getRequestDispatcher("/consumer/mypage.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "마이페이지 조회 오류: " + e.getMessage());
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}

	}

}
