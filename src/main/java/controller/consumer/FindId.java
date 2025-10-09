package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;

/**
 * Servlet implementation class FindId
 */
@WebServlet("/store/findId")
public class FindId extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FindId() {
		super();
		// TODO Auto-generated constructor stub
	}

	// GET 요청 - 페이지 보여주기
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/consumer/findAccount.jsp").forward(request, response);
	}

	// POST 요청 - 아이디 찾기 처리
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 요청 인코딩 설정
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		// 파라미터 받기
		String name = request.getParameter("memberName");
		String phone = request.getParameter("phone");

		System.out.println("아이디 찾기 - 이름: " + name + ", 전화번호: " + phone);

		try {
			MemberService service = new MemberServiceImpl();

			// 이메일 찾기 (이미 Service에 구현되어 있음!)
			String email = service.findEmailByNameAndPhone(name, phone);

			System.out.println("찾은 이메일: " + email);

			// 성공 - 찾은 이메일을 request에 담아서 JSP로 전달
			request.setAttribute("success", true);
			request.setAttribute("foundEmail", email);
			request.setAttribute("tabType", "findId"); // 아이디 찾기 탭 유지

			request.getRequestDispatcher("/consumer/findAccount.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();

			// 실패 - 에러 메시지를 담아서 JSP로 전달
			request.setAttribute("success", false);
			request.setAttribute("errorMessage", e.getMessage());
			request.setAttribute("tabType", "findId");
			request.setAttribute("memberName", name); // 입력값 유지
			request.setAttribute("phone", phone); // 입력값 유지

			request.getRequestDispatcher("/consumer/findAccount.jsp").forward(request, response);
		}
	}
}
