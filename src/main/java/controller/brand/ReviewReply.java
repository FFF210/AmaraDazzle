package controller.brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.brand.ReviewService;
import service.brand.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewReply
 */
@WebServlet("/brand/reviewReply")
public class ReviewReply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ReviewService service = new ReviewServiceImpl();

	public ReviewReply() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		Long reviewId = Long.parseLong(request.getParameter("reviewId"));
		String answer = request.getParameter("answer");

		try {
			service.updateReviewAnswer(reviewId, answer);

			// 세션에 메시지 저장
			request.getSession().setAttribute("toastMessage", "답변이 정상적으로 등록되었습니다.");

			response.sendRedirect("/brand/reviewList");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
