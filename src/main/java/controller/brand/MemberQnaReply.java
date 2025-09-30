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
 * Servlet implementation class MemberQnaReply
 */
@WebServlet("/brand/memberQnaReply")
public class MemberQnaReply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final MemberQnaService service = new MemberQnaServiceImpl();

	public MemberQnaReply() {
		super();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		Long qnaId = Long.parseLong(request.getParameter("qnaId"));
		String type = request.getParameter("type"); // QNA / TICKET
		String answer = request.getParameter("answer");

		try {
			service.updateAnswer(qnaId, type, answer);

			// 세션에 메시지 저장
			request.getSession().setAttribute("toastMessage", "답변이 정상적으로 등록되었습니다.");

			response.sendRedirect("/brand/qnaList");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
