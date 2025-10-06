package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AdminLogout
 */
@WebServlet("/admin/logout")
public class AdminLogout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		
		PrintWriter pw = response.getWriter();
		
		try {
			HttpSession session = request.getSession(false); /*기존 세션이 없으면 새로 만들지말것*/
			if (session != null) { //세션이 있을때만 실행
			    session.invalidate(); //세션에 저장된 정보들 파기 
			    pw.print("{\"status\":\"ok\",\"title\":\"로그아웃\",\"message\":\"로그아웃 되었습니다.\"}");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
	        pw.print("{\"status\":\"error\",\"title\":\"로그아웃 오류\",\"message\":\"서버 오류가 발생했습니다.\"}");
			
		} finally {
	        pw.flush();
	        pw.close();
	    }
		
		
	}

}
