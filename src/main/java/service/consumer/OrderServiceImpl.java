package service.consumer;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.BrandDAO;
import dao.consumer.BrandDAOImpl;
import dao.consumer.MemberCouponDAO;
import dao.consumer.MemberCouponDAOImpl;
import dao.consumer.MemberDAO;
import dao.consumer.MemberDAOImpl;
import dao.consumer.OrderDAO;
import dao.consumer.OrderDAOImpl;
import dao.consumer.ProductDAO;
import dao.consumer.ProductDAOImpl;
import dao.consumer.ProductOptionDAO;
import dao.consumer.ProductOptionDAOImpl;
import dto.Brand;
import dto.Member;
import dto.OrderItem;
import dto.Orders;
import dto.Product;
import dto.ProductOption;

public class OrderServiceImpl implements OrderService {

	private OrderDAO orderDAO;
	private MemberDAO memberDAO;
	private MemberCouponDAO memberCouponDAO; // 사용한 쿠폰 조회용

	public OrderServiceImpl() {
		orderDAO = new OrderDAOImpl();
		memberDAO = new MemberDAOImpl();
		memberCouponDAO = new MemberCouponDAOImpl();
	}

	// 체크아웃 페이지용 상품 정보 조회
	// 상품 기본 정보 + 옵션 정보 + 계산된 가격
	@Override
	public Map<String, Object> getProductInfoForCheckout(Long productId, Long optionId) throws Exception {
		Map<String, Object> result = new HashMap<>();

		// 1. 상품 기본 정보 조회
		Map<String, Object> productInfo = orderDAO.getProductForDirectOrder(productId);
		if (productInfo == null) {
			throw new Exception("상품 정보를 찾을 수 없습니다.");
		}

		result.put("productInfo", productInfo);

		// 2. 옵션 정보 조회 (옵션이 있는 경우)
		if (optionId != null) {
			Map<String, Object> optionInfo = orderDAO.getProductOptionInfo(optionId);
			if (optionInfo == null) {
				throw new Exception("옵션 정보를 찾을 수 없습니다.");
			}
			result.put("optionInfo", optionInfo);
		}

		return result;
	}

	// 주문 금액 계산 - 할인 적용된 최종 가격 계산
	@Override
	public Map<String, BigDecimal> calculatePrice(BigDecimal originalPrice, int quantity, String discountType,
			BigDecimal discountValue, Date startDate, Date endDate) throws Exception {
		Map<String, BigDecimal> priceInfo = new HashMap<>();

		// 1. 기본 계산
		BigDecimal subtotal = originalPrice.multiply(new BigDecimal(quantity));
		priceInfo.put("originalPrice", originalPrice);
		priceInfo.put("quantity", new BigDecimal(quantity));
		priceInfo.put("subtotal", subtotal);

		// 2. 할인 적용 여부 확인
		BigDecimal salePrice = originalPrice;
		BigDecimal discountAmount = BigDecimal.ZERO;

		if (isDiscountActive(startDate, endDate) && discountValue != null
				&& discountValue.compareTo(BigDecimal.ZERO) > 0) {
			if ("RATE".equals(discountType)) {
				// 정율 할인 (퍼센트)
				discountAmount = originalPrice.multiply(discountValue).divide(new BigDecimal("100"));
				salePrice = originalPrice.subtract(discountAmount);
			} else if ("AMOUNT".equals(discountType)) {
				// 정액 할인 (금액)
				discountAmount = discountValue;
				salePrice = originalPrice.subtract(discountAmount);
			}
		}

		// 3. 최종 금액 계산
		BigDecimal finalSubtotal = salePrice.multiply(new BigDecimal(quantity));

		priceInfo.put("salePrice", salePrice);
		priceInfo.put("discountAmount", discountAmount);
		priceInfo.put("finalSubtotal", finalSubtotal);

		return priceInfo;
	}

