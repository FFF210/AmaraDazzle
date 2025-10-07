package controller.brand;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.brand.NoticeService;
import service.brand.NoticeServiceImpl;

/**
 * Servlet implementation class NoticeDetailFragment
 */
@WebServlet("/brand/noticeDetailFragment")
public class NoticeDetailFragment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final NoticeService service = new NoticeServiceImpl();

	public NoticeDetailFragment() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String idParam = request.getParameter("noticeId");
		if (idParam == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}

		long noticeId = Long.parseLong(idParam);

		try {
			dto.brand.NoticeList notice = service.noticeDetail(noticeId);
			request.setAttribute("notice", notice);
		} catch (Exception e) {
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/brand/noticeDetailFragment.jsp");
		dispatcher.forward(request, response);
	}

}
