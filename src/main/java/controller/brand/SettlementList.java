package controller.brand;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Brand;
import service.brand.SettlementService;
import service.brand.SettlementServiceImpl;

/**
 * Servlet implementation class SettlementList
 */
@WebServlet("/brand/settlementList")
public class SettlementList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final SettlementService service = new SettlementServiceImpl();

	public SettlementList() {
		super();
	}

	/**
	 * 정산 목록 조회 (GET)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession(false);

		// 세션 없거나 브랜드 정보 없음 → 로그인 페이지로 리다이렉트
		if (session == null || session.getAttribute("brand") == null) {
			response.sendRedirect(request.getContextPath() + "/brand/login");
			return;
		}

		Brand brand = (Brand) session.getAttribute("brand");
		Long brandId = brand.getBrandId();

		// 페이지네이션 파라미터
		int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
		int limit = 10; // 한 페이지당 개수
		int offset = (page - 1) * limit;

		// 파라미터 수집
		Map<String, Object> params = new HashMap<>();
		params.put("brandId", brandId);
		params.put("limit", limit);
		params.put("offset", offset);

		try {
			// 서비스 호출
			Map<String, Object> result = service.settlementListByPage(params);

			// JSP로 전달
			request.setAttribute("settlementList", result.get("settlementList")); // 정산 목록
			request.setAttribute("totalCount", result.get("totalCount")); // 총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지

			request.getRequestDispatcher("/brand/settlementList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
