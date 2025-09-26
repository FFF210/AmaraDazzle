package controller.brand;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.brand.ProductService;
import service.brand.ProductServiceImpl;

/**
 * Servlet implementation class ProductList
 */
@WebServlet("/brand/productList")
public class ProductList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductList() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 파라미터 수집
		int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
		int limit = 10; // 한 페이지당 개수
		int offset = (page - 1) * limit;

		Map<String, Object> params = new HashMap<>();
		params.put("status", request.getParameter("status")); // SALE, SOLD_OUT, STOP_SALE
		params.put("searchType", request.getParameter("searchType")); // NAME or CATEGORY
		params.put("searchKeyword", request.getParameter("searchKeyword"));
		params.put("limit", limit);
		params.put("offset", offset);

		try {
			// 서비스 호출
			ProductService service = new ProductServiceImpl();
			Map<String, Object> result = service.productListByPage(params);

			// JSP로 전달
			request.setAttribute("productList", result.get("productList")); // 상품 목록
			request.setAttribute("totalCount", result.get("totalCount")); //총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지

			request.getRequestDispatcher("/brand/productList.jsp").forward(request, response);

		} catch (Exception e) {
			request.setAttribute("err", "상품 목록 조회 오류");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
