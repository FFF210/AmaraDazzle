package controller.brand2;

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
import service.brand2.AdbannerService;
import service.brand2.AdbannerServiceImpl;

@WebServlet("/brand2/adbannerList")
public class AdbannerList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	public AdbannerList() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);

		// 세션 없거나 브랜드 정보 없음 → 로그인 페이지로 리다이렉트
		if (session == null || session.getAttribute("brand") == null) {
			response.sendRedirect(request.getContextPath() + "/brand/login");
			return;
		}

		Brand brand = (Brand) session.getAttribute("brand");
		Long brandId = brand.getBrandId();
		
		AdbannerService service = new AdbannerServiceImpl();
		
		// 페이지네이션
		int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
		int limit = 10; // 한 페이지당 개수
		int offset = (page - 1) * limit;

		Map<String, Object> params = new HashMap<>();
		params.put("brandId", brandId);
		
		// 상태 필터
		params.put("status", request.getParameter("status")); // (PENDING/ONGOING/COMPLETED/CANCELED)
		
		// 검색 필터
		params.put("searchType", request.getParameter("searchType")); // managerName / bannerName
		params.put("searchKeyword", request.getParameter("searchKeyword")); // 검색 키워드
		
		// 페이징
		params.put("limit", limit);
		params.put("offset", offset);

		try {
			// 서비스 호출
			Map<String, Object> result = service.AdbannerListByPage(params);

			// jsp 전달
			request.setAttribute("bannerList", result.get("bannerList")); // 배너 신청 목록
			request.setAttribute("totalCount", result.get("totalCount")); // 총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지

			request.getRequestDispatcher("/brand2/adbannerList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "배너 목록 조회 오류");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
