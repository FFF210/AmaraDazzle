package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;

/**
 * Servlet implementation class ResetPassword
 */
@WebServlet("/resetPassword")
public class ResetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        Long resetMemberId = (Long) session.getAttribute("resetMemberId");
        
        // 세션 체크
        if (resetMemberId == null) {
            request.setAttribute("errorMessage", "잘못된 접근입니다.");
            request.setAttribute("tabType", "findPw");
            request.getRequestDispatcher("/consumer/findAccount.jsp").forward(request, response);
            return;
        }
        
        // 파라미터 받기
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        System.out.println("비밀번호 재설정 - 회원ID: " + resetMemberId);
        
        try {
            // 비밀번호 확인
            if (!newPassword.equals(confirmPassword)) {
                throw new Exception("비밀번호가 일치하지 않습니다.");
            }
            
            MemberService service = new MemberServiceImpl();
            
            // 비밀번호 재설정
            service.resetPassword(resetMemberId, newPassword);
            
            System.out.println("비밀번호 재설정 완료");
            
            // 세션에서 회원 ID 제거
            session.removeAttribute("resetMemberId");
            
            // 성공 - findAccount.jsp로 돌아가서 성공 메시지 표시
            request.setAttribute("passwordResetSuccess", true);
            request.setAttribute("tabType", "findPw");
            
            request.getRequestDispatcher("/consumer/findAccount.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            
            // 실패 - 팝업 다시 띄우고 에러 메시지 표시
            request.setAttribute("showPasswordResetPopup", true);
            request.setAttribute("resetErrorMessage", e.getMessage());
            request.setAttribute("tabType", "findPw");
            
            request.getRequestDispatcher("/consumer/findAccount.jsp").forward(request, response);
        }
	}

}
