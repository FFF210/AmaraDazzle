package dto.admin;

import java.sql.Timestamp;
import java.util.List;

public class SearchConditionDTO {
	// 검색 조건
	private String startDate; //기간검색 시작날짜 
	private String endDate; //기간검색 끝날짜 
	private String q_select; //문의유형 셀렉트 
	private String totalSearch; //직접입력칸 셀렉트
	private String keyword;	//직접입력칸 input
	private String middleFilter; //선택필터 
	
	private Timestamp startDateTime;
	private Timestamp endDateTime;
	private Timestamp startDateTime2;
	private Timestamp endDateTime2;

	// 페이징 관련
	private int start_p; // LIMIT 시작
	private int post_ea; // 페이지당 게시글 수
	
	
	public SearchConditionDTO() {}
	public SearchConditionDTO(String startDate, String endDate, String q_select, String totalSearch, String keyword,
			String middleFilter, Timestamp startDateTime, Timestamp endDateTime, Timestamp startDateTime2,
			Timestamp endDateTime2, int start_p, int post_ea) {
		super();
		this.startDate = startDate;
		this.endDate = endDate;
		this.q_select = q_select;
		this.totalSearch = totalSearch;
		this.keyword = keyword;
		this.middleFilter = middleFilter;
		this.startDateTime = startDateTime;
		this.endDateTime = endDateTime;
		this.startDateTime2 = startDateTime2;
		this.endDateTime2 = endDateTime2;
		this.start_p = start_p;
		this.post_ea = post_ea;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getQ_select() {
		return q_select;
	}
	public void setQ_select(String q_select) {
		this.q_select = q_select;
	}
	public String getTotalSearch() {
		return totalSearch;
	}
	public void setTotalSearch(String totalSearch) {
		this.totalSearch = totalSearch;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getMiddleFilter() {
		return middleFilter;
	}
	public void setMiddleFilter(String middleFilter) {
		this.middleFilter = middleFilter;
	}
	public Timestamp getStartDateTime() {
		return startDateTime;
	}
	public void setStartDateTime(Timestamp startDateTime) {
		this.startDateTime = startDateTime;
	}
	public Timestamp getEndDateTime() {
		return endDateTime;
	}
	public void setEndDateTime(Timestamp endDateTime) {
		this.endDateTime = endDateTime;
	}
	public Timestamp getStartDateTime2() {
		return startDateTime2;
	}
	public void setStartDateTime2(Timestamp startDateTime2) {
		this.startDateTime2 = startDateTime2;
	}
	public Timestamp getEndDateTime2() {
		return endDateTime2;
	}
	public void setEndDateTime2(Timestamp endDateTime2) {
		this.endDateTime2 = endDateTime2;
	}
	public int getStart_p() {
		return start_p;
	}
	public void setStart_p(int start_p) {
		this.start_p = start_p;
	}
	public int getPost_ea() {
		return post_ea;
	}
	public void setPost_ea(int post_ea) {
		this.post_ea = post_ea;
	}
	
	@Override
	public String toString() {
		return "SearchConditionDTO [startDate=" + startDate + ", endDate=" + endDate + ", q_select=" + q_select
				+ ", totalSearch=" + totalSearch + ", keyword=" + keyword + ", middleFilter=" + middleFilter
				+ ", startDateTime=" + startDateTime + ", endDateTime=" + endDateTime + ", startDateTime2="
				+ startDateTime2 + ", endDateTime2=" + endDateTime2 + ", start_p=" + start_p + ", post_ea=" + post_ea
				+ "]";
	}







	


	
	

}
