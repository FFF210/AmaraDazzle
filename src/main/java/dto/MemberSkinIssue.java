package dto;

public class MemberSkinIssue {
    private Long memberSkinIssueId; // 회원 피부 고민 ID (PK, AUTO_INCREMENT)
    private Long memberId;          // 회원 ID (FK → member.member_id)
    private Long codeId;            // 피부 고민 코드 상세 ID (FK → code_detail.id)

    public MemberSkinIssue() {
    }

    public Long getMemberSkinIssueId() {
        return memberSkinIssueId;
    }
    public void setMemberSkinIssueId(Long memberSkinIssueId) {
        this.memberSkinIssueId = memberSkinIssueId;
    }

    public Long getMemberId() {
        return memberId;
    }
    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public Long getCodeId() {
        return codeId;
    }
    public void setCodeId(Long codeId) {
        this.codeId = codeId;
    }

    @Override
    public String toString() {
        return "MemberSkinIssue [memberSkinIssueId=" + memberSkinIssueId +
                ", memberId=" + memberId + ", codeId=" + codeId + "]";
    }
}
