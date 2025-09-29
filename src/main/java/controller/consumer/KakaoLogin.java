package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;

/**
 * Servlet implementation class KakaoLogin
 */
@WebServlet("/social/kakao")
public class KakaoLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public KakaoLogin() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		
		String code = request.getParameter("code");
		System.out.println(code);
		
		// ✅ 코드 체크
	    if (code == null || code.trim().isEmpty()) {
	        System.out.println("인증 코드가 없습니다!");
	        response.sendRedirect(request.getContextPath() + "/consumer/login.jsp?error=1");
	        return;
	    }
		
		try {
			MemberService service = new MemberServiceImpl();
			Member userInfo = service.kakaoLogin(code);
			HttpSession session = request.getSession();
			session.setAttribute("member", userInfo);
			request.getRequestDispatcher("/consumer/main.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			
			response.sendRedirect(request.getContextPath() + "/consumer/login.jsp?error=2");
		}
	}

}
