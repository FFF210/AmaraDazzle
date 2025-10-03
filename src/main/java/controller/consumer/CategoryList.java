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

import service.brand.CategoryService;
import service.brand.CategoryServiceImpl;
import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;

/**
 * Servlet implementation class CategoryList
 */
@WebServlet("/store/categoryList")
public class CategoryList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ProductService service = new ProductServiceImpl();
	private final CategoryService Categoryservice = new CategoryServiceImpl();

	public CategoryList() {
		super();
	}

	/**
	 * 카테고리 상품 목록 조회 (GET)
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
		params.put("category2Id", request.getParameter("category2Id"));
		params.put("category3Id", request.getParameter("category3Id"));
		params.put("sort", request.getParameter("sort"));
		params.put("limit", limit);
		params.put("offset", offset);

		try {
			// 서비스 호출
			Map<String, Object> result = service.productCategoryListByPage(params);

			// selectedCategory 세팅
			String selectedCategory = "전체 상품";
			if (request.getParameter("category3Id") != null) {
				selectedCategory = Categoryservice.getCategoryName(Long.parseLong(request.getParameter("category3Id")));
			} else if (request.getParameter("category2Id") != null) {
				selectedCategory = Categoryservice.getCategoryName(Long.parseLong(request.getParameter("category2Id")));
			} else if (request.getParameter("category1Id") != null) {
				selectedCategory = Categoryservice.getCategoryName(Long.parseLong(request.getParameter("category1Id")));
			}
			request.setAttribute("selectedCategory", selectedCategory);

			// JSP로 전달
			request.setAttribute("productCategoryList", result.get("productCategoryList"));
			request.setAttribute("totalCount", result.get("totalCount")); // 총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지

			request.getRequestDispatcher("/consumer/categoryList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
