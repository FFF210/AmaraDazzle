package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.SettlementService;
import service.admin.SettlementServiceImpl;

//정산 수동실행
@WebServlet("/admin/settleManual")
public class SettlementManual extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final SettlementService settle_svc = new SettlementServiceImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");
		
		PrintWriter pw = response.getWriter();
		try {
			LocalDate today = LocalDate.now();
			LocalDate firstDayPrevMonth = today.minusMonths(1).withDayOfMonth(1);	//정산 시작일 
			LocalDate lastDayPrevMonth = today.minusMonths(1).withDayOfMonth(today.minusMonths(1).lengthOfMonth());	//정산 마지막일
			
			String json = null;
			int result = settle_svc.monthlyInsertSettle(firstDayPrevMonth, lastDayPrevMonth);
			System.out.println("result : " + result);
			
			if (result > 0) {
				json = "{\"status\":\"ok\"}";
				pw.print(json);
				
			} else {
				json = "{\"status\":\"fail\",\"title\":\"정산리스트 불러오기 실패\",\"message\":\"시스템문제로 리스트 불러오기에 실패했습니다.\"}";
				pw.print(json);
			}
			
		} catch (Exception e) {
		
			
		} finally {
			pw.flush();
			pw.close();
			
		}

	}
}
