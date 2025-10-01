package controller.brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.brand.MemberQnaService;
import service.brand.MemberQnaServiceImpl;

/**
 * Servlet implementation class MemberQnaDetail
 */
@WebServlet("/brand/qnaDetail")
public class MemberQnaDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final MemberQnaService service = new MemberQnaServiceImpl();

	public MemberQnaDetail() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String type = request.getParameter("type"); // "QNA" or "TICKET"
			Long qnaId = Long.parseLong(request.getParameter("qnaId"));

			dto.brand.MemberQnaList detail = service.memberQnaListDetail(type, qnaId);

			request.setAttribute("qna", detail);
			request.getRequestDispatcher("/brand/qnaDetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
