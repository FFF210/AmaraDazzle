package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.consumer.CouponService;
import service.consumer.CouponServiceImpl;

/**
 * Servlet implementation class CouponDownload
 */
@WebServlet("/store/couponDownload")
public class CouponDownload extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CouponService service = new CouponServiceImpl();

	public CouponDownload() {
		super();
	}

	/**
	 * 쿠폰 다운 (POST)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");

		Long memberId = (Long) request.getSession().getAttribute("memberId");

		// 로그인 여부 체크
		if (memberId == null) {
			response.getWriter().write("{\"success\":false, \"requireLogin\":true}");
			return;
		}

		String couponIdParam = request.getParameter("couponId");
		Long couponId = Long.valueOf(couponIdParam);

		try {
			// 서비스 호출
			service.downloadCoupon(couponId, memberId);

			response.getWriter().write("{\"success\":true, \"message\":\"쿠폰이 발급되었습니다.\"}");

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("{\"success\":false, \"message\":\"서버 오류\"}");
		}
	}

}
