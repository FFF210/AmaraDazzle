package controller.consumer;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
@WebServlet("/store/checkout")
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
				response.sendRedirect(request.getContextPath() + "/store/login");
				return;
			}

			// 2. 요청 파라미터 받기
			String productIdStr = request.getParameter("productId");

			if (productIdStr == null) {
				request.setAttribute("err", "상품 정보가 없습니다.");
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
				return;
			}

			Long productId = Long.parseLong(productIdStr);

			// 3. 여러 옵션인지 단일 상품인지 확인
			String[] optionIdParams = new String[10]; // 최대 10개
			String[] quantityParams = new String[10];
			int itemCount = 0;

			// items[0].optionId, items[1].optionId... 형태로 파라미터 수집
			for (int i = 0; i < 10; i++) {
				String optionId = request.getParameter("items[" + i + "].optionId");
				String quantity = request.getParameter("items[" + i + "].quantity");

				if (optionId != null && quantity != null) {
					optionIdParams[itemCount] = optionId;
					quantityParams[itemCount] = quantity;
					itemCount++;
				} else {
					break; // 더 이상 옵션 없음
				}
			}

			OrderService orderService = new OrderServiceImpl();
			Map<String, Object> checkoutData;

			if (itemCount > 0) {
				// 여러 옵션 처리
				String[] finalOptionIds = new String[itemCount];
				String[] finalQuantities = new String[itemCount];
				System.arraycopy(optionIdParams, 0, finalOptionIds, 0, itemCount);
				System.arraycopy(quantityParams, 0, finalQuantities, 0, itemCount);

				checkoutData = orderService.prepareCheckoutDataForMultipleOptions(memberId, productId, finalOptionIds,
						finalQuantities);

				request.setAttribute("items", itemCount); // 옵션 개수 전달
			} else {
				// 단일 상품 (옵션 없음)
				String quantityStr = request.getParameter("quantity");
				int quantity = quantityStr != null ? Integer.parseInt(quantityStr) : 1;

				checkoutData = orderService.prepareCheckoutData(memberId, productId, null, quantity);
			}

			// 6. JSP로 데이터 전달
			request.setAttribute("checkoutData", checkoutData);
			request.setAttribute("productId", productId);

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
				response.sendRedirect(request.getContextPath() + "/store/login");
				return;
			}

			// 2. 디버깅: 파라미터 확인
			System.out.println("=== 받은 파라미터 확인 ===");
			System.out.println("productId: " + request.getParameter("productId"));
			System.out.println("brandId: " + request.getParameter("brandId"));
			System.out.println("shipRecipient: " + request.getParameter("shipRecipient"));
			System.out.println("subtotalAmount: " + request.getParameter("subtotalAmount"));

			// 3. 주문 데이터 수집 (null 체크 추가)
			Map<String, Object> orderData = new HashMap<>();

			// 배송지 정보
			orderData.put("memberId", memberId);
			orderData.put("shipRecipient", request.getParameter("shipRecipient"));
			orderData.put("shipPhone", request.getParameter("shipPhone"));
			orderData.put("shipPostcode", request.getParameter("shipPostcode"));
			orderData.put("shipLine1", request.getParameter("shipLine1"));
			orderData.put("shipLine2", request.getParameter("shipLine2"));
			orderData.put("note", request.getParameter("note"));

			// 상품 정보 (null 체크)
			String productIdStr = request.getParameter("productId");
			String brandIdStr = request.getParameter("brandId");

			if (productIdStr == null || brandIdStr == null) {
				System.out.println("ERROR: productId 또는 brandId가 null입니다!");
				response.setContentType("text/plain; charset=UTF-8");
				response.getWriter()
						.write("ERROR:상품 정보가 없습니다 (productId: " + productIdStr + ", brandId: " + brandIdStr + ")");
				return;
			}

			System.out.println("productIdStr: [" + productIdStr + "], 길이: " + productIdStr.length());
			System.out.println("brandIdStr: [" + brandIdStr + "], 길이: " + brandIdStr.length());

			if (productIdStr == null || productIdStr.isEmpty()) {
				// 에러!
			}

			orderData.put("productId", Long.parseLong(productIdStr));
			orderData.put("brandId", Long.parseLong(brandIdStr));

			// 여러 옵션 처리
			List<Map<String, Object>> itemsList = new ArrayList<>();
			for (int i = 0; i < 10; i++) {
				String optionId = request.getParameter("items[" + i + "].optionId");
				String quantity = request.getParameter("items[" + i + "].quantity");

				System.out.println("items[" + i + "].optionId: " + optionId);
				System.out.println("items[" + i + "].quantity: " + quantity);

				if (optionId != null && quantity != null) {
					Map<String, Object> item = new HashMap<>();

					// optionId가 빈 문자열이면 null로 처리
					if (optionId != null && !optionId.trim().isEmpty()) {
						item.put("optionId", Long.parseLong(optionId));
					} else {
						item.put("optionId", null); // 옵션 없는 상품
					}

					item.put("quantity", Integer.parseInt(quantity));
					itemsList.add(item);
				} else {
					break;
				}
			}
			orderData.put("items", itemsList);

			// 금액 정보 (null 체크)
			String subtotalStr = request.getParameter("subtotalAmount");
			String discountStr = request.getParameter("discountAmount");
			String shippingStr = request.getParameter("shippingAmount");
			String totalStr = request.getParameter("totalAmount");

			if (subtotalStr == null || discountStr == null || shippingStr == null || totalStr == null) {
				System.out.println("ERROR: 금액 정보가 null입니다!");
				response.setContentType("text/plain; charset=UTF-8");
				response.getWriter().write("ERROR:금액 정보가 없습니다");
				return;
			}

			orderData.put("subtotalAmount", new BigDecimal(subtotalStr));
			orderData.put("discountAmount", new BigDecimal(discountStr));
			orderData.put("shippingAmount", new BigDecimal(shippingStr));
			orderData.put("totalAmount", new BigDecimal(totalStr));

			// 할인 정보
			orderData.put("usingCoupon", request.getParameter("usingCoupon"));
			String usingPointStr = request.getParameter("usingPoint");
			orderData.put("usingPoint",
					(usingPointStr != null && !usingPointStr.isEmpty()) ? Integer.parseInt(usingPointStr) : 0);

			// 4. 임시 주문 ID 생성
			String temporaryOrderId = "ORDER_" + System.currentTimeMillis();

			// 5. 세션에 주문 데이터 저장
			session.setAttribute("pendingOrderData", orderData);
			session.setAttribute("temporaryOrderId", temporaryOrderId);

			System.out.println("세션에 저장 완료: " + temporaryOrderId);

			// 6. 성공 응답
			response.setContentType("text/plain; charset=UTF-8");
			response.getWriter().write("SUCCESS:" + temporaryOrderId);

		} catch (Exception e) {
			e.printStackTrace();
			response.setContentType("text/plain; charset=UTF-8");
			response.getWriter().write("ERROR:" + e.getMessage());
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

		// 전화번호 3개를 합치기
		String phone1 = request.getParameter("shipPhone1");
		String phone2 = request.getParameter("shipPhone2");
		String phone3 = request.getParameter("shipPhone3");
		String fullPhone = phone1 + "-" + phone2 + "-" + phone3;

		// 배송지 정보
		orderData.put("shipRecipient", request.getParameter("shipRecipient"));
		orderData.put("shipPhone", fullPhone);
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
