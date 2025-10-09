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

@WebServlet("/store/findPassword")
public class FindPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public FindPassword() {
        super();
    }

    // GET 요청 - 페이지 보여주기
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/consumer/findAccount.jsp").forward(request, response);
    }

    // POST 요청 - 비밀번호 찾기 처리
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 요청 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // 파라미터 받기
        String email = request.getParameter("loginId");
        String phone = request.getParameter("phonePw");
        
        System.out.println("비밀번호 찾기 - 이메일: " + email + ", 전화번호: " + phone);
        
        try {
            MemberService service = new MemberServiceImpl();
            
            // 이메일과 전화번호로 회원 확인
            Long memberId = service.verifyForPasswordReset(email, phone);
            
            System.out.println("확인된 회원 ID: " + memberId);
            
            // 성공 - 회원 ID를 세션에 저장하고 팝업 띄우기
            HttpSession session = request.getSession();
            session.setAttribute("resetMemberId", memberId);
            
            request.setAttribute("showPasswordResetPopup", true);
            request.setAttribute("tabType", "findPw");
            
            request.getRequestDispatcher("/consumer/findAccount.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            
            // 실패 - 에러 메시지를 담아서 JSP로 전달
            request.setAttribute("success", false);
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("tabType", "findPw");
            request.setAttribute("loginId", email); // 입력값 유지
            request.setAttribute("phonePw", phone); // 입력값 유지
            
            request.getRequestDispatcher("/consumer/findAccount.jsp").forward(request, response);
        }
    }
}