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
				// 로그인되지 않은 경우 로그인 페이지로 리다이렉트
				response.sendRedirect(request.getContextPath() + "/store/login");
				return;
			}

			Long memberId = loginUser.getMemberId();
			System.out.println("=== 디버깅 시작 ===");
			System.out.println("Member ID: " + memberId);
			
			ReviewService service = new ReviewServiceImpl();

			// 리뷰 작성 가능한 상품 목록 조회
			List<Map<String, Object>> reviewableItems = service.getReviewableItems(memberId);
			//디버깅용 로그출력
			System.out.println("Reviewable items count: " + reviewableItems.size());

			// 내가 작성한 리뷰 목록 조회
			List<Map<String, Object>> myReviews = service.getMyReviews(memberId);
			//디버깅용 로그출력
			System.out.println("My reviews count: " + myReviews.size());
			System.out.println("=== 디버깅 끝 ===");

			// JSP에 데이터 전달
			request.setAttribute("reviewableItems", reviewableItems);
			request.setAttribute("myReviews", myReviews);

			// 마이페이지 리뷰 JSP로 포워드
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
			// 세션에서 로그인 정보 확인
			HttpSession session = request.getSession();
			Member loginUser = (Member) session.getAttribute("loginUser");

			if (loginUser == null) {
				// 로그인되지 않은 경우 로그인 페이지로 리다이렉트
				response.sendRedirect(request.getContextPath() + "/store/login");
				return;
			}

			// 폼에서 전송된 데이터 받기
			Long orderItemId = Long.parseLong(request.getParameter("orderItemId"));
			Long productId = Long.parseLong(request.getParameter("productId"));
			String productOptionIdStr = request.getParameter("productOptionId");
			Long productOptionId = (productOptionIdStr != null && !productOptionIdStr.isEmpty())
					? Long.parseLong(productOptionIdStr)
					: null;
			Integer rating = Integer.parseInt(request.getParameter("rating"));
			String content = request.getParameter("content");

			// Review 객체 생성
			Review review = new Review();
			review.setMemberId(loginUser.getMemberId());
			review.setOrderItemId(orderItemId);
			review.setProductId(productId);
			review.setProductOptionId(productOptionId);
			review.setRating(rating);
			review.setContent(content);

			// 이미지 파일 ID들 (나중에 파일 업로드 기능 추가할 때 사용)
			// review.setImage1FileId(image1FileId);
			// review.setImage2FileId(image2FileId);
			// review.setImage3FileId(image3FileId);

			// 리뷰 작성
			ReviewService service = new ReviewServiceImpl();
			service.createReview(review);

			// 리뷰 작성 성공 - 마이페이지 리뷰로 리다이렉트
			response.sendRedirect(request.getContextPath() + "/store/mypage/myReview");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "리뷰 작성 중 오류가 발생했습니다: " + e.getMessage());
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
