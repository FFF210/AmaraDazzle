package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.admin.ConsumerService;
import service.admin.ConsumerServiceImpl;
import util.NumberFormatting;



@WebServlet("/admin/userConsumerDetail")
public class UserConsumerDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		try {
			String num = request.getParameter("num"); 
			ConsumerService member_svc = new ConsumerServiceImpl();
			
			Member member = member_svc.selectMemberDetail(Integer.parseInt(num));
			String userPhone = member.getPhone();
			
			NumberFormatting pno = new NumberFormatting();
			userPhone = pno.formatPhoneNumber(userPhone);
			
			member.setPhone(userPhone);
			
			request.setAttribute("member", member);
			request.getRequestDispatcher("users_consumer_detail.jsp").forward(request, response);

		} catch (Exception e) {
			
			e.printStackTrace();
			
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}






}
