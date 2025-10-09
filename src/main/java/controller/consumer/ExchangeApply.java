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

import dto.Exchange;
import dto.Member;
import service.consumer.ExchangeService;
import service.consumer.ExchangeServiceImpl;
import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;
import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;
import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;

/**
 * Servlet implementation class ExchangeApply
 */
@WebServlet("/store/exchangeApply")
public class ExchangeApply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ExchangeApply() {
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

			// 교환 신청 가능 여부 확인
			ExchangeService exchangeService = new ExchangeServiceImpl();
			if (!exchangeService.canApplyExchange(orderItemId)) {
				request.setAttribute("err", "이미 교환 신청된 상품이거나 교환 가능 기간이 지났습니다.");
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
				return;
			}

			// 주문 상품 정보 조회
			OrderService orderService = new OrderServiceImpl();
			Map<String, Object> orderItem = orderService.getOrderItemForApply(orderItemId);

			// 교환 가능한 옵션 목록 조회
			Long productId = ((Number) orderItem.get("productId")).longValue();
			ProductService productService = new ProductServiceImpl();
			List<Map<String, Object>> availableOptions = productService.getProductOptions(productId);

			// 회원 정보 가져오기 (주소 정보 미리 채우기용)
			MemberService memberService = new MemberServiceImpl();
			Member member = memberService.getMemberInfo(memberId);

			// JSP로 데이터 전달
			request.setAttribute("orderItem", orderItem);
			request.setAttribute("availableOptions", availableOptions);
			request.setAttribute("member", member);
			request.getRequestDispatcher("/consumer/exchangeApply.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "교환 신청 페이지 오류: " + e.getMessage());
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
			response.sendRedirect("/store/login");
			return;
		}

		try {
			// 폼에서 전달받은 데이터
			Long orderId = Long.parseLong(request.getParameter("orderId"));
			Long orderItemId = Long.parseLong(request.getParameter("orderItemId"));

			// 선택적 필드 처리
			String productOptionIdStr = request.getParameter("productOptionId");
			Long productOptionId = (productOptionIdStr != null && !productOptionIdStr.isEmpty())
					? Long.parseLong(productOptionIdStr)
					: null;

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
			String note = request.getParameter("note");
			String returnCarrierName = request.getParameter("returnCarrierName");
			String returnTrackingNo = request.getParameter("returnTrackingNo");
			String shippingCarrierName = request.getParameter("shippingCarrierName");
			String shippingTrackingNo = request.getParameter("shippingTrackingNo");

			// Exchange DTO 생성
			Exchange exchange = new Exchange();
			exchange.setMemberId(memberId);
			exchange.setOrderId(orderId);
			exchange.setOrderItemId(orderItemId);
			exchange.setProductOptionId(productOptionId);
			exchange.setImage1FileId(image1FileId);
			exchange.setImage2FileId(image2FileId);
			exchange.setImage3FileId(image3FileId);
			exchange.setReason(reason);
			exchange.setShippingCost(shippingCost);
			exchange.setShippingCostPayer(shippingCostPayer);
			exchange.setNote(note);
			exchange.setReturnCarrierName(returnCarrierName);
			exchange.setReturnTrackingNo(returnTrackingNo);
			exchange.setShippingCarrierName(shippingCarrierName);
			exchange.setShippingTrackingNo(shippingTrackingNo);

			// 교환 신청
			ExchangeService service = new ExchangeServiceImpl();
			service.applyExchange(exchange);

			// 성공 시 교환 내역 페이지로 리다이렉트
			response.sendRedirect("/store/exchangeList");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "교환 신청 오류: " + e.getMessage());
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
