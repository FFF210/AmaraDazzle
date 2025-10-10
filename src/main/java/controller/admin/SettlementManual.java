package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.admin.SettlementDAO;
import dao.admin.SettlementDAOImpl;

//정산 수동실행
@WebServlet("/admin/SettleManual")
public class SettlementManual extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SettlementDAO dao = new SettlementDAOImpl();
		int result = dao.settleAll();

		request.setAttribute("message", "수동 정산 완료 - " + result + "건 처리됨");
		request.getRequestDispatcher("/WEB-INF/views/admin/settlementResult.jsp").forward(request, response);
	}
}
