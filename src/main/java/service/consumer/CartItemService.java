package service.consumer;

import java.util.List;
import java.util.Map;

public interface CartItemService {

	/**
	 * 장바구니에 상품 추가
	 * 
	 * @param memberId  회원 ID @param brandId   브랜드 ID
	 * @param productId 상품 ID @param optionId  옵션 ID (없으면 null) @param quantity  수량
	 */
	void addToCart(Long memberId, Long brandId, Long productId, Long optionId, int quantity) throws Exception;

	
	/**
	 * 회원의 장바구니 목록 조회
	 * 
	 * @param memberId 회원 ID @return 장바구니 아이템 목록 (상품 정보 포함)
	 */
	List<Map<String, Object>> getCartItems(Long memberId) throws Exception;

	
	/**
	 * 장바구니 상품 수량 변경
	 * 
	 * @param cartItemId 장바구니 아이템 ID
	 * @param memberId   회원 ID @param quantity   변경할 수량
	 */
	void updateQuantity(Long cartItemId, Long memberId, int quantity) throws Exception;

	
	/**
	 * 장바구니에서 상품 삭제
	 * 
	 * @param cartItemId 장바구니 아이템 ID @param memberId   회원 ID
	 */
	void removeFromCart(Long cartItemId, Long memberId) throws Exception;

	
	/**
	 * 장바구니 상품 개수 조회 (헤더용)
	 * 
	 * @param memberId 회원 ID @return 장바구니에 담긴 상품 개수
	 */
	int getCartItemCount(Long memberId) throws Exception;

	
	/**
	 * 선택된 상품들로 주문 진행 (checkout 페이지용)
	 * 
	 * @param memberId    회원 ID
	 * @param cartItemIds 선택된 장바구니 아이템 ID 목록 @return 주문할 상품들의 정보
	 */
	List<Map<String, Object>> getSelectedItemsForCheckout(Long memberId, List<Long> cartItemIds) throws Exception;
}
