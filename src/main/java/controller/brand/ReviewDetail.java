package controller.brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.brand.ReviewList;
import service.brand.ReviewService;
import service.brand.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewDetail
 */
@WebServlet("/brand/reviewDetail")
public class ReviewDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ReviewService service = new ReviewServiceImpl();

	public ReviewDetail() {
		super();
	}

	/**
	 * 리뷰 상세 조회 (GET)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Long reviewId = Long.parseLong(request.getParameter("reviewId"));
		try {
			ReviewList detail = service.reviewDetail(reviewId);

			request.setAttribute("review", detail);
			request.getRequestDispatcher("/brand/reviewDetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
