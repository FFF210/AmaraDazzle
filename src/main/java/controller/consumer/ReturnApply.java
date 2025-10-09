package controller.consumer;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import dto.Returns;
import service.consumer.ExchangeService;
import service.consumer.ExchangeServiceImpl;
import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;
import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;
import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;
import service.consumer.ReturnService;
import service.consumer.ReturnServiceImpl;

/**
 * Servlet implementation class ReturnApply
 */
@WebServlet("/store/returnApply")
public class ReturnApply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReturnApply() {
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

		// 로그인 체크
		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");

		if (memberId == null) {
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		// 주문 상품 ID 받아오기
		String orderItemIdStr = request.getParameter("orderItemId");

		if (orderItemIdStr == null || orderItemIdStr.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/store/mypage/orderList");
			return;
		}

		try {
			Long orderItemId = Long.parseLong(orderItemIdStr);

			// 반품 신청 가능 여부 확인
			ReturnService returnService = new ReturnServiceImpl();
			if (!returnService.canApplyReturns(orderItemId)) {
				request.setAttribute("err", "이미 반품 신청된 상품이거나 반품 가능 기간이 지났습니다.");
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
				return;
			}

			// 주문 상품 정보 조회
			OrderService orderService = new OrderServiceImpl();
			Map<String, Object> orderItem = orderService.getOrderItemForApply(orderItemId);

			// 회원 정보 가져오기 (주소 정보 미리 채우기용)
			MemberService memberService = new MemberServiceImpl();
			Member member = memberService.getMemberInfo(memberId);

			// JSP로 데이터 전달
			request.setAttribute("orderItem", orderItem);
			request.setAttribute("member", member);
			request.getRequestDispatcher("/consumer/returnApply.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "반품 신청 페이지 오류: " + e.getMessage());
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 로그인 체크
		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");

		if (memberId == null) {
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		try {
			// 폼에서 전달받은 데이터
			Long orderItemId = Long.parseLong(request.getParameter("orderItemId"));

			// 선택적 필드 처리
			String image1FileIdStr = request.getParameter("image1FileId");
			Long image1FileId = (image1FileIdStr != null && !image1FileIdStr.isEmpty())
					? Long.parseLong(image1FileIdStr)
					: null;

			String image2FileIdStr = request.getParameter("image2FileId");
			Long image2FileId = (image2FileIdStr != null && !image2FileIdStr.isEmpty())
					? Long.parseLong(image2FileIdStr)
					: null;

			String image3FileIdStr = request.getParameter("image3FileId");
			Long image3FileId = (image3FileIdStr != null && !image3FileIdStr.isEmpty())
					? Long.parseLong(image3FileIdStr)
					: null;

			String reason = request.getParameter("reason");
			BigDecimal shippingCost = new BigDecimal(request.getParameter("shippingCost"));
			String shippingCostPayer = request.getParameter("shippingCostPayer");

			// 택배 정보는 선택적
			String returnCarrierName = request.getParameter("returnCarrierName");
			String returnTrackingNo = request.getParameter("returnTrackingNo");

			// Returns DTO 생성
			Returns returns = new Returns();
			returns.setMemberId(memberId);
			returns.setOrderItemId(orderItemId);
			returns.setImage1FileId(image1FileId);
			returns.setImage2FileId(image2FileId);
			returns.setImage3FileId(image3FileId);
			returns.setReason(reason);
			returns.setShippingCost(shippingCost);
			returns.setShippingCostPayer(shippingCostPayer);
			returns.setReturnCarrierName(returnCarrierName);
			returns.setReturnTrackingNo(returnTrackingNo);

			// 반품 신청
			ReturnService returnService = new ReturnServiceImpl();
			returnService.applyReturns(returns);
			
			//주문 상품 상태 업데이트
			OrderService orderService = new OrderServiceImpl();
	        orderService.updateOrderItemStatus(orderItemId, "EXCHANGE_REQUESTED");

			// 성공 시 취소/교환/반품 내역 페이지로 리다이렉트
			response.sendRedirect(request.getContextPath() + "/store/mypage/exchangeReturnCancelList");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "반품 신청 오류: " + e.getMessage());
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
