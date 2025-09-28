package service.consumer;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.OrderDAO;
import dao.consumer.OrderDAOImpl;
import dto.Member;
import dao.consumer.MemberDAO;
import dao.consumer.MemberDAOImpl;
import dto.OrderItem;
import dto.Orders;

public class OrderServiceImpl implements OrderService {

	private OrderDAO orderDAO;
	private MemberDAO memberDAO;

	public OrderServiceImpl() {
		orderDAO = new OrderDAOImpl();
		memberDAO = new MemberDAOImpl();
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
     * 할인 기간 확인
     * - 현재 시간이 할인 기간 내인지 확인
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
    // private static final BigDecimal DEFAULT_SHIPPING_FEE = new BigDecimal("2500");
    // 3만원 이상시 무료배송
    // private static final BigDecimal FREE_SHIPPING_THRESHOLD = new BigDecimal("30000");
	
	// 향후 무료배송 기능 추가 시 사용 예정
    // if (totalAmount.compareTo(FREE_SHIPPING_THRESHOLD) >= 0) {
    //     return BigDecimal.ZERO; // 무료배송
    // } else {
    //     return DEFAULT_SHIPPING_FEE; // 기본 배송비
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
        order.setUsingCoupon((String) orderData.get("usingCoupon"));
        order.setUsingPoint((Integer) orderData.get("usingPoint"));
        
     // 3. 주문 생성
        int orderResult = orderDAO.createOrder(order);
        if (orderResult == 0) {
            throw new Exception("주문 생성에 실패했습니다.");
        }
        
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
        
        int itemResult = orderDAO.createOrderItem(orderItem);
        if (itemResult == 0) {
            throw new Exception("주문 상품 생성에 실패했습니다.");
        }
        
        return orderId;
	}
	
	//주문 완료 정보 조회 - 주문 완료 페이지에서 보여줄 정보
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
    //체크아웃 페이지 초기 데이터 준비: 회원 정보 + 상품 정보 + 계산된 가격을 모두 준비
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
	    
	    return checkoutData;
	}

	//포인트 사용 가능 여부 확인 - 주문 전 포인트 잔액 확인
	@Override
	public boolean checkPointAvailable(Long memberId, int usingPoint) throws Exception {
		   return memberDAO.checkPointAvailable(memberId, usingPoint);
	}

}
