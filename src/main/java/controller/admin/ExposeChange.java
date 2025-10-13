package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Notice;
import service.admin.NoticeService;
import service.admin.NoticeServiceImpl;

@WebServlet("/admin/exposeChange")
public class ExposeChange extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NoticeService notice_svc = new NoticeServiceImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		String num = request.getParameter("num"); 
		
		try {
			Notice noticeOne = notice_svc.noticeSellerDetail(Integer.parseInt(num));
			Integer exposeYN = noticeOne.getIsExposed();
			int result = notice_svc.noticeExposeChange(Long.valueOf(num),exposeYN);
			
			if (result > 0) {
				pw.print("{\"status\":\"ok\",\"title\":\"게시상태 변경 완료\",\"message\":\"게시상태가 변경되었습니다.\"}");
			} else {
				pw.print("{\"status\":\"fail\",\"title\":\"게시상태 변경 실패\",\"message\":\"게시상태 변경에 실패했습니다.\"}");
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
	}
}
