package controller.brand;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.brand.NoticeService;
import service.brand.NoticeServiceImpl;

/**
 * Servlet implementation class NoticeList
 */
@WebServlet("/brand/noticeList")
public class NoticeList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final NoticeService service = new NoticeServiceImpl();

	public NoticeList() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 페이지네이션 파라미터
		int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
		int limit = 7; // 한 페이지당 개수
		int offset = (page - 1) * limit;

		// 파라미터 수집
		Map<String, Object> params = new HashMap<>();
		params.put("limit", limit);
		params.put("offset", offset);

		try {
			// 서비스 호출
			Map<String, Object> result = service.noticeListByPage(params);

			// JSP로 전달
			request.setAttribute("noticeList", result.get("noticeList"));
			request.setAttribute("totalCount", result.get("totalCount")); // 총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지

			String noticeIdParam = request.getParameter("noticeId");
			if (noticeIdParam != null) {
				long noticeId = Long.parseLong(noticeIdParam);
				dto.brand.NoticeList noticeDetail = service.noticeDetail(noticeId);
				request.setAttribute("noticeDetail", noticeDetail);
			}

			request.getRequestDispatcher("/brand/noticeList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