	/**
	 * 할인 기간 확인 - 현재 시간이 할인 기간 내인지 확인
	 */
	private boolean isDiscountActive(Date startDate, Date endDate) {
		if (startDate == null || endDate == null) {
			return false;
		}

		Date now = new Date();
		return now.compareTo(startDate) >= 0 && now.compareTo(endDate) <= 0;
	}

	@Override
	public BigDecimal calculateShippingFee(BigDecimal totalAmount) throws Exception {
		return new BigDecimal("2500");
	}

	// 향후 무료배송 기능 추가 시 사용 예정
	// 기본 배송비 (항상 2,500원)
	// private static final BigDecimal DEFAULT_SHIPPING_FEE = new
	// BigDecimal("2500");
	// 5만원 이상시 무료배송
	// private static final BigDecimal FREE_SHIPPING_THRESHOLD = new
	// BigDecimal("50000");

	// 향후 무료배송 기능 추가 시 사용 예정
	// if (totalAmount.compareTo(FREE_SHIPPING_THRESHOLD) >= 0) {
	// return BigDecimal.ZERO; // 무료배송
	// } else {
	// return DEFAULT_SHIPPING_FEE; // 기본 배송비
	// }

	@Override
	public Long createOrder(Map<String, Object> orderData) throws Exception {
		// 1. 주문 코드 생성
		String orderCode = orderDAO.generateOrderCode();
		if (orderCode == null) {
			throw new Exception("주문 코드 생성에 실패했습니다.");
		}

		// 2. Orders 객체 생성
		Orders order = new Orders();
		order.setOrderCode(orderCode);
		order.setMemberId((Long) orderData.get("memberId"));
		order.setPhone((String) orderData.get("phone"));
		order.setSubtotalAmount((BigDecimal) orderData.get("subtotalAmount"));
		order.setDiscountAmount((BigDecimal) orderData.get("discountAmount"));
		order.setShippingAmount((BigDecimal) orderData.get("shippingAmount"));
		order.setTotalAmount((BigDecimal) orderData.get("totalAmount"));
		order.setShipRecipient((String) orderData.get("shipRecipient"));
		order.setShipPhone((String) orderData.get("shipPhone"));
		order.setShipPostcode((String) orderData.get("shipPostcode"));
		order.setShipLine1((String) orderData.get("shipLine1"));
		order.setShipLine2((String) orderData.get("shipLine2"));
		order.setNote((String) orderData.get("note"));
		order.setUsingCoupon((Long) orderData.get("usingCoupon"));
		order.setUsingPoint((Integer) orderData.get("usingPoint"));

		// 3. 주문 생성
		orderDAO.createOrder(order);

		// 4. 생성된 주문 ID 확인
		Long orderId = order.getOrdersId();
		if (orderId == null) {
			throw new Exception("주문 ID를 가져올 수 없습니다.");
		}

		// 5. 주문 상품 생성
		OrderItem orderItem = new OrderItem();
		orderItem.setOrderId(orderId);
		orderItem.setBrandId((Long) orderData.get("brandId"));
		orderItem.setProductId((Long) orderData.get("productId"));
		orderItem.setOptionId((Long) orderData.get("optionId"));
		orderItem.setUnitPrice((BigDecimal) orderData.get("unitPrice"));
		orderItem.setQuantity((Integer) orderData.get("quantity"));
		orderItem.setLineSubtotal((BigDecimal) orderData.get("lineSubtotal"));
		orderItem.setDiscount((BigDecimal) orderData.get("itemDiscount"));
		orderItem.setTotal((BigDecimal) orderData.get("itemTotal"));
		orderItem.setStatus("PAID");

		orderDAO.createOrderItem(orderItem);

		return orderId;
	}

