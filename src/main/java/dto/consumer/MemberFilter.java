package dto.consumer;

import java.util.List;

public class MemberFilter {
	private Long memberId;

	// 피부 타입
	private Long skinTypeId;

	// 퍼스널 컬러
	private Long personalColorId;

	// 피부 고민 (다중 선택 가능)
	private List<Long> skinIssueIds;

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
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

	public List<Long> getSkinIssueIds() {
		return skinIssueIds;
	}

	public void setSkinIssueIds(List<Long> skinIssueIds) {
		this.skinIssueIds = skinIssueIds;
	}

}
