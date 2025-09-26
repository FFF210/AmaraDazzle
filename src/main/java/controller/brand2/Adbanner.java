package controller.brand2;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.brand2.BannerForm;
import service.brand2.AdbannerService;
import service.brand2.AdbannerServiceImpl;

/**
 * Servlet implementation class Adbanner
 */
@WebServlet("/adbanner")
public class Adbanner extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdbannerService service = new AdbannerServiceImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Adbanner() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 배너 신청 페이지 이동
		RequestDispatcher dispatcher = request.getRequestDispatcher("/brand2/adbannerForm.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		try {
			// 폼에서 입력받는 값
			BannerForm form = new BannerForm();
			form.setBannerName(request.getParameter("bannerName"));
			form.setManagerName(request.getParameter("managerName"));
			form.setManagerTel(request.getParameter("managerTel"));
			form.setBannerMessage(request.getParameter("bannerMessage"));

			String startDateStr = request.getParameter("startDate"); // "2025-09-26"
			String endDateStr = request.getParameter("endDate");

			// LocalDate 로 변환
			LocalDate startLocal = LocalDate.parse(startDateStr);
			LocalDate endLocal = LocalDate.parse(endDateStr);

			// LocalDate → Timestamp (하루의 00:00:00 기준)
			form.setStartDate(Timestamp.valueOf(startLocal.atStartOfDay()));
			form.setEndDate(Timestamp.valueOf(endLocal.atStartOfDay()));

			// 신청폼에서 입력받지 않음
			form.setBrandUrl(null);

			// 세션에서 꺼내기
			Long brandId = (Long) request.getSession().getAttribute("brandId");
			form.setBrandId(brandId);

			service.registerBanner(form); // 인스턴스로 호출

//            response.sendRedirect("/brand2/adbannerList.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}

	}
}
