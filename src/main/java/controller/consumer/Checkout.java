package controller.consumer;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;

/**
 * Servlet implementation class Checkout
 */
@WebServlet("/consumer/checkout")
public class Checkout extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Checkout() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		try {
			// 1. 세션에서 로그인 회원 정보 확인
			HttpSession session = request.getSession();
			Long memberId = (Long) session.getAttribute("memberId");

			if (memberId == null) {
				// 로그인이 안 되어 있으면 로그인 페이지로 리다이렉트
				response.sendRedirect(request.getContextPath() + "/consumer/login");
				return;
			}

			// 2. 요청 파라미터 받기
			String productIdStr = request.getParameter("productId");
			String optionIdStr = request.getParameter("optionId");
			String quantityStr = request.getParameter("quantity");

			// 3. 파라미터 유효성 검사
			if (productIdStr == null || quantityStr == null) {
				request.setAttribute("err", "상품 정보가 없습니다.");
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
				return;
			}

			// 4. 파라미터 변환
			Long productId = Long.parseLong(productIdStr);
			Long optionId = (optionIdStr != null && !optionIdStr.isEmpty()) ? Long.parseLong(optionIdStr) : null;
			int quantity = Integer.parseInt(quantityStr);

			// 5. OrderService 생성 및 체크아웃 데이터 준비
			OrderService orderService = new OrderServiceImpl();
			Map<String, Object> checkoutData = orderService.prepareCheckoutData(memberId, productId, optionId,
					quantity);

			// 6. JSP로 데이터 전달
			request.setAttribute("checkoutData", checkoutData);
			request.setAttribute("productId", productId);
			request.setAttribute("optionId", optionId);
			request.setAttribute("quantity", quantity);

			// 7. checkout.jsp로 포워드
			request.getRequestDispatcher("/consumer/checkout.jsp").forward(request, response);

		} catch (NumberFormatException e) {
			e.printStackTrace();
			request.setAttribute("err", "잘못된 요청 파라미터입니다.");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "체크아웃 페이지 로딩 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		try {
			// 1. 세션에서 회원 정보 확인
			HttpSession session = request.getSession();
			Long memberId = (Long) session.getAttribute("memberId");

			if (memberId == null) {
				response.sendRedirect(request.getContextPath() + "/consumer/login");
				return;
			}

			// 2. 폼 데이터 수집
			Map<String, Object> orderData = collectOrderDataFromRequest(request, memberId);

			// 3. OrderService 생성
			OrderService orderService = new OrderServiceImpl();

			// 4. 포인트 사용 가능 여부 확인 (포인트 사용하는 경우만)
			Integer usingPoint = (Integer) orderData.get("usingPoint");
			if (usingPoint != null && usingPoint > 0) {
				boolean pointAvailable = orderService.checkPointAvailable(memberId, usingPoint);
				if (!pointAvailable) {
					request.setAttribute("err", "포인트 잔액이 부족합니다.");
					request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
					return;
				}
			}

			// 5. 주문 생성
			Long orderId = orderService.createOrder(orderData);

			if (orderId != null) {
				// 주문 성공 - 주문 완료 페이지로 리다이렉트
				response.sendRedirect(request.getContextPath() + "/consumer/orderComplete?orderId=" + orderId);

			} else {
				// 주문 실패
				request.setAttribute("err", "주문 처리 중 오류가 발생했습니다.");
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
			}

		} catch (NumberFormatException e) {
			e.printStackTrace();
			request.setAttribute("err", "입력 데이터가 올바르지 않습니다.");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "주문 처리 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

	/**
	 * 요청에서 주문 데이터 수집 - 폼 데이터를 Map으로 변환
	 */
	private Map<String, Object> collectOrderDataFromRequest(HttpServletRequest request, Long memberId) {
		Map<String, Object> orderData = new HashMap<>();

		// 기본 정보
		orderData.put("memberId", memberId);
		orderData.put("phone", request.getParameter("phone"));

		// 배송지 정보
		orderData.put("shipRecipient", request.getParameter("shipRecipient"));
		orderData.put("shipPhone", request.getParameter("shipPhone"));
		orderData.put("shipPostcode", request.getParameter("shipPostcode"));
		orderData.put("shipLine1", request.getParameter("shipLine1"));
		orderData.put("shipLine2", request.getParameter("shipLine2"));
		orderData.put("note", request.getParameter("note"));

		// 상품 정보
		orderData.put("productId", Long.parseLong(request.getParameter("productId")));
		orderData.put("quantity", Integer.parseInt(request.getParameter("quantity")));
		orderData.put("brandId", Long.parseLong(request.getParameter("brandId")));

		// 옵션 정보 (있는 경우만)
		String optionIdStr = request.getParameter("optionId");
		if (optionIdStr != null && !optionIdStr.isEmpty()) {
			orderData.put("optionId", Long.parseLong(optionIdStr));
		}

		// 금액 정보
		orderData.put("unitPrice", new BigDecimal(request.getParameter("unitPrice")));
		orderData.put("subtotalAmount", new BigDecimal(request.getParameter("subtotalAmount")));
		orderData.put("discountAmount", new BigDecimal(request.getParameter("discountAmount")));
		orderData.put("shippingAmount", new BigDecimal(request.getParameter("shippingAmount")));
		orderData.put("totalAmount", new BigDecimal(request.getParameter("totalAmount")));

		// 할인 정보
		orderData.put("usingCoupon", request.getParameter("usingCoupon"));
		String usingPointStr = request.getParameter("usingPoint");
		orderData.put("usingPoint",
				(usingPointStr != null && !usingPointStr.isEmpty()) ? Integer.parseInt(usingPointStr) : 0);

		// 주문 상품 계산 정보
		BigDecimal unitPrice = (BigDecimal) orderData.get("unitPrice");
		Integer quantity = (Integer) orderData.get("quantity");
		BigDecimal lineSubtotal = unitPrice.multiply(new BigDecimal(quantity));

		orderData.put("lineSubtotal", lineSubtotal);
		orderData.put("itemDiscount", BigDecimal.ZERO);
		orderData.put("itemTotal", lineSubtotal);

		return orderData;
	}

}
