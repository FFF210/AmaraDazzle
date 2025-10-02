package controller.brand2;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.MembershipPlan;
import service.brand2.MembershipService;
import service.brand2.MembershipServiceImpl;

/**
 * Servlet implementation class Membership
 */
@WebServlet("/brand2/membership")
public class Membership extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MembershipService service = new MembershipServiceImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Membership() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 멤버십플랜 종류
		List<MembershipPlan> plans = service.getMembershipPlans();
		request.setAttribute("plans", plans);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/brand2/membershipPay.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
