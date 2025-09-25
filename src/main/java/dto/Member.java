package dto;

import java.sql.Date;
import java.sql.Timestamp;

public class Member {
    private Long memberId;          // 외부 노출용 코드 아이디 (PK, AUTO_INCREMENT)
    private String email;           // 로그인 아이디 (이메일, UNIQUE)
    private String password;        // 비밀번호
    private String name;            // 이름
    private String nickname;        // 닉네임 (UNIQUE)
    private String phone;           // 휴대폰 번호 (UNIQUE)
    private String postcode;        // 우편번호
    private String line1;           // 기본주소
    private String line2;           // 상세주소
    private Date birthDate;         // 생일
    private String gender;          // 성별 (M, F)
    private Long skinTypeId;        // 피부타입 코드 상세 ID (FK → code_detail.id)
    private Long personalColorId;   // 퍼스널컬러 코드 상세 ID (FK → code_detail.id)
    private Integer marketingOpt;   // 마케팅 수신 동의 (DEFAULT 0)
    private String status;          // 계정 상태 (ACTIVE, DELETED)
    private Integer pointBalance;   // 포인트 총액 (DEFAULT 0)
    private String grade;           // 등급 (NORMAL, SILVER, GOLD, VIP)
    private String loginType;       // 로그인 방식 (EMAIL, KAKAO)
    private Long kakaoId;           // 카카오 고유 식별자 (UNIQUE)
    private Timestamp createdAt;    // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)

    public Member() {
    }

    public Long getMemberId() {
        return memberId;
    }
    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getNickname() {
        return nickname;
    }
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPostcode() {
        return postcode;
    }
    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getLine1() {
        return line1;
    }
    public void setLine1(String line1) {
        this.line1 = line1;
    }

    public String getLine2() {
        return line2;
    }
    public void setLine2(String line2) {
        this.line2 = line2;
    }

    public Date getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    public Long getSkinTypeId() {
        return skinTypeId;
    }
    public void setSkinTypeId(Long skinTypeId) {
        this.skinTypeId = skinTypeId;
    }

    public Long getPersonalColorId() {
        return personalColorId;
    }
    public void setPersonalColorId(Long personalColorId) {
        this.personalColorId = personalColorId;
    }

    public Integer getMarketingOpt() {
        return marketingOpt;
    }
    public void setMarketingOpt(Integer marketingOpt) {
        this.marketingOpt = marketingOpt;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getPointBalance() {
        return pointBalance;
    }
    public void setPointBalance(Integer pointBalance) {
        this.pointBalance = pointBalance;
    }

    public String getGrade() {
        return grade;
    }
    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getLoginType() {
        return loginType;
    }
    public void setLoginType(String loginType) {
        this.loginType = loginType;
    }

    public Long getKakaoId() {
        return kakaoId;
    }
    public void setKakaoId(Long kakaoId) {
        this.kakaoId = kakaoId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Member [memberId=" + memberId + ", email=" + email +
                ", password=" + password + ", name=" + name +
                ", nickname=" + nickname + ", phone=" + phone +
                ", postcode=" + postcode + ", line1=" + line1 +
                ", line2=" + line2 + ", birthDate=" + birthDate +
                ", gender=" + gender + ", skinTypeId=" + skinTypeId +
                ", personalColorId=" + personalColorId +
                ", marketingOpt=" + marketingOpt + ", status=" + status +
                ", pointBalance=" + pointBalance + ", grade=" + grade +
                ", loginType=" + loginType + ", kakaoId=" + kakaoId +
                ", createdAt=" + createdAt + "]";
    }
}
