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
import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;
import service.consumer.ReturnService;
import service.consumer.ReturnServiceImpl;

/**
 * Servlet implementation class ReturnDetail
 */
@WebServlet(name = "ReturnDetailConsumer", urlPatterns = { "/store/returnDetail" })
public class ReturnDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReturnDetail() {
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
		
		// 반품 ID 받아오기
		String returnsId = request.getParameter("returnsId");
		
		if (returnsId == null || returnsId.isEmpty()) {
			response.sendRedirect("/store/cancelExchangeReturnList");
			return;
		}
		
		try {
			ReturnService returnService = new ReturnServiceImpl();
			Map<String, Object> returns = returnService.getReturnsById(Long.parseLong(returnsId));
			
			// 본인의 반품 내역인지 확인
			Long returnMemberId = ((Number) returns.get("memberId")).longValue();
			if (!returnMemberId.equals(memberId)) {
			    request.setAttribute("err", "접근 권한이 없습니다.");
			    request.getRequestDispatcher("/error.jsp").forward(request, response);
			    return;
			}
			
			//회원 정보 가져오기
			MemberService memberService = new MemberServiceImpl();
			Member member = memberService.getMemberInfo(memberId);
			
			// JSP로 데이터 전달
			request.setAttribute("returns", returns);
			request.setAttribute("member", member);
			request.getRequestDispatcher("/consumer/returnDetail.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "반품 상세 조회 오류");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
