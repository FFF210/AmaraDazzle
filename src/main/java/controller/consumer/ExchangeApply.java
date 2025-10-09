package controller.consumer;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
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

@WebServlet("/store/exchangeApply")
public class ExchangeApply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ExchangeApply() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");

		if (memberId == null) {
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		String orderItemIdStr = request.getParameter("orderItemId");

		if (orderItemIdStr == null || orderItemIdStr.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/store/mypage/orderList");
			return;
		}

		try {
			Long orderItemId = Long.parseLong(orderItemIdStr);

			// 주문 상품 정보 조회
			OrderService orderService = new OrderServiceImpl();
			Map<String, Object> orderItem = orderService.getOrderItemForApply(orderItemId);

			if (orderItem == null) {
				request.setAttribute("err", "주문 상품을 찾을 수 없습니다.");
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
				return;
			}

			// ===== 교환 가능 여부 체크 =====
			String status = (String) orderItem.get("status");

			// 1. 상태 체크 (DELIVERED만 가능)
			if (!"DELIVERED".equals(status)) {
				String statusName = getStatusName(status);
				request.setAttribute("err", "배송완료된 상품만 교환 가능합니다. (현재 상태: " + statusName + ")");
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
				return;
			}

			// 2. 기간 체크 (updated_at 기준 7일 이내)
			Object updatedAtObj = orderItem.get("updatedAt");
			if (updatedAtObj != null) {
				Timestamp updatedAt = null;

				// Timestamp 또는 java.util.Date 타입 처리
				if (updatedAtObj instanceof Timestamp) {
					updatedAt = (Timestamp) updatedAtObj;
				} else if (updatedAtObj instanceof java.util.Date) {
					updatedAt = new Timestamp(((java.util.Date) updatedAtObj).getTime());
				}

				if (updatedAt != null) {
					long diffMillis = System.currentTimeMillis() - updatedAt.getTime();
					long diffDays = diffMillis / (1000 * 60 * 60 * 24);

					if (diffDays > 7) {
						request.setAttribute("err", "교환 가능 기간(배송완료 후 7일)이 지났습니다.");
						request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
						return;
					}
				}
			}

			// 교환 가능한 옵션 목록 조회
			Long productId = ((Number) orderItem.get("productId")).longValue();
			ProductService productService = new ProductServiceImpl();
			List<Map<String, Object>> availableOptions = productService.getProductOptions(productId);

			// 회원 정보 가져오기
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");

		if (memberId == null) {
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		try {
			Long orderId = Long.parseLong(request.getParameter("orderId"));
			Long orderItemId = Long.parseLong(request.getParameter("orderItemId"));

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

			ExchangeService service = new ExchangeServiceImpl();
			service.applyExchange(exchange);
			
			//주문 상품 상태 업데이트
			OrderService orderService = new OrderServiceImpl();
	        orderService.updateOrderItemStatus(orderItemId, "EXCHANGE_REQUESTED");

			response.sendRedirect(request.getContextPath() + "/store/mypage/exchangeReturnCancelList");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "교환 신청 오류: " + e.getMessage());
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

	// 상태명 변환 헬퍼 메서드
	private String getStatusName(String status) {
		switch (status) {
		case "PAID":
			return "결제완료";
		case "PREPARING":
			return "상품준비중";
		case "SHIPPING":
			return "배송중";
		case "DELIVERED":
			return "배송완료";
		case "CONFIRMED":
			return "구매확정";
		case "CANCELLED":
			return "취소완료";
		case "EXCHANGE_REQUESTED":
			return "교환신청";
		case "RETURN_REQUESTED":
			return "반품신청";
		default:
			return status;
		}
	}
}