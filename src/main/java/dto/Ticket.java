package dto;

import java.sql.Timestamp;

public class Ticket {
    private Long ticketId;         // 문의 아이디 (PK, AUTO_INCREMENT)
    private String senderType;     // 문의 작성자 타입 (CONSUMER, BRAND_ADMIN)
    private Long senderId;         // 문의 작성자 ID
    private Long orderId;          // 주문번호 (FK → orders.order_id)
    private String recieverType;   // 답변 주체 타입 (ADMIN, BRAND_ADMIN)
    private Long recieverId;       // 답변 주체 ID (FK → brand.brand_id)
    private String category;       // 문의 카테고리 (PRODUCT, ORDER, CANCEL, ...)
    private String question;       // 문의 내용
    private Long image1FileId;     // 업로드된 이미지 파일 ID
    private Long image2FileId;     // 업로드된 이미지 파일 ID
    private Long image3FileId;     // 업로드된 이미지 파일 ID
    private String answer;         // 답변 내용
    private String exposureStatus; // 공개 상태 (PUBLISHED, HIDDEN)
    private Timestamp questionedAt;// 문의 작성 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp answeredAt;  // 답변 시각

    public Ticket() {
    }

    public Long getTicketId() {
        return ticketId;
    }
    public void setTicketId(Long ticketId) {
        this.ticketId = ticketId;
    }

    public String getSenderType() {
        return senderType;
    }
    public void setSenderType(String senderType) {
        this.senderType = senderType;
    }

    public Long getSenderId() {
        return senderId;
    }
    public void setSenderId(Long senderId) {
        this.senderId = senderId;
    }

    public Long getOrderId() {
        return orderId;
    }
    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getRecieverType() {
        return recieverType;
    }
    public void setRecieverType(String recieverType) {
        this.recieverType = recieverType;
    }

    public Long getRecieverId() {
        return recieverId;
    }
    public void setRecieverId(Long recieverId) {
        this.recieverId = recieverId;
    }

    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }

    public String getQuestion() {
        return question;
    }
    public void setQuestion(String question) {
        this.question = question;
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
        return "Ticket [ticketId=" + ticketId + ", senderType=" + senderType +
                ", senderId=" + senderId + ", orderId=" + orderId +
                ", recieverType=" + recieverType + ", recieverId=" + recieverId +
                ", category=" + category + ", question=" + question +
                ", image1FileId=" + image1FileId + ", image2FileId=" + image2FileId +
                ", image3FileId=" + image3FileId + ", answer=" + answer +
                ", exposureStatus=" + exposureStatus +
                ", questionedAt=" + questionedAt + ", answeredAt=" + answeredAt + "]";
    }
}
