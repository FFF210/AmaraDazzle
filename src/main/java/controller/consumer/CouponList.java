package controller.consumer;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.consumer.CouponService;
import service.consumer.CouponServiceImpl;

/**
 * Servlet implementation class CouponList
 */
@WebServlet("/store/couponList")
public class CouponList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CouponService service = new CouponServiceImpl();

	public CouponList() {
		super();
	}

	/**
	 * 다운 가능한 쿠폰 목록 조회 (GET)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession(false);
		Long memberId = null;
		if (session != null && session.getAttribute("memberId") != null) {
			memberId = (Long) session.getAttribute("memberId");
		}

		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);

		try {
			// 서비스 호출
			List<dto.consumer.CouponList> couponList = service.getCounponList(params);

			request.setAttribute("couponList", couponList);

			request.getRequestDispatcher("/consumer/couponList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
