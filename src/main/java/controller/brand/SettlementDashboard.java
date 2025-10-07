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
import dto.brand.SettlementDonut;
import dto.brand.SettlementSummary;
import dto.brand.SettlementTrend;
import service.brand.SettlementService;
import service.brand.SettlementServiceImpl;

/**
 * Servlet implementation class SettlementDashboard
 */
@WebServlet("/brand/settlementDashboard")
public class SettlementDashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final SettlementService service = new SettlementServiceImpl();

	public SettlementDashboard() {
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
			SettlementSummary summary = service.getSettlementSummary(brandId);
			SettlementDonut donut = service.getSettlementDonut(brandId);
			List<SettlementTrend> trendList = service.getMonthlyTrend(brandId);

			// JSP로 전달
			request.setAttribute("summary", summary);
			request.setAttribute("donut", donut);
			request.setAttribute("trendList", trendList);

			request.getRequestDispatcher("/brand/settlementDashboard.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
