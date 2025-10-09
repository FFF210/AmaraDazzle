package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Coupon;
import service.admin.CouponService;
import service.admin.CouponServiceImpl;
import util.NumberFormatting;



@WebServlet("/admin/publCouponDetail")
public class PublCouponDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		try {
			String num = request.getParameter("num"); 
			CouponService cp_svc = new CouponServiceImpl();
			
			Coupon coupon = cp_svc.publCouponDetail(Integer.parseInt(num));
			
			String amountCondition = coupon.getAmountCondition();
			if(!amountCondition.equals("-")) {
				NumberFormatting ac = new NumberFormatting();
				amountCondition = ac.formatMoney(Long.parseLong(amountCondition));
				
				coupon.setAmountCondition(amountCondition);
			}
			
			request.setAttribute("coupon", coupon);
			request.getRequestDispatcher("promotion_couponPubl_detail.jsp").forward(request, response);

		} catch (Exception e) {
			
			e.printStackTrace();
			
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}






}
