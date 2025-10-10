package controller.brand;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Brand;
import service.brand.ProductService;
import service.brand.ProductServiceImpl;

/**
 * Servlet implementation class ProductList
 */
@WebServlet("/brand/productList")
public class ProductList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ProductService service = new ProductServiceImpl();

	public ProductList() {
		super();
	}

	/**
	 * 상품 목록 조회 (GET)
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

		// 파라미터 수집
		int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
		int limit = 10; // 한 페이지당 개수
		int offset = (page - 1) * limit;

		Map<String, Object> params = new HashMap<>();
		params.put("brandId", brandId);
		params.put("status", request.getParameter("status")); // SALE, SOLD_OUT, STOP_SALE
		params.put("searchType", request.getParameter("searchType")); // NAME or CATEGORY
		params.put("searchKeyword", request.getParameter("searchKeyword"));
		params.put("limit", limit);
		params.put("offset", offset);

		String sortField = request.getParameter("sortField");
		String sortOrder = request.getParameter("sortOrder");

		// 화이트리스트 검증
		List<String> allowedFields = Arrays.asList("price", "sale_price", "stock_qty", "sales_qty", "review_count");
		if (!allowedFields.contains(sortField)) {
			sortField = null;
		}

		if (!"asc".equalsIgnoreCase(sortOrder) && !"desc".equalsIgnoreCase(sortOrder)) {
			sortOrder = "asc"; // 기본값
		}

		params.put("sortField", sortField);
		params.put("sortOrder", sortOrder);

		try {
			// 서비스 호출
			Map<String, Object> result = service.productListByPage(params);

			// JSP로 전달
			request.setAttribute("productList", result.get("productList")); // 상품 목록
			request.setAttribute("totalCount", result.get("totalCount")); // 총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지

			request.getRequestDispatcher("/brand/productList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Ajax 요청 처리 (POST)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");

		String action = request.getParameter("action"); // delete, stock, sale
		PrintWriter out = response.getWriter();

		try {
			if ("delete".equals(action)) {
				// 상품 공개 여부 토글
				long productId = Long.parseLong(request.getParameter("productId"));
				service.toggleVisibility(productId);
				out.write("{\"result\":\"success\"}");

			} else if ("release".equals(action)) {
				// 상품 공개 여부 토글
				long productId = Long.parseLong(request.getParameter("productId"));
				service.toggleVisibility(productId);
				out.write("{\"result\":\"success\"}");

			} else if ("stock".equals(action)) {
				// 재고 변경
				long productId = Long.parseLong(request.getParameter("productId"));
				int newStock = Integer.parseInt(request.getParameter("newStock"));

				Map<String, Object> params = new HashMap<>();
				params.put("productId", productId);
				params.put("newStock", newStock);

				service.updateStock(params);
				out.write("{\"result\":\"success\"}");

			} else if ("sale".equals(action)) {
				// 세일 등록
				String discountType = request.getParameter("discountType");
				int discountValue = Integer.parseInt(request.getParameter("discountValue"));
				String startDate = request.getParameter("startDate");
				String endDate = request.getParameter("endDate");

				// 여러 상품 체크박스 선택된 경우
				String[] productIds = request.getParameterValues("productIds");

				Map<String, Object> params = new HashMap<>();
				params.put("discountType", discountType);
				params.put("discountValue", discountValue);
				params.put("startDate", startDate);
				params.put("endDate", endDate);
				params.put("productIds", List.of(productIds));

				service.registerSale(params);
				out.write("{\"result\":\"success\"}");

			} else {
				out.write("{\"result\":\"error\",\"message\":\"알 수 없는 action\"}");
			}

		} catch (Exception e) {
			e.printStackTrace();
			out.write("{\"result\":\"error\",\"message\":\"요청 처리 중 오류 발생\"}");
		}
	}
}
