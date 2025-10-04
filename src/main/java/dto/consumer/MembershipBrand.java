package dto.consumer;

public class MembershipBrand {
	private Long membershipId;
	private Long brandId;
	private String brandName;
	private Long logoFileId;
	private Long heroFileId;
	private String intro;

	public Long getMembershipId() {
		return membershipId;
	}

	public void setMembershipId(Long membershipId) {
		this.membershipId = membershipId;
	}

	public Long getBrandId() {
		return brandId;
	}

	public void setBrandId(Long brandId) {
		this.brandId = brandId;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public Long getLogoFileId() {
		return logoFileId;
	}

	public void setLogoFileId(Long logoFileId) {
		this.logoFileId = logoFileId;
	}

	public Long getHeroFileId() {
		return heroFileId;
	}

	public void setHeroFileId(Long heroFileId) {
		this.heroFileId = heroFileId;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

}
