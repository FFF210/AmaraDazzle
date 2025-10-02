package dto.admin;

import java.sql.Timestamp;

public class SearchConditionDTO {
	// 검색 조건
	private String startDate; //기간검색 시작날짜 
	private String endDate; //기간검색 끝날짜 
	private String q_select; //문의유형 셀렉트 
	private String totalSearch; //직접입력칸 셀렉트
	private String keyword;	//직접입력칸 input
	
	private Timestamp startDateTime;
	private Timestamp endDateTime;

	// 페이징 관련
	private int start_p; // LIMIT 시작
	private int post_ea; // 페이지당 게시글 수
	
	
	public SearchConditionDTO() {}
	public SearchConditionDTO(String startDate, String endDate, String q_select, String totalSearch,
			String keyword, Timestamp startDateTime, Timestamp endDateTime, int start_p, int post_ea) {
		super();
		this.startDate = startDate;
		this.endDate = endDate;
		this.q_select = q_select;
		this.totalSearch = totalSearch;
		this.keyword = keyword;
		this.startDateTime = startDateTime;
		this.endDateTime = endDateTime;
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


	public String getq_select() {
		return q_select;
	}


	public void setqCate_select(String q_select) {
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
		return "SearchConditionDTO [startDate=" + startDate + ", endDate=" + endDate
				+ ", q_select=" + q_select + ", totalSearch=" + totalSearch + ", keyword=" + keyword
				+ ", startDateTime=" + startDateTime + ", endDateTime=" + endDateTime + ", start_p=" + start_p
				+ ", post_ea=" + post_ea + "]";
	}




	


	
	

}
