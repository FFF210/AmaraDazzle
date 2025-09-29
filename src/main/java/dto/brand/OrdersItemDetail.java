package dto.brand;

import java.math.BigDecimal;

public class OrdersItemDetail {
	private Long orderItemId; // 주문 상품 ID (PK → order_item.order_item_id)
	private Long productId; // 상품 ID
	private Long optionId; // 옵션 ID
	private String itemStatus; // 개별 상품 상태

	private String productName; // 상품명
	private String optionName; // 옵션명

	private BigDecimal productPrice; // 최종 금액 (옵션가*수량 또는 상품가*수량)

}
