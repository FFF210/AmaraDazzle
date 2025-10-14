package dto.brand2;

import java.sql.Date;

public class SalesStatusRow {
	private Date date;       // 집계 날짜
    private Long total;      // 전체 매출
    private Long skincare;   // 스킨케어
    private Long maskpack;   // 마스크팩
    private Long cleansing;  // 클렌징
    private Long suncare;    // 선케어
    private Long makeup;     // 메이크업
    private Long haircare;   // 헤어케어
    private Long bodycare;   // 바디케어
    private Long perfume;    // 향수
    private Long menCare;	 // 맨즈케어
    
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Long getTotal() {
		return total;
	}
	public void setTotal(Long total) {
		this.total = total;
	}
	public Long getSkincare() {
		return skincare;
	}
	public void setSkincare(Long skincare) {
		this.skincare = skincare;
	}
	public Long getMaskpack() {
		return maskpack;
	}
	public void setMaskpack(Long maskpack) {
		this.maskpack = maskpack;
	}
	public Long getCleansing() {
		return cleansing;
	}
	public void setCleansing(Long cleansing) {
		this.cleansing = cleansing;
	}
	public Long getSuncare() {
		return suncare;
	}
	public void setSuncare(Long suncare) {
		this.suncare = suncare;
	}
	public Long getMakeup() {
		return makeup;
	}
	public void setMakeup(Long makeup) {
		this.makeup = makeup;
	}
	public Long getHaircare() {
		return haircare;
	}
	public void setHaircare(Long haircare) {
		this.haircare = haircare;
	}
	public Long getBodycare() {
		return bodycare;
	}
	public void setBodycare(Long bodycare) {
		this.bodycare = bodycare;
	}
	public Long getPerfume() {
		return perfume;
	}
	public void setPerfume(Long perfume) {
		this.perfume = perfume;
	}
	
	public Long getMenCare() {
		return menCare;
	}
	public void setMenCare(Long menCare) {
		this.menCare = menCare;
	}
	@Override
	public String toString() {
		return "SalesStatusRow [date=" + date + ", total=" + total + ", skincare=" + skincare + ", maskpack=" + maskpack
				+ ", cleansing=" + cleansing + ", suncare=" + suncare + ", makeup=" + makeup + ", haircare=" + haircare
				+ ", bodycare=" + bodycare + ", perfume=" + perfume + ", menCare=" + menCare + "]";
	}
	
}
