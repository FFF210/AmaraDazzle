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

import service.consumer.BrandFollowService;
import service.consumer.BrandFollowServiceImpl;
import service.consumer.WishlistService;
import service.consumer.WishlistServiceImpl;
import util.PriceCalculator;

/**
 * Servlet implementation class Like
 */
@WebServlet("/store/mypage/like")
public class Like extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Like() {
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
			 // 페이지 파라미터
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            int pageSize = 12; // 한 페이지에 12개
            
            // 탭 파라미터 
            String tabParam = request.getParameter("tab");
            String activeTab = (tabParam != null) ? tabParam : "0"; // 기본값 상품 탭
            
			// 위시리스트 서비스
			WishlistService wishlistService = new WishlistServiceImpl();
			List<Map<String, Object>> wishlist = wishlistService.getWishlistByMemberIdWithPaging(memberId, currentPage, pageSize);			int wishlistCount = wishlistService.getWishlistCount(memberId);
			int totalPages = (int) Math.ceil((double) wishlistCount / pageSize);
			
			// finalPrice 계산
			for (Map<String, Object> item : wishlist) {
			    Map<String, Object> saleInfo = PriceCalculator.calculateSaleInfoFromMap(item);
			    item.put("finalPrice", saleInfo.get("finalPrice"));
	        }
			
			// 브랜드 팔로우 서비스
			BrandFollowService brandFollowService = new BrandFollowServiceImpl();
			List<Map<String, Object>> brandFollowList = brandFollowService.getBrandFollowByMemberId(memberId);
			int brandFollowCount = brandFollowService.getBrandFollowCount(memberId);			

			// queryString 
			String queryString = "tab=" + activeTab;
			
			// JSP로 데이터 전달
			request.setAttribute("wishlist", wishlist);
			request.setAttribute("wishlistCount", wishlistCount);
			request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
			request.setAttribute("brandFollowList", brandFollowList);
			request.setAttribute("brandFollowCount", brandFollowCount);
			request.setAttribute("activeTab", activeTab);
	        request.setAttribute("queryString", queryString);

			// 마이페이지 좋아요 페이지로 이동
			request.getRequestDispatcher("/consumer/like.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "좋아요 목록 조회 오류");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}
}
