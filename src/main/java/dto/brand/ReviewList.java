package dto.brand;

import java.sql.Timestamp;

public class ReviewList {
	private Long reviewId; // 리뷰 ID
	private Long memberId; // 회원 ID
	private Long orderItemId; // 주문 상품 ID
	private Long productId; // 상품 ID
	private Long productOptionId; // 상품 옵션 ID
	private Integer rating; // 별점 (1~5)
	private String content; // 리뷰 내용
	private Long image1FileId; // 업로드 이미지1 파일 ID
	private Long image2FileId; // 업로드 이미지2 파일 ID
	private Long image3FileId; // 업로드 이미지3 파일 ID
	private String answer; // 리뷰 답변
	private String status; // 공개 상태 (PUBLISHED/HIDDEN)
	private Timestamp questionedAt; // 리뷰 등록 시각
	private Timestamp answeredAt; // 리뷰 답변 시각

	private String optionName; // 옵션명 (product_option.option_value)
	private Long thumbnailFileId; // 상품 썸네일 파일 ID
	private String productName; // 상품명 (product.name)
	private String memberName; // 작성자명 (member.name)
	private String answerStatus; // 답변 상태 (ANSWERED / PENDING)

	public Long getReviewId() {
		return reviewId;
	}

	public void setReviewId(Long reviewId) {
		this.reviewId = reviewId;
	}

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public Long getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(Long orderItemId) {
		this.orderItemId = orderItemId;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Long getProductOptionId() {
		return productOptionId;
	}

	public void setProductOptionId(Long productOptionId) {
		this.productOptionId = productOptionId;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}

	public Long getThumbnailFileId() {
		return thumbnailFileId;
	}

	public void setThumbnailFileId(Long thumbnailFileId) {
		this.thumbnailFileId = thumbnailFileId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getAnswerStatus() {
		return answerStatus;
	}

	public void setAnswerStatus(String answerStatus) {
		this.answerStatus = answerStatus;
	}
}
