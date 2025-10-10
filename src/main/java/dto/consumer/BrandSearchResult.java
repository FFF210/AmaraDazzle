package dto.consumer;

public class BrandSearchResult {
	private Long brandId;
	private String brandName;
	private Long logoFileId;
	private Integer isFollowed; // 1 → true, 0 → false

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

	public Integer getIsFollowed() {
		return isFollowed;
	}

	public void setIsFollowed(Integer isFollowed) {
		this.isFollowed = isFollowed;
	}

}
