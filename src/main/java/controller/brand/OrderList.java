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
import service.brand.OrdersService;
import service.brand.OrdersServiceImpl;

/**
 * Servlet implementation class OrderList
 */
@WebServlet("/brand/orderList")
public class OrderList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final OrdersService service = new OrdersServiceImpl();

	public OrderList() {
		super();
	}

	/**
	 * 주문 목록 조회 (GET)
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

		// 주문 상태 필터
		// ALL=전체 | PAID=결제완료 | PREPARING=상품준비중 | SHIPPING=배송중 | DELIVERED=배송완료
		// CANCELLED=주문취소 | EXCHANGE=교환(전체) | RETURN=반품(전체)
		params.put("status", request.getParameter("status"));

		// 검색 필터
		// searchType = MEMBER(주문자), PRODUCT(상품명)
		params.put("searchType", request.getParameter("searchType"));
		params.put("searchKeyword", request.getParameter("searchKeyword"));

		// 날짜 필터 (yyyy-MM-dd 형식으로 넘어옴)
		params.put("startDate", request.getParameter("startDate")); // 시작일
		params.put("endDate", request.getParameter("endDate")); // 종료일

		params.put("limit", limit);
		params.put("offset", offset);

		try {
			// 서비스 호출
			Map<String, Object> result = service.ordersListByPage(params);

			// JSP로 전달
			request.setAttribute("ordersList", result.get("ordersList")); // 주문 목록
			request.setAttribute("totalCount", result.get("totalCount")); // 총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지

			request.getRequestDispatcher("/brand/orderList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
