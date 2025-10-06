package controller.brand;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Brand;
import dto.brand.DashboardSummary;
import dto.brand.DashboardTodo;
import dto.brand.EventAlert;
import dto.brand.TopProduct;
import service.brand.BrandService;
import service.brand.BrandServiceImpl;

/**
 * Servlet implementation class TodoDashboard
 */
@WebServlet("/brand/todoDashboard")
public class TodoDashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final BrandService service = new BrandServiceImpl();

	public TodoDashboard() {
		super();

	}

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

		try {
			// 서비스 호출
			DashboardSummary summary = service.getDashboardSummary(brandId);
			DashboardTodo todo = service.getDashboardTodo(brandId);
			List<EventAlert> events = service.getEventAlerts(brandId);
			List<TopProduct> products = service.getWeeklyTop3Products(brandId);

			// JSP로 전달
			request.setAttribute("summary", summary);
			request.setAttribute("todo", todo);
			request.setAttribute("events", events);
			request.setAttribute("products", products);

			request.getRequestDispatcher("/brand/todoDashboard.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
