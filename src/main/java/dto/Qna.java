package dto;

import java.sql.Timestamp;

public class Qna {
    private Long qnaId;          // 문의 ID (PK, AUTO_INCREMENT)
    private Long memberId;       // 문의한 회원 ID (FK → member.member_id)
    private Long brandId;        // 브랜드 ID (FK → brand.brand_id)
    private Long productId;      // 상품 ID (FK → product.product_id)
    private String question;     // 문의 내용
    private String answer;       // 문의 답변
    private String status;       // 답변 상태 (PENDING, ANSWERED)
    private String exposureStatus; // 공개 상태 (PUBLISHED, HIDDEN)
    private Timestamp questionedAt; // 질문 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp answeredAt;   // 답변 시각

    public Qna() {
    }

	public Long getQnaId() {
		return qnaId;
	}

	public void setQnaId(Long qnaId) {
		this.qnaId = qnaId;
	}

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public Long getBrandId() {
		return brandId;
	}

	public void setBrandId(Long brandId) {
		this.brandId = brandId;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
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

	@Override
	public String toString() {
		return "Qna [qnaId=" + qnaId + ", memberId=" + memberId + ", brandId=" + brandId + ", productId=" + productId
				+ ", question=" + question + ", answer=" + answer + ", status=" + status + ", exposureStatus="
				+ exposureStatus + ", questionedAt=" + questionedAt + ", answeredAt=" + answeredAt + "]";
	}
}
