package util;

public class PageInfo {
	private Integer curPage; //현재 보고있는 페이지 숫자 
	private Integer allPage;	//전체 페이지 개수 
	private Integer startPage;	//현재화면의 시작 페이지 
	private Integer endPage;	//현재화면의 끝 페이지 

	
	public PageInfo() {}
	public PageInfo(Integer curPage) {
		this.curPage = curPage;
	}
	public PageInfo(Integer curPage, Integer allPage, Integer startPage, Integer endPage) {
		super();
		this.curPage = curPage;
		this.allPage = allPage;
		this.startPage = startPage;
		this.endPage = endPage;
	}
	
	
	public Integer getCurPage() {
		return curPage;
	}
	public void setCurPage(Integer curPage) {
		this.curPage = curPage;
	}
	public Integer getAllPage() {
		return allPage;
	}
	public void setAllPage(Integer allPage) {
		this.allPage = allPage;
	}
	public Integer getStartPage() {
		return startPage;
	}
	public void setStartPage(Integer startPage) {
		this.startPage = startPage;
	}
	public Integer getEndPage() {
		return endPage;
	}
	public void setEndPage(Integer endPage) {
		this.endPage = endPage;
	}
	
	@Override
	public String toString() {
		return "PageInfo [curPage=" + curPage + ", allPage=" + allPage + ", startPage=" + startPage + ", endPage="
				+ endPage + "]";
	}
}
