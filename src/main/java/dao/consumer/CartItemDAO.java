package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.CartItem;

public interface CartItemDAO {
	 /**
     * 장바구니에 상품 추가
     * @param cartItem 추가할 장바구니 아이템 정보
     */
    void insertCartItem(CartItem cartItem) throws Exception;
    
    
    /**
     * 특정 회원의 장바구니 조회 (상품 정보 포함)
     * @param memberId 회원 ID
     * @return 장바구니 아이템 목록 (상품명, 가격, 브랜드 등 포함)
     */
    List<Map<String, Object>> selectCartItemByMemberId(Long memberId) throws Exception;
    
    
    /**
     * 장바구니 상품 수량 변경
     * @param cartItemId 장바구니 아이템 ID
     * @param memberId 회원 ID (보안을 위한 검증용)
     * @param quantity 변경할 수량
     */
    void updateCartItemQuantity(Long cartItemId, Long memberId, int quantity) throws Exception;
    
    
    /**
     * 장바구니 특정 상품 삭제
     * @param cartItemId 장바구니 아이템 ID
     * @param memberId 회원 ID (보안을 위한 검증용)
     */
    void deleteCartItemById(Long cartItemId, Long memberId) throws Exception;
    
    
    /**
     * 장바구니 상품 개수 조회 (헤더용)
     * @param memberId 회원 ID
     * @return 장바구니에 담긴 상품 개수
     */
    int countCartItemByMemberId(Long memberId) throws Exception;
    
    
    /**
     * 선택된 장바구니 상품들 조회 (checkout으로 넘어갈 때)
     * @param memberId 회원 ID
     * @param cartItemIds 선택된 장바구니 아이템 ID 목록
     * @return 선택된 장바구니 아이템 목록 (상품 정보 포함)
     */
    List<Map<String, Object>> selectCartItemsByIds(Long memberId, List<Long> cartItemIds) throws Exception;
}
