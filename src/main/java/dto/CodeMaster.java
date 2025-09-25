package dto;

public class CodeMaster {
    private Long codeMasterId; // 고유 식별자 (PK, AUTO_INCREMENT)
    private String codeGroup;  // 코드 그룹명 (UNIQUE)
    private String name;       // 한글 코드 그룹명 (view 용)

    public CodeMaster() {
    }

    public Long getCodeMasterId() {
        return codeMasterId;
    }
    public void setCodeMasterId(Long codeMasterId) {
        this.codeMasterId = codeMasterId;
    }

    public String getCodeGroup() {
        return codeGroup;
    }
    public void setCodeGroup(String codeGroup) {
        this.codeGroup = codeGroup;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "CodeMaster [codeMasterId=" + codeMasterId +
                ", codeGroup=" + codeGroup + ", name=" + name + "]";
    }
}
