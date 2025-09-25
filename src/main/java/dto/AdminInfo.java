package dto;

import java.sql.Timestamp;

public class AdminInfo {
    private Long adminInfoId;    // 고유식별자 자동증가값 (PK)
    private String aid;          // 로그인 아이디 (UNIQUE)
    private String apassword;    // 비밀번호
    private String aname;        // 이름
    private String aphone;       // 연락처 (UNIQUE)
    private String aemail;       // 이메일 (UNIQUE)
    private Timestamp createdAt; // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)
    private Timestamp updatedAt; // 수정 시각

    public AdminInfo() {
    }

    public Long getAdminInfoId() {
        return adminInfoId;
    }
    public void setAdminInfoId(Long adminInfoId) {
        this.adminInfoId = adminInfoId;
    }

    public String getAid() {
        return aid;
    }
    public void setAid(String aid) {
        this.aid = aid;
    }

    public String getApassword() {
        return apassword;
    }
    public void setApassword(String apassword) {
        this.apassword = apassword;
    }

    public String getAname() {
        return aname;
    }
    public void setAname(String aname) {
        this.aname = aname;
    }

    public String getAphone() {
        return aphone;
    }
    public void setAphone(String aphone) {
        this.aphone = aphone;
    }

    public String getAemail() {
        return aemail;
    }
    public void setAemail(String aemail) {
        this.aemail = aemail;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "AdminInfo [adminInfoId=" + adminInfoId + ", aid=" + aid + ", apassword=" + apassword +
                ", aname=" + aname + ", aphone=" + aphone + ", aemail=" + aemail +
                ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
    }
}
