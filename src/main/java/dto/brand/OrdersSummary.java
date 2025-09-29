package dto.brand;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrdersSummary {
	private Long ordersId; // 주문 ID (PK → orders.orders_id)
	private Timestamp createdAt; // 주문 생성일자
	private String orderStatus; // 주문 상태 (우선순위 적용)

	private String trackingNo; // 운송장 번호
	private String carrierName; // 택배사 이름

	private BigDecimal subtotalAmount; // 상품금액 합계(할인 전)
	private BigDecimal discountAmount; // 할인 금액
	private BigDecimal shippingAmount; // 배송비
	private BigDecimal totalAmount; // 최종 결제 금액

	private String shipRecipient; // 받는 분
	private String shipPhone; // 배송 연락처
	private String shipPostcode; // 우편번호
	private String shipLine1; // 주소
	private String shipLine2; // 상세주소
	private String note; // 배송 요청사항

	private String memberEmail; // 회원 이메일
	private String memberName; // 회원 이름
	private String memberPhone; // 회원 연락처
}
