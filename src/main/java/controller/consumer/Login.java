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
 * Servlet implementation class Login
 */
@WebServlet("/store/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/consumer/login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // 요청 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        
        // 파라미터 받기
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
            // 로그인 시도
			MemberService service = new MemberServiceImpl();
			Member member = service.login(email, password);            
            // 로그인 성공 - 세션에 저장
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", member);
            
            //이건 저장 굳이 안 해도 되는듯 하지만...
            session.setAttribute("memberId", member.getMemberId());
            session.setAttribute("memberName", member.getName());
            session.setAttribute("memberEmail", member.getEmail());
            session.setAttribute("memberGrade", member.getGrade());
            
            response.sendRedirect(request.getContextPath() + "/store/main");              
            
        } catch (Exception e) {
        	e.printStackTrace();
            // 로그인 실패
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("email", email); // 입력했던 이메일 유지
            
            // 로그인 페이지로 다시 포워드
            request.getRequestDispatcher("/consumer/login.jsp").forward(request, response);
        }
    }
}
