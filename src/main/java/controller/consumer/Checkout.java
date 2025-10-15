package controller.consumer;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.consumer.MemberCouponDAO;
import dao.consumer.MemberCouponDAOImpl;
import service.consumer.CartItemService;
import service.consumer.CartItemServiceImpl;
import service.consumer.MemberCouponService;
import service.consumer.MemberCouponServiceImpl;
import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;
import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;

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
				response.sendRedirect(request.getContextPath() + "/store/login");
				return;
			}

			// 장바구니에서 온 경우 처리
			String[] cartItemIdsArray = request.getParameterValues("cartItemIds");

			if (cartItemIdsArray != null && cartItemIdsArray.length > 0) {
				System.out.println("=== 장바구니에서 체크아웃 시작 ===");

				// 장바구니 아이템 ID 리스트 변환
				List<Long> cartItemIds = new ArrayList<>();
				for (String id : cartItemIdsArray) {
					cartItemIds.add(Long.parseLong(id));
				}

				// 선택된 장바구니 상품 조회
				CartItemService cartService = new CartItemServiceImpl();
				List<Map<String, Object>> cartItems = cartService.getSelectedItemsForCheckout(memberId, cartItemIds);

				System.out.println("선택된 장바구니 상품 개수: " + cartItems.size());

				// OrderService로 체크아웃 데이터 준비
				OrderService orderService = new OrderServiceImpl();
				Map<String, Object> checkoutData = orderService.prepareCheckoutDataForCart(memberId, cartItems);

				// 쿠폰 목록 조회
				MemberCouponDAO couponDAO = new MemberCouponDAOImpl();
				Map<String, Object> couponParams = new HashMap<>();
				couponParams.put("memberId", memberId);
				couponParams.put("limit", 100);
				couponParams.put("offset", 0);
				///////////////////////////
				List<Long> brandList = cartItems.stream().map(m->(Long)m.get("brandId")).collect(Collectors.toList());
				couponParams.put("brands",brandList);
				System.out.println(brandList);

				List<Map<String, Object>> availableCoupons = couponDAO.selectMemberCouponList(couponParams);
				System.out.println("----");
				System.out.println(couponParams);
				System.out.println(availableCoupons);
				request.setAttribute("availableCoupons", availableCoupons);

				// JSP로 데이터 전달
				request.setAttribute("checkoutData", checkoutData);
				request.getRequestDispatcher("/consumer/checkout.jsp").forward(request, response);
				return;
			}

			// 요청 파라미터 받기
			String productIdStr = request.getParameter("productId");

			if (productIdStr == null) {
				request.setAttribute("err", "상품 정보가 없습니다.");
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
				return;
			}

			Long productId = Long.parseLong(productIdStr);

			// 여러 옵션인지 단일 상품인지 확인
			String[] optionIdParams = new String[10];
			String[] quantityParams = new String[10];
			int itemCount = 0;

			for (int i = 0; i < 10; i++) {
				String optionId = request.getParameter("items[" + i + "].optionId");
				String quantity = request.getParameter("items[" + i + "].quantity");

				if (optionId != null && quantity != null) {
					optionIdParams[itemCount] = optionId;
					quantityParams[itemCount] = quantity;
					itemCount++;
				} else {
					break;
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

				request.setAttribute("items", itemCount);
			} else {
				// 단일 상품 (옵션 없음)
				String quantityStr = request.getParameter("quantity");
				int quantity = quantityStr != null ? Integer.parseInt(quantityStr) : 1;

				checkoutData = orderService.prepareCheckoutData(memberId, productId, null, quantity);
			}

			// ✅ Service가 만든 데이터 확인 (디버깅용)
			System.out.println("=== Service가 준비한 checkoutData ===");
			System.out.println("subtotalAmount: " + checkoutData.get("subtotalAmount"));
			System.out.println("shippingFee: " + checkoutData.get("shippingFee"));
			System.out.println("totalAmount: " + checkoutData.get("totalAmount"));

			@SuppressWarnings("unchecked")
			List<Map<String, Object>> items = (List<Map<String, Object>>) checkoutData.get("items");
			if (items != null) {
				System.out.println("items 개수: " + items.size());
				for (int i = 0; i < items.size(); i++) {
					Map<String, Object> item = items.get(i);
					System.out.println("  Item " + i + ": unitPrice=" + item.get("unitPrice") + ", quantity="
							+ item.get("quantity") + ", itemTotal=" + item.get("itemTotal"));
				}
			}

			// 쿠폰 목록 조회
			MemberCouponDAO couponDAO = new MemberCouponDAOImpl();
			Map<String, Object> couponParams = new HashMap<>();
			couponParams.put("memberId", memberId);
			couponParams.put("limit", 100);
			couponParams.put("offset", 0);
			///////////////////////////
			ProductService servic = new ProductServiceImpl();
			couponParams.put("brands",new ArrayList<Long>().add(servic.getProductDetail(productId).getBrandId()));

			List<Map<String, Object>> availableCoupons = couponDAO.selectMemberCouponList(couponParams);
			request.setAttribute("availableCoupons", availableCoupons);

			// JSP로 데이터 전달 (Service가 만든 데이터 그대로 전달!)
			request.setAttribute("checkoutData", checkoutData);
			request.setAttribute("productId", productId);

			// checkout.jsp로 포워드
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

			// 상품 정보 (장바구니면 없을 수 있음)
			String productIdStr = request.getParameter("productId");
			String brandIdStr = request.getParameter("brandId");

			if (productIdStr != null && !productIdStr.isEmpty()) {
				orderData.put("productId", Long.parseLong(productIdStr));
			}
			if (brandIdStr != null && !brandIdStr.isEmpty()) {
				orderData.put("brandId", Long.parseLong(brandIdStr));
			}

			// 여러 옵션 처리
			List<Map<String, Object>> itemsList = new ArrayList<>();
			Integer itemCnt = Integer.parseInt(request.getParameter("itemCnt"));
			for (int i = 0; i < itemCnt; i++) {
				String brandId = request.getParameter("items[" + i + "].brandId");
				String productId = request.getParameter("items[" + i + "].productId");
				String optionId = request.getParameter("items[" + i + "].optionId");
				String quantity = request.getParameter("items[" + i + "].quantity");
				String unitPrice = request.getParameter("items[" + i + "].unitPrice");
				String itemTotal = request.getParameter("items[" + i + "].itemTotal");
				String memberCouponId = request.getParameter("items[" + i + "].memberCouponId");

				System.out.println("items[" + i + "].brandId: " + brandId);
				System.out.println("items[" + i + "].productId: " + productId);
				System.out.println("items[" + i + "].optionId: " + optionId);
				System.out.println("items[" + i + "].quantity: " + quantity);
				System.out.println("items[" + i + "].unitPrice: " + unitPrice);
				System.out.println("items[" + i + "].itemTotal: " + itemTotal);
				System.out.println("items[" + i + "].memberCouponId: " + memberCouponId);

				if (quantity != null && !quantity.trim().isEmpty() && unitPrice != null
						&& !unitPrice.trim().isEmpty()) {

					Map<String, Object> item = new HashMap<>();

					// brandId, productId
					if (brandId != null && !brandId.trim().isEmpty()) {
						item.put("brandId", Long.parseLong(brandId));
					}
					if (productId != null && !productId.trim().isEmpty()) {
						item.put("productId", Long.parseLong(productId));
					}

					// optionId가 빈 문자열이면 null로 처리
					if (optionId != null && !optionId.trim().isEmpty()) {
						item.put("optionId", Long.parseLong(optionId));
					} else {
						item.put("optionId", null); // 옵션 없는 상품
					}

					item.put("productId", productId);
					item.put("quantity", Integer.parseInt(quantity));
					item.put("unitPrice", new BigDecimal(unitPrice));
					item.put("itemTotal", new BigDecimal(itemTotal));
					if(memberCouponId!=null && !memberCouponId.isEmpty()) {
						item.put("memberCouponId", Long.parseLong(memberCouponId));
					}

					itemsList.add(item);
				} 
			}
			orderData.put("items", itemsList);

			if (itemsList.isEmpty()) {
				System.out.println("ERROR: 주문 상품이 없습니다!");
				response.setContentType("text/plain; charset=UTF-8");
				response.getWriter().write("ERROR:주문 상품이 없습니다");
				return;
			}

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

			// ===== 쿠폰 검증 (중복 선언 제거) =====
			String usingCouponStr = request.getParameter("usingCoupon");

//			// 쿠폰 할인 금액
//			int couponAmount = Integer.parseInt(request.getParameter("couponAmount"));
//			orderData.put("couponAmount", couponAmount);

			Long memberCouponId = null;
			int couponDiscount = 0;

			if (usingCouponStr != null && !usingCouponStr.trim().isEmpty()) {
				memberCouponId = Long.parseLong(usingCouponStr.trim());

				// 쿠폰 유효성 검증
				MemberCouponService couponService = new MemberCouponServiceImpl();

				// 주문 금액
				int orderAmount = new BigDecimal(subtotalStr).intValue();

				Map<String, Object> validCoupon = couponService.validateCoupon(memberId, memberCouponId, orderAmount);

				if (validCoupon == null) {
					response.setContentType("text/plain; charset=UTF-8");
					response.getWriter().write("ERROR:사용할 수 없는 쿠폰입니다.");
					return;
				}

				couponDiscount = (int) validCoupon.get("amount");
			}

			// orderData에 할인 정보 저장
			orderData.put("usingCoupon", memberCouponId);
			orderData.put("couponDiscount", couponDiscount);

			// 포인트 처리 (Integer로)
			String usingPointStr = request.getParameter("usingPoint");
			int usingPoint = 0;

			if (usingPointStr != null && !usingPointStr.trim().isEmpty()) {
				usingPoint = Integer.parseInt(usingPointStr.trim());
			}

			orderData.put("usingPoint", usingPoint);

			int discountTotal = couponDiscount + usingPoint;
			int discountFinal = 0;

			// 장바구니 상품 개수로 나누기
			if (!itemsList.isEmpty()) {
				discountFinal = discountTotal / itemsList.size();
			}

			System.out.println(
					"할인 총액: " + discountTotal + ", 상품 개수: " + itemsList.size() + ", 1개당 할인액: " + discountFinal);

			orderData.put("discountFinal", new BigDecimal(discountFinal));

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
		// 할인 정보
		String usingCouponStr = request.getParameter("usingCoupon");
		if (usingCouponStr != null && !usingCouponStr.isEmpty()) {
			orderData.put("usingCoupon", Long.parseLong(usingCouponStr));
		} else {
			orderData.put("usingCoupon", null); // 비어있으면 null
		}

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