	// 주문 완료 정보 조회 - 주문 완료 페이지에서 보여줄 정보
	@Override
	public Map<String, Object> getOrderCompleteInfo(Long orderId) throws Exception {
		Map<String, Object> result = new HashMap<>();

		// 1. 주문 기본 정보 조회
		Orders order = orderDAO.getOrderById(orderId);
		if (order == null) {
			throw new Exception("주문 정보를 찾을 수 없습니다.");
		}
		result.put("order", order);

		// 2. 주문 상품 상세 정보 조회 (상품명, 브랜드명, 옵션명 포함)
		List<Map<String, Object>> orderItems = orderDAO.getOrderItemsWithProductInfo(orderId);
		result.put("orderItems", orderItems);

		return result;
	}

	// 체크아웃 페이지 초기 데이터 준비: 회원 정보 + 상품 정보 + 계산된 가격을 모두 준비
	@Override
	public Map<String, Object> prepareCheckoutData(Long memberId, Long productId, Long optionId, int quantity)
			throws Exception {
		Map<String, Object> checkoutData = new HashMap<>();

		// 1. 회원 정보 조회 (체크아웃 폼 자동 입력용)
		Member member = memberDAO.getMemberInfoForCheckout(memberId);
		if (member == null) {
			throw new Exception("회원 정보를 찾을 수 없습니다.");
		}
		checkoutData.put("member", member);

		// 2. 상품 정보 조회
		Map<String, Object> productData = getProductInfoForCheckout(productId, optionId);
		checkoutData.put("productData", productData);

		// 3. 수량 정보
		checkoutData.put("quantity", quantity);

		// 4. 배송비 계산
		BigDecimal shippingFee = calculateShippingFee(BigDecimal.ZERO); // 현재는 무조건 2500원
		checkoutData.put("shippingFee", shippingFee);

		return checkoutData;
	}

	// 포인트 사용 가능 여부 확인 - 주문 전 포인트 잔액 확인
	@Override
	public boolean checkPointAvailable(Long memberId, int usingPoint) throws Exception {
		return memberDAO.checkPointAvailable(memberId, usingPoint);
	}

	@Override
	public Map<String, Object> prepareCheckoutDataForMultipleOptions(Long memberId, Long productId, String[] optionIds,
			String[] quantities) throws Exception {
		Map<String, Object> checkoutData = new HashMap<>();

		// 1. 회원 정보 조회
		MemberDAO memberDAO = new MemberDAOImpl();
		Member member = memberDAO.selectById(memberId);

		if (member == null) {
			throw new Exception("회원 정보를 찾을 수 없습니다.");
		}

		// 2. 상품 정보 조회
		ProductDAO productDAO = new ProductDAOImpl();
		Product product = productDAO.selectProductByProductId(productId);

		if (product == null) {
			throw new Exception("상품 정보를 찾을 수 없습니다.");
		}

		// 3. 브랜드 정보 조회
		BrandDAO brandDAO = new BrandDAOImpl();
		Brand brand = brandDAO.selectBrandByBrandId(product.getBrandId());

		// 4. 여러 옵션 정보 조회 및 총액 계산
		ProductOptionDAO optionDAO = new ProductOptionDAOImpl();
		List<Map<String, Object>> itemList = new ArrayList<>();
		BigDecimal totalAmount = BigDecimal.ZERO;

		for (int i = 0; i < optionIds.length; i++) {
			Long optionId = Long.parseLong(optionIds[i]);
			int quantity = Integer.parseInt(quantities[i]);

			ProductOption option = optionDAO.selectProductOptionByOptionId(optionId);

			if (option == null) {
				throw new Exception("옵션 정보를 찾을 수 없습니다.");
			}

			// 재고 확인
			if (option.getStockQty() < quantity) {
				throw new Exception(option.getOptionValue() + " 옵션의 재고가 부족합니다.");
			}

			// 개별 아이템 정보
			Map<String, Object> item = new HashMap<>();
			item.put("optionId", optionId);
			item.put("optionValue", option.getOptionValue());
			item.put("quantity", quantity);
			item.put("unitPrice", option.getPrice());

			BigDecimal itemTotal = option.getPrice().multiply(new BigDecimal(quantity));
			item.put("itemTotal", itemTotal);

			itemList.add(item);
			totalAmount = totalAmount.add(itemTotal);
		}

		// 5. 배송비 계산 (50,000원 이상 무료로 고정!!!!!)
		BigDecimal shippingFee = totalAmount.compareTo(new BigDecimal("50000")) >= 0 ? BigDecimal.ZERO
				: new BigDecimal("2500");

		// 6. 최종 금액
		BigDecimal finalAmount = totalAmount.add(shippingFee);

		// 7. checkoutData에 정보 담기
		checkoutData.put("member", member);
		checkoutData.put("product", product);
		checkoutData.put("brand", brand);
		checkoutData.put("items", itemList); // 여러 아이템 리스트
		checkoutData.put("subtotalAmount", totalAmount);
		checkoutData.put("shippingFee", shippingFee);
		checkoutData.put("totalAmount", finalAmount);
		checkoutData.put("availablePoint", member.getPointBalance() != null ? member.getPointBalance() : 0);

		return checkoutData;
	}

