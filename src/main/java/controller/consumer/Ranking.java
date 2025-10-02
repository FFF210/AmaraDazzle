package controller.consumer;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;

/**
 * Servlet implementation class Ranking
 */
@WebServlet("/store/ranking")
public class Ranking extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ProductService service = new ProductServiceImpl();

	public Ranking() {
		super();
	}

	/**
	 * 랭킹 상품 목록 조회 (GET)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 파라미터 수집
		int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
		int limit = 16; // 한 페이지당 개수
		int offset = (page - 1) * limit;

		HttpSession session = request.getSession(false);
		Long memberId = null;
		if (session != null && session.getAttribute("memberId") != null) {
			memberId = (Long) session.getAttribute("memberId");
		}

		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("category1Id", request.getParameter("category1Id"));
		params.put("limit", limit);
		params.put("offset", offset);

		try {
			// 서비스 호출
			Map<String, Object> result = service.productRankListByPage(params);

			// JSP로 전달
			request.setAttribute("productRankList", result.get("productRankList"));
			request.setAttribute("totalCount", result.get("totalCount")); // 총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지

			request.getRequestDispatcher("/consumer/ranking.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
