package service.consumer;

import java.math.BigDecimal;
import java.util.Map;

public interface OrderService {
	
	 /**
     * 체크아웃 페이지용 상품 정보 조회 - 상품 상세페이지에서 바로 주문할 때 사용
     * @param productId 상품 ID, optionId 옵션 ID (옵션이 없으면 null)
     * @return 상품 정보와 계산된 가격 정보
     */
    Map<String, Object> getProductInfoForCheckout(Long productId, Long optionId) throws Exception;
    
    /**
     * 주문 금액 계산 - 할인 적용된 최종 가격 계산
     * @param originalPrice 원래 가격, quantity 수량, discountType 할인 타입 (RATE/AMOUNT)
     * discountValue 할인 값, startDate 할인 시작일, 할인 종료일
     * @return 계산된 가격 정보 (원가, 할인가, 최종가)
     */
    Map<String, BigDecimal> calculatePrice(BigDecimal originalPrice, int quantity, 
                                          String discountType, BigDecimal discountValue,
                                          java.util.Date startDate, java.util.Date endDate) throws Exception;
    
    /**
     * 배송비 계산
     * @param totalAmount 총 상품 금액
     * @return 배송비
     */
    BigDecimal calculateShippingFee(BigDecimal totalAmount) throws Exception;
    
    /**
     * 주문 생성 처리 - 주문 정보와 주문 상품을 함께 생성
     * @param orderData 주문 생성에 필요한 모든 데이터
     * @return 생성된 주문 ID
     */
    Long createOrder(Map<String, Object> orderData) throws Exception;
    
    /**
     * 주문 완료 정보 조회 - 주문 완료 페이지에서 보여줄 정보
     * @param orderId 주문 ID
     * @return 주문 정보 + 주문 상품 목록
     */
    Map<String, Object> getOrderCompleteInfo(Long orderId) throws Exception;
    
    
    //여러 옵션 체크아웃 데이터 준비하기
    Map<String, Object> prepareCheckoutDataForMultipleOptions(
        Long memberId, 
        Long productId, 
        String[] optionIds, 
        String[] quantities
    ) throws Exception;
    
    // =================== Member 관련 메서드
    /**
     * 체크아웃 페이지 초기 데이터 준비
     * - 회원 정보 + 상품 정보 + 계산된 가격
     * @param memberId 회원 ID  
     * @param productId 상품 ID
     * @param optionId 옵션 ID (옵션이 없으면 null)
     * @param quantity 수량
     * @return 체크아웃 페이지에 필요한 모든 데이터
     */
    Map<String, Object> prepareCheckoutData(Long memberId, Long productId, Long optionId, int quantity) throws Exception;
    
    /**
     * 포인트 사용 가능 여부 확인
     * - 주문 전 포인트 잔액 확인
     * @param memberId 회원 ID
     * @param usingPoint 사용하려는 포인트
     * @return true: 사용 가능, false: 잔액 부족
     */
    boolean checkPointAvailable(Long memberId, int usingPoint) throws Exception;
    
}
