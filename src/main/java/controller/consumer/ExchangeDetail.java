package controller.consumer;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.consumer.ExchangeService;
import service.consumer.ExchangeServiceImpl;
import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;

/**
 * Servlet implementation class ExchangeDetail
 */
@WebServlet(name = "ExchangeDetailConsumer", urlPatterns = { "/store/exchangeDetail" })
public class ExchangeDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExchangeDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.setCharacterEncoding("utf-8");
		
		// 로그인 체크
		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");
		
		if (memberId == null) {
			response.sendRedirect("/store/login");
			return;
		}
		
		// 교환 ID 받아오기
		String exchangeId = request.getParameter("exchangeId");
		
		if (exchangeId == null || exchangeId.isEmpty()) {
			response.sendRedirect("/store/exchangeList");
			return;
		}
		
		try {
			ExchangeService exchangeService = new ExchangeServiceImpl();
			Map<String, Object> exchange = exchangeService.getExchangeById(Long.parseLong(exchangeId));
			
			// 본인의 교환 내역인지 확인
			Long exchangeMemberId = ((Number) exchange.get("memberId")).longValue();
		    if (!exchangeMemberId.equals(memberId)) {
		        request.setAttribute("err", "접근 권한이 없습니다.");
		        request.getRequestDispatcher("/error.jsp").forward(request, response);
		        return;
		    }
			
			// 회원 정보 가져오기
			MemberService memberService = new MemberServiceImpl();
			Member member = memberService.getMemberInfo(memberId);
			
			// JSP로 데이터 전달
			request.setAttribute("exchange", exchange);
			request.setAttribute("member", member);
			request.getRequestDispatcher("/consumer/exchangeDetail.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "교환 상세 조회 오류");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
