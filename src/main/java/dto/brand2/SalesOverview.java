package dto.brand2;

import java.sql.Date;

public class SalesOverview {
    private Date date;          // 집계 날짜
    private Long categoryId;    // 대분류 카테고리 ID (depth=1)
    private String categoryName;// 대분류 카테고리명 (depth=1)
    private Long amount;        // 매출액 (line_subtotal - discount)
    private Long total;
    
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Long getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public Long getAmount() {
		return amount;
	}
	public void setAmount(Long amount) {
		this.amount = amount;
	}
	public Long getTotal() {
		return total;
	}
	public void setTotal(Long total) {
		this.total = total;
	}
	@Override
	public String toString() {
		return "SalesOverview [date=" + date + ", categoryId=" + categoryId + ", categoryName=" + categoryName
				+ ", amount=" + amount + ", total=" + total + "]";
	}
}