	// ==================== orderList용=====================

	// 주문 목록 조회
	@Override
	public Map<String, Object> getOrderListByMember(Long memberId, Integer months, String startDate, String endDate,
			int page, int pageSize) throws Exception {

		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);

		// 1. 날짜 범위 설정
		if (months != null && months > 0) {
			// 개월 수로 필터링
			Calendar cal = Calendar.getInstance();
			Date endDateCalc = cal.getTime();
			cal.add(Calendar.MONTH, -months);
			Date startDateCalc = cal.getTime();

			params.put("startDate", new java.sql.Timestamp(startDateCalc.getTime()));
			params.put("endDate", new java.sql.Timestamp(endDateCalc.getTime()));
		} else if (startDate != null && endDate != null) {
			// 직접 날짜 지정
			params.put("startDate", startDate);
			params.put("endDate", endDate);
		}

		// 2. 페이징 설정
		int offset = (page - 1) * pageSize;
		params.put("limit", pageSize);
		params.put("offset", offset);

		// 3. 데이터 조회
		List<Map<String, Object>> orderItems = orderDAO.getOrderItemsByMemberWithPeriod(params);
		int totalCount = orderDAO.getOrderItemCountByMember(params);

		// 4. 페이징 정보 계산
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		// 5. 주문번호별로 그룹핑<<<<<<
		List<Map<String, Object>> groupedOrders = groupOrdersByOrderCode(orderItems);

