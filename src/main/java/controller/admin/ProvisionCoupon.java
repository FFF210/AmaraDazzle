package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.CouponService;
import service.admin.CouponServiceImpl;

@WebServlet("/admin/couponProvision")
public class ProvisionCoupon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final CouponService cp_svc = new CouponServiceImpl();


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");
		
		String action = request.getParameter("action"); // couponProvision(쿠폰지급), stock, sale
		PrintWriter pw = response.getWriter();
		
		try {
			if ("couponProvision".equals(action)) {
				// 쿠폰지급
				long couponId = Long.parseLong(request.getParameter("couponId"));
				String provisionGrade = request.getParameter("provisionGrade");
				String startDate = request.getParameter("startDate");
				String reason = request.getParameter("reason");
				
				System.out.println("couponId : " + couponId);
				System.out.println("provisionGrade : " + provisionGrade);
				System.out.println("startDate : " + startDate);
				System.out.println("reason : " + reason);
				
				
				int result = cp_svc.provisionCoupon(couponId, provisionGrade, startDate, reason);
				System.out.println("result : " + result);
				if(result > 0) {
					pw.write("{\"status\":\"ok\",\"title\":\"쿠폰 일괄 지급 완료\",\"message\":\"쿠폰 지급이 완료되었습니다.\"}");
				}

			} else {
				pw.write("{\"status\":\"error\",\"title\":\" \",\"message\":\"알 수 없는 action.\"}");
			}

		} catch (Exception e) {
			e.printStackTrace();
			pw.write("{\"status\":\"error\",\"title\":\" \",\"message\":\"요청 처리 중 오류 발생\"}");
			
		} finally { 
			pw.close();
		}
	}
	

}
