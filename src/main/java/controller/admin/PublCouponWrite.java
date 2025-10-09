package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Coupon;
import service.admin.CouponService;
import service.admin.CouponServiceImpl;

@WebServlet("/admin/pCouponWrite")
@MultipartConfig
public class PublCouponWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// GET
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/admin/promotion_couponPubl_write.jsp").forward(request, response);
	}

	// POST
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=UTF-8");
		
		PrintWriter pw = response.getWriter();

		try {
			String cp_name = request.getParameter("couponName"); //쿠폰명
			Integer cp_amount = Integer.parseInt(request.getParameter("couponAmount")); //쿠폰금액
			Timestamp startDate = Timestamp.valueOf(request.getParameter("startDate")+ " 00:00:00"); //쿠폰 유효기간 시작일
			Timestamp endDate =  Timestamp.valueOf(request.getParameter("endDate")+ " 23:59:59"); //쿠폰 유효기간 마지막일
			String l_cate = request.getParameter("category1Id"); //카테고리 - 대분류 
			String m_cate = request.getParameter("category2Id"); //카테고리 - 중분류 
			String s_cate = request.getParameter("category3Id"); //카테고리 - 소분류 
			String cp_condition = request.getParameter("couponCondition"); //쿠폰 사용조건 
			String pch_noRestr = request.getParameter("pch_noRestr"); // 사용조건 제한없음 
			String cp_target = request.getParameter("cpTarget"); //지급대상
			String cp_reason = request.getParameter("couponReason"); //지급 사유 
			Long cp_writer = Long.parseLong(request.getParameter("cpWriter")); // 발행한 관리자 코드
			
			System.out.println("cp_name : " + cp_name);
			System.out.println("cp_amount : " + cp_amount);
			System.out.println("startDate : " + startDate);
			System.out.println("endDate : " + endDate);
			System.out.println("l_cate : " + l_cate);
			System.out.println("m_Cate : " + m_cate);
			System.out.println("s_cate : " + s_cate);
			System.out.println("cp_condition : " + cp_condition);
			System.out.println("pch_noRestr : " + pch_noRestr);
			System.out.println("cp_target : " + cp_target);
			System.out.println("coupon_reason : " + cp_reason);
			System.out.println("cp_writer : " + cp_writer);

			Long cateIdx = null;
			if (s_cate != null && !s_cate.isEmpty()) {
			    cateIdx = Long.parseLong(s_cate);
			} else if (m_cate != null && !m_cate.isEmpty()) {
			    cateIdx = Long.parseLong(m_cate);
			} else if (l_cate != null && !l_cate.isEmpty()) {
			    cateIdx = Long.parseLong(l_cate);
			}

			Coupon pCoupon = new Coupon(cp_name, startDate, endDate, cp_amount, cateIdx, cp_condition, cp_reason, cp_target, "ADMIN", cp_writer, pch_noRestr);

			CouponService coupon_svc = new CouponServiceImpl();
			int result = coupon_svc.insertPublCoupon(pCoupon);
			
			if(result > 0) {  //DB 입력 성공시
				pw.print("{\"status\":\"ok\",\"title\":\"쿠폰 발행 완료\",\"message\":\"쿠폰 등록이 완료되었습니다.\"}");
					
			} else {
				pw.print("{\"status\":\"fail\",\"title\":\"쿠폰 발행 실패\",\"message\":\"시스템 문제로 쿠폰 등록에 실패했습니다.\"}");
			}

			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "시스템 오류로 공지 작성에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
			
		} finally {
			pw.flush();
			pw.close();
		}

	}

}