		// 6. 결과 반환
		Map<String, Object> result = new HashMap<>();
		result.put("groupedOrders", groupedOrders); // 그룹핑된 데이터로 변경
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);
		result.put("currentPage", page);
		result.put("pageSize", pageSize);

		return result;
	}

	// ===========그룹핑 처리 메서드==========
	private List<Map<String, Object>> groupOrdersByOrderCode(List<Map<String, Object>> orderItems) {
		List<Map<String, Object>> groupedOrders = new ArrayList<>();
		Map<String, Object> currentOrder = null;
		String currentOrderCode = null;

		for (Map<String, Object> item : orderItems) {
			String orderCode = (String) item.get("orderCode");

			// 새로운 주문번호인 경우
			if (!orderCode.equals(currentOrderCode)) {
				// 이전 주문이 있으면 리스트에 추가
				if (currentOrder != null) {
					groupedOrders.add(currentOrder);
				}

				// 새로운 주문 그룹 생성
				currentOrder = new HashMap<>();
				currentOrder.put("orderCode", orderCode);
				currentOrder.put("orderDate", item.get("orderDate"));
				currentOrder.put("ordersId", item.get("ordersId"));
				currentOrder.put("items", new ArrayList<Map<String, Object>>());
				currentOrderCode = orderCode;
			}

			// 현재 주문에 아이템 추가
			@SuppressWarnings("unchecked")
			List<Map<String, Object>> items = (List<Map<String, Object>>) currentOrder.get("items");
			items.add(item);
		}

		// 마지막 주문 추가
		if (currentOrder != null) {
			groupedOrders.add(currentOrder);
		}

		return groupedOrders;
	}

	// 주문 요약 조회
	@Override
	public Map<String, Object> getOrderSummaryByMember(Long memberId) throws Exception {
		Map<String, Object> statusCounts = orderDAO.getOrderStatusCountByMember(memberId);

		Map<String, Object> result = new HashMap<>();
		result.put("orderCount", statusCounts.get("orderCount")); // 전체 주문 건수
		result.put("paymentCount", statusCounts.get("paymentCount")); // 결제완료 (PAID)
		result.put("shippingCount", statusCounts.get("shippingCount")); // 배송준비중 (PREPARING)
		result.put("deliveredCount", statusCounts.get("deliveredCount")); // 배송중 (SHIPPING)
		result.put("confirmedCount", statusCounts.get("confirmedCount")); // 배송완료 (DELIVERED)

		return result;
	}

	// OrderDetail 용도=========================================
	@Override
	public Map<String, Object> getOrderDetailInfo(Long orderId) throws Exception {
		Map<String, Object> result = new HashMap<>();

		// 1. 주문 기본 정보 조회
		Orders order = orderDAO.getOrderById(orderId);
		if (order == null) {
			throw new Exception("주문 정보를 찾을 수 없습니다.");
		}
		result.put("order", order);

		// 2. 주문 상품 상세 정보 조회
		List<Map<String, Object>> orderItems = orderDAO.getOrderItemsWithProductInfo(orderId);
		result.put("orderItems", orderItems);

		// 3. 결제 정보 요약 계산
		BigDecimal itemsTotalAmount = BigDecimal.ZERO;
		for (Map<String, Object> item : orderItems) {
			BigDecimal itemTotal = (BigDecimal) item.get("total");
			if (itemTotal != null) {
				itemsTotalAmount = itemsTotalAmount.add(itemTotal);
			}
		}

		// 4. 쿠폰 정보 조회 및 포맷팅
		String couponDisplayText = "0원";
		if (order.getUsingCoupon() != null) {
			Map<String, Object> coupon = memberCouponDAO.getCouponInfoByMemberCouponId(order.getUsingCoupon());
			if (coupon != null) {
				Integer amount = (Integer) coupon.get("amount");
				if (amount != null) {
					couponDisplayText = String.format("%,d원", amount);
				}
			}
		}

		// 5. 결제 정보 포맷팅
		Map<String, Object> paymentInfo = new HashMap<>();
		paymentInfo.put("subtotalAmountText", String.format("%,d원", order.getSubtotalAmount().intValue()));
		paymentInfo.put("discountAmountText", String.format("%,d원", order.getDiscountAmount().intValue()));
		paymentInfo.put("shippingAmountText", String.format("%,d원", order.getShippingAmount().intValue()));
		paymentInfo.put("totalAmountText", String.format("%,d원", order.getTotalAmount().intValue()));
		paymentInfo.put("usingPointText", order.getUsingPoint() + " P");
		paymentInfo.put("couponDisplayText", couponDisplayText); // 쿠폰 포맷팅 완료

		result.put("paymentInfo", paymentInfo);

		return result;
	}
	
	// ================[소비자] 취소/교환/반품 통합 목록 조회 ===================
	@Override
	public List<Map<String, Object>> getCancelExchangeReturnList(Long memberId, String startDate, String endDate)
			throws Exception {
		 if (memberId == null) {
		        throw new Exception("회원 ID가 필요합니다.");
		    }
		    
		    Map<String, Object> params = new HashMap<>();
		    params.put("memberId", memberId);
		    
		    // 날짜 필터 (선택적)
		    if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
		        params.put("startDate", startDate);
		        params.put("endDate", endDate);
		    }
		    
		    return orderDAO.selectCancelExchangeReturnList(params);
	}

}
