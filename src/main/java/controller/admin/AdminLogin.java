package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.AdminInfo;
import service.admin.AdminService;
import service.admin.AdminServiceImpl;

@WebServlet("/admin/login")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/admin/admin_login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		
		PrintWriter pw = response.getWriter();
		
		try {
			String aid = request.getParameter("aid");
			String apass = request.getParameter("apass");
			String rememberId = request.getParameter("rememberId");

			AdminService admin_svc = new AdminServiceImpl();
			AdminInfo result = admin_svc.adminLoginConfirm(aid, apass);
			
			if(result == null) {	//일치하는 값이 없을 때 (로그인 실패)
	            pw.print("{\"status\":\"fail\",\"title\":\"로그인 실패\",\"message\":\"회원 정보를 다시 확인해 주세요.\"}");
				
			}else {	//일치하는 값이 있을 떄 
				//세션 저장 
				HttpSession session = request.getSession();
				session.setAttribute("aidx", result.getAdminInfoId());
				session.setAttribute("aid", result.getAid());
				session.setAttribute("aname", result.getAname());
				
				Cookie cookie1 = null;
				Cookie cookie2 = null;
				
				//아이디 저장 체크 여부 
				if(rememberId == null || "".equals(rememberId)) { //체크 안함 
					cookie1 = new Cookie("rememberId", "");
				    cookie2 = new Cookie("id", "");
				    cookie1.setMaxAge(0); // 즉시 만료
				    cookie2.setMaxAge(0); 
					
				} else {
					cookie1 = new Cookie("rememberId", rememberId);
					cookie2 = new Cookie("id", aid);
					cookie1.setMaxAge(30*24*60*60); //30일간 쿠키 유지
					cookie2.setMaxAge(30*24*60*60); 
				}
				
				response.addCookie(cookie1);
				response.addCookie(cookie2);
				
	            pw.print("{\"status\":\"ok\",\"title\":\"로그인 성공! \",\"message\":\""+ result.getAname() + " 님 환영합니다!\"}");
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			pw.print("{\"status\":\"error\",\"message\":\"서버 오류가 발생했습니다.\"}");
			
		} finally {
	        pw.flush();
	        pw.close();
	    }
	}
}
