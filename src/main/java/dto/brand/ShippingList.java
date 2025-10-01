package dto.brand;

import java.sql.Timestamp;

public class ShippingList {
	private Long orderItemId; // 주문상품 ID (order_item_id)
	private Long orderId; // 주문 ID (order_id)
	private String orderCode; // 주문번호 (order_code)
	private String shipRecipient; // 수령인 (orders.ship_recipient)
	private String shipPhone; // 수령인 연락처 (orders.ship_phone)
	private String shipAddress; // 수령인 주소 (postcode + line1 + line2)
	private String note; // 배송 요청사항 (orders.note)
	private Timestamp orderDate; // 주문일시 (orders.created_at)
	private String trackingNo; // 송장번호 (order_item.tracking_no)
	private String carrierName; // 택배사 이름 (order_item.carrier_name)
	private String status; // 원본 상태값 (order_item.status)
	private String representProductName; // 대표상품명 (대표 1개 상품명)
	private String allProductNames; // 검색용 전체상품명 (연결된 모든 상품명)
	private String displayStatus; // 화면 표시용 상태값 (가공된 상태)

	public Long getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(Long orderItemId) {
		this.orderItemId = orderItemId;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public String getShipRecipient() {
		return shipRecipient;
	}

	public void setShipRecipient(String shipRecipient) {
		this.shipRecipient = shipRecipient;
	}

	public String getShipPhone() {
		return shipPhone;
	}

	public void setShipPhone(String shipPhone) {
		this.shipPhone = shipPhone;
	}

	public String getShipAddress() {
		return shipAddress;
	}

	public void setShipAddress(String shipAddress) {
		this.shipAddress = shipAddress;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Timestamp getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}

	public String getTrackingNo() {
		return trackingNo;
	}

	public void setTrackingNo(String trackingNo) {
		this.trackingNo = trackingNo;
	}

	public String getCarrierName() {
		return carrierName;
	}

	public void setCarrierName(String carrierName) {
		this.carrierName = carrierName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRepresentProductName() {
		return representProductName;
	}

	public void setRepresentProductName(String representProductName) {
		this.representProductName = representProductName;
	}

	public String getAllProductNames() {
		return allProductNames;
	}

	public void setAllProductNames(String allProductNames) {
		this.allProductNames = allProductNames;
	}

	public String getDisplayStatus() {
		return displayStatus;
	}

	public void setDisplayStatus(String displayStatus) {
		this.displayStatus = displayStatus;
	}

}
