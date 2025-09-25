package dto;

import java.sql.Timestamp;

public class CodeDetail {
    private Long codeDetailId;   // 고유 식별자 (PK, AUTO_INCREMENT)
    private Long codeMasterId;   // code_master ID (FK → code_master.code_master_id)
    private String code;         // 코드 값
    private String name;         // 한글 코드 이름 (view 용)
    private Integer isActive;    // 코드 활성 여부 (tinyint, DEFAULT 1)
    private Timestamp createdAt; // 생성 시각 (DEFAULT CURRENT_TIMESTAMP)

    public CodeDetail() {
    }

    public Long getCodeDetailId() {
        return codeDetailId;
    }
    public void setCodeDetailId(Long codeDetailId) {
        this.codeDetailId = codeDetailId;
    }

    public Long getCodeMasterId() {
        return codeMasterId;
    }
    public void setCodeMasterId(Long codeMasterId) {
        this.codeMasterId = codeMasterId;
    }

    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public Integer getIsActive() {
        return isActive;
    }
    public void setIsActive(Integer isActive) {
        this.isActive = isActive;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "CodeDetail [codeDetailId=" + codeDetailId +
                ", codeMasterId=" + codeMasterId +
                ", code=" + code + ", name=" + name +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt + "]";
    }
}
