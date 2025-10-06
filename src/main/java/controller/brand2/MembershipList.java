package controller.brand2;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.brand2.MembershipService;
import service.brand2.MembershipServiceImpl;

/**
 * Servlet implementation class MembershipList
 */
@WebServlet("/brand2/membershipList")
public class MembershipList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MembershipList() {
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
		
		/* =========== 로그인 ===========
		HttpSession session = request.getSession(false);

		// 세션 없거나 브랜드 정보 없음 → 로그인 페이지로 리다이렉트
		if (session == null || session.getAttribute("brand") == null) {
			response.sendRedirect(request.getContextPath() + "/brand/login");
			return;
		}

		Brand brand = (Brand) session.getAttribute("brand");
		Long brandId = brand.getBrandId();
=========== 로그인 =========== */
		MembershipService service = new MembershipServiceImpl();
		
		// 페이지네이션
		int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
		int limit = 10; // 한 페이지당 개수
		int offset = (page - 1) * limit;

		Map<String, Object> params = new HashMap<>();
		params.put("status", request.getParameter("status")); // (PENDING/ONGOING/COMPLETED/CANCELED)
		params.put("searchType", request.getParameter("searchType")); // managerName / managerTel / bannerName
		params.put("searchKeyword", request.getParameter("keyword")); // 검색 키워드
		params.put("limit", limit);
		params.put("offset", offset);

		
		
		try {
			// 서비스 호출
			Map<String, Object> result = service.MembershipListByPage(params);

			// JSP 전달(jsp -> items="${...}", ServiceImpl -> result.put("...", list);)
			request.setAttribute("membershipList", result.get("membershipList")); // 멤버십 결제 목록
			request.setAttribute("totalCount", result.get("totalCount")); // 총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지
			
			request.getRequestDispatcher("/brand2/membership.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "멤버십 목록 조회 오류");
			request.getRequestDispatcher("error.jsp").forward(request, response);
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
