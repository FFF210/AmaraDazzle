package controller.consumer;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;

/**
 * Servlet implementation class Join
 */
@WebServlet("/consumer/join")
public class Join extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Join() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/consumer/join.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		
		  try {
	            // 필수 정보
	            String email = request.getParameter("email");
	            String password = request.getParameter("password");
	            String name = request.getParameter("name");
	            String nickname = request.getParameter("nickname");
	            String phone = request.getParameter("phone");
	            String postcode = request.getParameter("postcode");
	            String line1 = request.getParameter("line1");
	            String line2 = request.getParameter("line2");
	            
	            // 선택적 정보 처리
	            String birthDateParam = request.getParameter("birthDate");
	            Date birthDate = null;
	            if (birthDateParam != null && !birthDateParam.trim().isEmpty()) {
	                birthDate = Date.valueOf(birthDateParam); // yyyy-MM-dd 형식
	            }
	            
	            String gender = request.getParameter("gender");
	            // gender가 빈 문자열이면 null로 처리
	            if (gender != null && gender.trim().isEmpty()) {
	                gender = null;
	            }
	            
	            String skinTypeIdParam = request.getParameter("skinTypeId");
	            Long skinTypeId = null;
	            if (skinTypeIdParam != null && !skinTypeIdParam.trim().isEmpty()) {
	                skinTypeId = Long.parseLong(skinTypeIdParam);
	            }
	            
	            // Member 객체 생성 (setter 방식)
	            Member member = new Member();
	            member.setEmail(email);
	            member.setPassword(password);
	            member.setName(name);
	            member.setNickname(nickname);
	            member.setPhone(phone);
	            member.setPostcode(postcode);
	            member.setLine1(line1);
	            member.setLine2(line2);
	            member.setBirthDate(birthDate);
	            member.setGender(gender);
	            member.setSkinTypeId(skinTypeId);
	            
	            // 회원가입 처리
	            MemberService service = new MemberServiceImpl();
	            service.join(member);
	            
	            // 성공 시 로그인 페이지로 이동
	            response.sendRedirect("/consumer/login");
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            request.setAttribute("errorMessage", e.getMessage());
	            request.setAttribute("email", request.getParameter("email")); // 입력값 유지
	            request.setAttribute("name", request.getParameter("name"));
	            
	            request.getRequestDispatcher("/consumer/join.jsp").forward(request, response);
	        }
	    }

}
