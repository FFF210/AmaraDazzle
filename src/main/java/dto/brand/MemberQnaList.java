package dto.brand;

import java.sql.Timestamp;

public class MemberQnaList {
	private Long memberQnaId; // 문의 ID (ticket_id 또는 qna_id)

	private String category; // 문의 카테고리 (QNA는 항상 'PRODUCT', Ticket은 'ORDER', 주문 'CANCEL', 취소 'REFUND', 환불
								// 'EXCHANGE', 교환 'DELIVERY', 배송)
	private String productName; // 상품명 (QNA 전용, Ticket은 null)
	private Long image1FileId; // 첨부 이미지 파일 ID 1
	private Long image2FileId; // 첨부 이미지 파일 ID 2
	private Long image3FileId; // 첨부 이미지 파일 ID 3
	private Long productThumbnail;// 상품 썸네일 (QNA 전용, Ticket은 null)
	private Long orderId; // 주문번호 (Ticket 전용, QNA는 null)

	private String senderName; // 작성자 이름 (QNA는 memberName, Ticket은 consumerName)
	private Long senderId; // 작성자 ID (QNA는 memberId, Ticket은 senderId)

	private String question; // 문의 내용
	private String answer; // 답변 내용
	private String status; // 답변 상태 (ANSWERED / PENDING)
	private String exposureStatus;// 노출 상태 (PUBLISHED / HIDDEN)

	private Timestamp questionedAt; // 작성 시각
	private Timestamp answeredAt; // 답변 시각

	private String type; // QNA or TICKET

	public Long getMemberQnaId() {
		return memberQnaId;
	}

	public void setMemberQnaId(Long memberQnaId) {
		this.memberQnaId = memberQnaId;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Long getImage1FileId() {
		return image1FileId;
	}

	public void setImage1FileId(Long image1FileId) {
		this.image1FileId = image1FileId;
	}

	public Long getImage2FileId() {
		return image2FileId;
	}

	public void setImage2FileId(Long image2FileId) {
		this.image2FileId = image2FileId;
	}

	public Long getImage3FileId() {
		return image3FileId;
	}

	public void setImage3FileId(Long image3FileId) {
		this.image3FileId = image3FileId;
	}

	public Long getProductThumbnail() {
		return productThumbnail;
	}

	public void setProductThumbnail(Long productThumbnail) {
		this.productThumbnail = productThumbnail;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public Long getSenderId() {
		return senderId;
	}

	public void setSenderId(Long senderId) {
		this.senderId = senderId;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getExposureStatus() {
		return exposureStatus;
	}

	public void setExposureStatus(String exposureStatus) {
		this.exposureStatus = exposureStatus;
	}

	public Timestamp getQuestionedAt() {
		return questionedAt;
	}

	public void setQuestionedAt(Timestamp questionedAt) {
		this.questionedAt = questionedAt;
	}

	public Timestamp getAnsweredAt() {
		return answeredAt;
	}

	public void setAnsweredAt(Timestamp answeredAt) {
		this.answeredAt = answeredAt;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
