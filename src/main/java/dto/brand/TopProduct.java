package dto.brand;

import java.util.Date;

public class TopProduct {
	private long productId;
	private String productName;
	private Long thumbnailFileId;
	private int totalSold;
	private Date weekStartDate; // 이번 주 시작일
	private Date baseDate; // 기준일(오늘)

	public Date getWeekStartDate() {
		return weekStartDate;
	}

	public void setWeekStartDate(Date weekStartDate) {
		this.weekStartDate = weekStartDate;
	}

	public Date getBaseDate() {
		return baseDate;
	}

	public void setBaseDate(Date baseDate) {
		this.baseDate = baseDate;
	}

	public long getProductId() {
		return productId;
	}

	public void setProductId(long productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Long getThumbnailFileId() {
		return thumbnailFileId;
	}

	public void setThumbnailFileId(Long thumbnailFileId) {
		this.thumbnailFileId = thumbnailFileId;
	}

	public int getTotalSold() {
		return totalSold;
	}

	public void setTotalSold(int totalSold) {
		this.totalSold = totalSold;
	}

}
