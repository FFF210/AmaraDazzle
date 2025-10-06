package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Ticket;
import service.consumer.TicketService;
import service.consumer.TicketServiceImpl;

/**
 * Servlet implementation class TicketCreate
 */
@WebServlet("/store/mypage/ticketCreate")
public class TicketCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TicketCreate() {
		super();
		// TODO Auto-generated constructor stub
	}

	// ============ GET: 문의 작성 폼 보여주기 ============
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		Long userId = (Long) session.getAttribute("memberId");

		if (userId == null) {
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		// 문의 작성 폼으로 이동
		request.getRequestDispatcher("/consumer/writeTicket.jsp").forward(request, response);
	}

	// ============ POST: 문의 등록 처리 ============
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		Long userId = (Long) session.getAttribute("memberId");
		String userType = "CONSUMER";

		if (userId == null) {
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		try {
			// 파라미터 받기
			String category = request.getParameter("category");
			String orderCode = request.getParameter("orderCode");
			String question = request.getParameter("question");
			String recieverType = request.getParameter("recieverType");
			String recieverIdStr = request.getParameter("recieverId");

			// 이미지 파일 ID
			String image1Str = request.getParameter("image1FileId");
			String image2Str = request.getParameter("image2FileId");
			String image3Str = request.getParameter("image3FileId");

			// Ticket 객체 생성
			Ticket ticket = new Ticket();
			ticket.setSenderType(userType);
			ticket.setSenderId(userId);
			ticket.setCategory(category);
			ticket.setQuestion(question);

			// 답변 주체 설정
			if (recieverType != null && !recieverType.isEmpty()) {
				ticket.setRecieverType(recieverType);
			} else {
				ticket.setRecieverType("ADMIN");
			}

			// 답변 주체 ID
			if (recieverIdStr != null && !recieverIdStr.isEmpty()) {
				ticket.setRecieverId(Long.parseLong(recieverIdStr));
			}

			// 이미지 파일 ID 설정
			if (image1Str != null && !image1Str.isEmpty()) {
				ticket.setImage1FileId(Long.parseLong(image1Str));
			}
			if (image2Str != null && !image2Str.isEmpty()) {
				ticket.setImage2FileId(Long.parseLong(image2Str));
			}
			if (image3Str != null && !image3Str.isEmpty()) {
				ticket.setImage3FileId(Long.parseLong(image3Str));
			}

			// 서비스 호출
			TicketService service = new TicketServiceImpl();
			service.createTicket(ticket, orderCode);

			// 성공 시 목록으로 리다이렉트
			response.sendRedirect(request.getContextPath() + "/store/ticketList");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "문의 등록 오류: " + e.getMessage());
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
