package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.consumer.MemberCouponService;
import service.consumer.MemberCouponServiceImpl;
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
	    System.out.println("카카오 인증 코드: " + code);
	    
	    // ✅ 코드 체크
	    if (code == null || code.trim().isEmpty()) {
	        System.out.println("인증 코드가 없습니다!");
	        response.sendRedirect(request.getContextPath() + "/consumer/login.jsp?error=1");
	        return;
	    }
	    
	    try {
	        MemberService service = new MemberServiceImpl();
	        Member member = service.kakaoLogin(code);
	        
	        System.out.println("카카오 로그인 성공 - 회원정보: " + member.getEmail());
	        
	        // ✅ 일반 로그인과 동일하게 세션 설정
	        HttpSession session = request.getSession();
	        session.setAttribute("loginUser", member);  // ← member에서 loginUser로 변경
	        
	        // 개별 저장 추가
	        session.setAttribute("memberId", member.getMemberId());
	        session.setAttribute("memberName", member.getName());
	        session.setAttribute("memberEmail", member.getEmail());
	        session.setAttribute("memberGrade", member.getGrade());
	        session.setAttribute("memberPoints", member.getPointBalance());
	        
	        // 쿠폰 개수도 가져오기
	        MemberCouponService couponService = new MemberCouponServiceImpl();
	        int couponCount = couponService.getAvailableCouponCount(member.getMemberId());
	        session.setAttribute("memberCoupons", couponCount);
	        
	        System.out.println("세션 설정 완료");
	        
	        // ✅ forward 대신 redirect 사용
	        response.sendRedirect(request.getContextPath() + "/store/main");
	        
	    } catch (Exception e) {
	        System.out.println("카카오 로그인 중 에러 발생:");
	        e.printStackTrace();
	        
	        response.sendRedirect(request.getContextPath() + "/consumer/login.jsp?error=2");
	    }
	}

}
