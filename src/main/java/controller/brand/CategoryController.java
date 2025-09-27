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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");

		String type = request.getParameter("type"); // large, middle, small
		String parentId = request.getParameter("parentId");

		List<Category> result = null;

		try {
			if ("large".equals(type)) {
				result = service.getLargeCategories();
			} else if ("middle".equals(type) && parentId != null) {
				result = service.getMiddleCategories(Long.parseLong(parentId));
			} else if ("small".equals(type) && parentId != null) {
				result = service.getSmallCategories(Long.parseLong(parentId));
			}

			Gson gson = new Gson();
			String json = gson.toJson(result);
			response.getWriter().write(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
