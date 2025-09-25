package dto;

import java.sql.Timestamp;

public class Review {
    private Long reviewId;        // 리뷰 ID (PK, AUTO_INCREMENT)
    private Long memberId;        // 회원 ID (FK → member.member_id)
    private Long orderItemId;     // 주문 상품 ID (FK → order_item.order_item_id)
    private Long productId;       // 상품 ID (FK → product.product_id)
    private Long productOptionId; // 상품 옵션 ID (FK → product_option.product_option_id)
    private Integer rating;       // 별점 (1~5, CHECK)
    private String content;       // 리뷰 내용
    private Long image1FileId;    // 업로드된 이미지 파일 ID (FK → upload_file.upload_file_id)
    private Long image2FileId;    // 업로드된 이미지 파일 ID (FK → upload_file.upload_file_id)
    private Long image3FileId;    // 업로드된 이미지 파일 ID (FK → upload_file.upload_file_id)
    private String answer;        // 리뷰 답변
    private String status;        // 공개 상태 (PUBLISHED, HIDDEN)
    private Timestamp questionedAt; // 리뷰 등록 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp answeredAt;   // 리뷰 답변 시각

    public Review() {
    }

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

    @Override
    public String toString() {
        return "Review [reviewId=" + reviewId + ", memberId=" + memberId +
                ", orderItemId=" + orderItemId + ", productId=" + productId +
                ", productOptionId=" + productOptionId + ", rating=" + rating +
                ", content=" + content + ", image1FileId=" + image1FileId +
                ", image2FileId=" + image2FileId + ", image3FileId=" + image3FileId +
                ", answer=" + answer + ", status=" + status +
                ", questionedAt=" + questionedAt + ", answeredAt=" + answeredAt + "]";
    }
}
