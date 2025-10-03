package controller.brand;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.Category;
import service.brand.CategoryService;
import service.brand.CategoryServiceImpl;

@WebServlet("/category")
public class CategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final CategoryService service = new CategoryServiceImpl();

	public CategoryController() {
		super();
	}

	/**
	 * 카테고리 목록 조회 (GET)
	 * 
	 * 요청 파라미터: - type : "large" | "middle" | "small" - parentId : 상위 카테고리 ID (중/소분류
	 * 조회 시 필요)
	 * 
	 * 응답: - JSON 형식의 카테고리 목록
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");

		String type = request.getParameter("type"); // large, middle, small
		String parentId = request.getParameter("parentId");

		List<Category> result = null;

		try {
			// 대분류 조회
			if ("large".equals(type)) {
				result = service.getLargeCategories();

				// 특정 대분류에 속한 중분류 조회
			} else if ("middle".equals(type) && parentId != null) {
				result = service.getMiddleCategories(Long.parseLong(parentId));

				// 특정 중분류에 속한 소분류 조회
			} else if ("small".equals(type) && parentId != null) {
				result = service.getSmallCategories(Long.parseLong(parentId));
			}

			// 결과를 JSON으로 직렬화 후 응답
			Gson gson = new Gson();
			String json = gson.toJson(result);
			System.out.println(json);
			response.getWriter().write(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
