package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Notice;
import service.admin.NoticeService;
import service.admin.NoticeServiceImpl;

@WebServlet("/admin/noticeSellerDetail")
public class NoticeSellerDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/admin/notice_detail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String num = request.getParameter("num");  //?뒤의 파라미터명과 동일해야함
		NoticeService n_service = new NoticeServiceImpl();
		
		try {
			
			Notice notice_DTO = null;
//			notice_DTO = n_service.noticeSellerDetail(Integer.parseInt(num));
//			n_service.viewCount(Integer.parseInt(num));

			request.setAttribute("noticeSellerDetail", notice_DTO);
			request.getRequestDispatcher("notice_detail.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
	}

}
