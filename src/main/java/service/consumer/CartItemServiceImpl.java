package service.consumer;

import java.util.List;
import java.util.Map;

import dao.consumer.CartItemDAO;
import dao.consumer.CartItemDAOImpl;
import dto.CartItem;

public class CartItemServiceImpl implements CartItemService {

	private CartItemDAO cartItemDAO;

	public CartItemServiceImpl() {
		cartItemDAO = new CartItemDAOImpl();
	}

	@Override
	public void addToCart(Long memberId, Long brandId, Long productId, Long optionId, int quantity) throws Exception {
		// 입력값 검증
		if (memberId == null) {
			throw new Exception("로그인이 필요합니다.");
		}
		if (productId == null) {
			throw new Exception("상품 정보가 필요합니다.");
		}
		if (quantity <= 0) {
			throw new Exception("수량은 1개 이상이어야 합니다.");
		}
		if (quantity > 100) {
			throw new Exception("한 번에 100개를 초과해서 담을 수 없습니다.");
		}

		// CartItem 객체 생성
		CartItem cartItem = new CartItem();
		cartItem.setMemberId(memberId);
		cartItem.setBrandId(brandId);
		cartItem.setProductId(productId);
		cartItem.setOptionId(optionId);
		cartItem.setQuantity(quantity);

		// 장바구니에 추가
		cartItemDAO.insertCartItem(cartItem);
	}

	@Override
	public List<Map<String, Object>> getCartItems(Long memberId) throws Exception {
		if (memberId == null) {
			throw new Exception("로그인이 필요합니다.");
		}

		return cartItemDAO.selectCartItemByMemberId(memberId);
	}

	@Override
	public void updateQuantity(Long cartItemId, Long memberId, int quantity) throws Exception {
		// 입력값 검증
		if (cartItemId == null) {
			throw new Exception("장바구니 상품 정보가 필요합니다.");
		}
		if (memberId == null) {
			throw new Exception("로그인이 필요합니다.");
		}
		if (quantity <= 0) {
			throw new Exception("수량은 1개 이상이어야 합니다.");
		}
		if (quantity > 100) {
			throw new Exception("수량은 100개를 초과할 수 없습니다.");
		}

		cartItemDAO.updateCartItemQuantity(cartItemId, memberId, quantity);
	}

	@Override
	public void removeFromCart(Long cartItemId, Long memberId) throws Exception {
		if (cartItemId == null) {
			throw new Exception("장바구니 상품 정보가 필요합니다.");
		}
		if (memberId == null) {
			throw new Exception("로그인이 필요합니다.");
		}

		cartItemDAO.deleteCartItemById(cartItemId, memberId);
	}

	@Override
	public int getCartItemCount(Long memberId) throws Exception {
		if (memberId == null) {
			return 0; // 로그인하지 않은 경우 0 반환
		}
		return cartItemDAO.countCartItemByMemberId(memberId);
	}

	@Override
	public List<Map<String, Object>> getSelectedItemsForCheckout(Long memberId, List<Long> cartItemIds) throws Exception {
	// 입력값 검증
    if (memberId == null) {
        throw new Exception("로그인이 필요합니다.");
    }
    if (cartItemIds == null || cartItemIds.isEmpty()) {
        throw new Exception("주문할 상품을 선택해주세요.");
    }
    if (cartItemIds.size() > 50) {
        throw new Exception("한 번에 주문할 수 있는 상품은 최대 50개입니다.");
    }
    
    // 선택된 상품들 조회
    List<Map<String, Object>> selectedItems = cartItemDAO.selectCartItemsByIds(memberId, cartItemIds);
    
    if (selectedItems.isEmpty()) {
        throw new Exception("선택하신 상품을 찾을 수 없습니다.");
    }
    
   /* // 재고 및 주문 가능 여부 검증
    validateItemsForCheckout(selectedItems);*/
    
    return selectedItems;
	}

	/**
	 * 주문 진행 전 상품들의 유효성 검증
	 */
	private void validateItemsForCheckout(List<Map<String, Object>> items) throws Exception {
		for (Map<String, Object> item : items) {
			String productName = (String) item.get("productName");
			Integer quantity = (Integer) item.get("quantity");

			// 기본 검증
			if (quantity == null || quantity <= 0) {
				throw new Exception(productName + "의 수량이 올바르지 않습니다.");
			}

			// 추가 검증 로직이 필요하면 여기에 추가
			// 예: 재고 확인, 판매 중단 상품 확인 등
		}
	}

}
