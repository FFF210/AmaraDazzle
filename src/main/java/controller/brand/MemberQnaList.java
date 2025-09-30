package controller.brand;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.brand.MemberQnaService;
import service.brand.MemberQnaServiceImpl;

/**
 * Servlet implementation class QnaList
 */
@WebServlet("/brand/qnaList")
public class MemberQnaList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final MemberQnaService service = new MemberQnaServiceImpl();

	public MemberQnaList() {
		super();
	}

	/**
	 * 고객 문의 목록 조회 (GET)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 파라미터 수집
		int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
		int limit = 10; // 한 페이지당 개수
		int offset = (page - 1) * limit;

		// 브랜드 아이디
//		Brand brand = (Brand) request.getSession().getAttribute("brand");
//		Long brandId = brand.getBrandId();
		Long brandId = 1L;

		// 파라미터 수집
		Map<String, Object> params = new HashMap<>();
		params.put("brandId", brandId);

		// 답변 상태 필터
		params.put("answerStatus", request.getParameter("answerStatus"));
		// 문의 유형 상태 필터
		params.put("category", request.getParameter("category"));

		// 검색 필터
		// searchType = SENDER(작성자)
		params.put("searchKeyword", request.getParameter("searchKeyword"));

		// 날짜 필터 (yyyy-MM-dd 형식으로 넘어옴)
		params.put("startDate", request.getParameter("startDate")); // 시작일
		params.put("endDate", request.getParameter("endDate")); // 종료일

		params.put("page", page);
		params.put("limit", limit);
		params.put("offset", offset);

		try {
			Map<String, Object> result = service.memberQnaListByPage(params);

			// JSP로 전달
			request.setAttribute("qnaList", result.get("qnaList"));
			request.setAttribute("totalCount", result.get("totalCount"));
			request.setAttribute("totalPages", result.get("totalPages"));
			request.setAttribute("currentPage", page);

			request.getRequestDispatcher("/brand/qnaList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
