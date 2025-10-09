package controller.brand2;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.brand2.OrdersDashboard;
import service.brand2.OrderDashboardService;
import service.brand2.OrderDashboardServiceImpl;

/**
 * Servlet implementation class Dashboard
 */
@WebServlet("/brand2/dashboard")
public class Dashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final OrderDashboardService service = new OrderDashboardServiceImpl();

	public Dashboard() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
/*
		HttpSession session = request.getSession(false);
		
		// 세션 없거나 브랜드 정보 없음 → 로그인 페이지로 리다이렉트
		if (session == null || session.getAttribute("brand") == null) {
			response.sendRedirect(request.getContextPath() + "/brand/login");
			return;
		}

		Brand brand = (Brand) session.getAttribute("brand");
		Long brandId = brand.getBrandId();
*/
		Long brandId = 1L;

		try {

			// 오늘 매출
			OrdersDashboard today = service.getSalesToday(brandId);
			request.setAttribute("salesToday", today != null ? today.getSalesToday() : 0);
			request.setAttribute("todayProductCount", today != null ? today.getProductCountToday() : 0);

			// 어제 매출
			OrdersDashboard yesterday = service.getSalesYesterday(brandId);
			request.setAttribute("salesYesterday", yesterday != null ? yesterday.getSalesYesterday() : 0);
			request.setAttribute("yesterdayProductCount", yesterday != null ? yesterday.getProductCountYesterday() : 0);

			// 이번 주 매출
			OrdersDashboard week = service.getSalesWeek(brandId);
			request.setAttribute("salesWeek", week != null ? week.getSalesWeek() : 0);
			request.setAttribute("weekProductCount", week != null ? week.getProductCountWeek() : 0);

			// 최근 30일 매출 (그래프용)
			List<OrdersDashboard> last30Days = service.getSalesLast30Days(brandId);
			String salesListJson = new Gson().toJson(last30Days == null ? List.of() : last30Days);
			request.setAttribute("salesListJson", salesListJson);
			
			// 올해 vs 전년도 월별 매출 비교
			List<OrdersDashboard> raw = service.getMonthlySalesCompare(brandId);

			// 1~12월 기본 틀 생성 (빈 달은 0으로 세팅)
			List<OrdersDashboard> shaped = new java.util.ArrayList<>();
			for (int m = 1; m <= 12; m++) {
			    OrdersDashboard row = new OrdersDashboard();
			    row.setMonth(String.format("%02d월", m));
			    row.setThisYear(0L);
			    row.setLastYear(0L);
			    shaped.add(row);
			}
			
			// DB 결과 반영
			for (OrdersDashboard r : raw) {
				int m = Integer.parseInt(r.getMonth());
			    OrdersDashboard tgt = shaped.get(m - 1);
			    if (r.getThisYear() != null) tgt.setThisYear(r.getThisYear());
			    if (r.getLastYear() != null) tgt.setLastYear(r.getLastYear());
			}
			request.setAttribute("salesCompareJson", new Gson().toJson(shaped));

			// =================== jsp에서 % than last month 부분 ===================
			Long totalSales = service.getTotalSales(brandId);
			Long lastMonthSales = service.getLastMonthSales(brandId);

			// 증감율 계산
			int salesGrowth = 0;
			if (lastMonthSales != null && lastMonthSales > 0) {
			    salesGrowth = (int)Math.round(((double)(totalSales - lastMonthSales) / lastMonthSales) * 100);
			}

			request.setAttribute("totalSales", totalSales);
			request.setAttribute("salesGrowth", salesGrowth);
			// ====================
			
			request.getRequestDispatcher("/brand2/dashboard.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
