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

import dto.Member;
import dto.Review;
import service.consumer.ReviewService;
import service.consumer.ReviewServiceImpl;

/**
 * Servlet implementation class MyReview
 */
@WebServlet("/store/mypage/myReview")
public class MyReview extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MyReview() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		try {
			// 세션에서 로그인 정보 확인
			HttpSession session = request.getSession();
			Member loginUser = (Member) session.getAttribute("loginUser");

			if (loginUser == null) {
				response.sendRedirect(request.getContextPath() + "/store/login");
				return;
			}

			Long memberId = loginUser.getMemberId();
			System.out.println("=== 디버깅 시작 ===");
			System.out.println("Member ID: " + memberId);

			ReviewService service = new ReviewServiceImpl();

			// 리뷰 작성 가능한 상품 목록 조회
			List<Map<String, Object>> reviewableItems = service.getReviewableItems(memberId);
			System.out.println("Reviewable items count: " + reviewableItems.size());

			// 내가 작성한 리뷰 목록 조회
			List<Map<String, Object>> myReviews = service.getMyReviews(memberId);
			System.out.println("My reviews count: " + myReviews.size());
			System.out.println("=== 디버깅 끝 ===");

			// ★★★ success 파라미터 체크 ★★★
			String success = request.getParameter("success");
			if ("true".equals(success)) {
				request.setAttribute("successMessage", "리뷰가 등록되었습니다!");
			}

			// JSP에 데이터 전달
			request.setAttribute("reviewableItems", reviewableItems);
			request.setAttribute("myReviews", myReviews);

			// 마이페이지 리뷰 JSP로 포워드 (이 이후로는 코드가 실행 안됨)
			request.getRequestDispatcher("/consumer/myReview.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "리뷰 목록을 불러오는 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		try {
			// 디버깅 시작
			System.out.println("=== 리뷰 작성 디버깅 시작 ===");

			// 세션 확인
			HttpSession session = request.getSession();
			Member loginUser = (Member) session.getAttribute("loginUser");
			System.out.println("로그인 사용자: " + (loginUser != null ? loginUser.getMemberId() : "null"));

			if (loginUser == null) {
				response.sendRedirect(request.getContextPath() + "/store/login");
				return;
			}

			// 파라미터 받기 및 출력
			String orderItemIdStr = request.getParameter("orderItemId");
			String productIdStr = request.getParameter("productId");
			String productOptionIdStr = request.getParameter("productOptionId");
			String ratingStr = request.getParameter("rating");
			String content = request.getParameter("content");

			System.out.println("orderItemId: " + orderItemIdStr);
			System.out.println("productId: " + productIdStr);
			System.out.println("productOptionId: " + productOptionIdStr);
			System.out.println("rating: " + ratingStr);
			System.out.println("content: " + content);

			// 변환
			Long orderItemId = Long.parseLong(orderItemIdStr);
			Long productId = Long.parseLong(productIdStr);
			Long productOptionId = (productOptionIdStr != null && !productOptionIdStr.isEmpty())
					? Long.parseLong(productOptionIdStr)
					: null;
			Integer rating = Integer.parseInt(ratingStr);

			// Review 객체 생성
			Review review = new Review();
			review.setMemberId(loginUser.getMemberId());
			review.setOrderItemId(orderItemId);
			review.setProductId(productId);
			review.setProductOptionId(productOptionId);
			review.setRating(rating);
			review.setContent(content);

			System.out.println("Review 객체: " + review.toString());

			// 리뷰 작성
			ReviewService service = new ReviewServiceImpl();
			service.createReview(review);

			System.out.println("리뷰 작성 완료!");
			System.out.println("=== 리뷰 작성 디버깅 끝 ===");

			// 성공 메시지와 함께 리다이렉트
			response.sendRedirect(request.getContextPath() + "/store/mypage/myReview?success=true");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("리뷰 작성 중 오류: " + e.getMessage());
			request.setAttribute("errorMessage", "리뷰 작성 중 오류가 발생했습니다: " + e.getMessage());
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
