package util;

import java.util.HashMap;
import java.util.Map;

public class Paging {

	int post_cnt = 10;  //한페이지당 보여줄 게시물 개수 
	int startPage = 0; // limit 시작번호
	int clickPage = 0; // 사용자가 클릭한 페이지번호에 맞는 게시글 순차번호 계산값

	// 게시물 일련번호 계산
	public int serial_no(int pageno) {

		if (pageno == 1) {
			this.clickPage = 0;
		} else { // 1외의 다른 페이지를 클릭시
			this.clickPage = (pageno - 1) * this.post_cnt;
		}

		return this.clickPage;
	}

	// 쿼리문 limit에 값 전달
	public Map<String, Object> paging(Integer pageno) {
		/*
		 * 1p 클릭 => limit 0,10 
		 * 2p 클릭 => limit 10,10 
		 * 3p 클릭 => limit 20,10 ...
		 */
		this.startPage = (pageno - 1) * this.post_cnt; // limit 시작번호

		Map<String, Object> page = new HashMap<String, Object>();
		page.put("start_p", this.startPage); // limit의 시작번호
		page.put("post_ea", this.post_cnt); // limit의 두번째 번호

		return page;
	}

	// 페이지개수
	public Map<String, Object> page_ea(Integer pageno, Integer total_post) {
		// pageno : 현재 페이지 번호 , total_post : 전체게시물 개수

		int page_ea = 5; // 한페이지에 보여줄 페이징의 갯수
		int page_ea_total; // 총 페이지 개수
		int start_pg;
		int end_pg;
		int final_post_ea;
		
		page_ea_total = (int) Math.ceil((double) total_post / this.post_cnt);
		final_post_ea = total_post % this.post_cnt;
		
		// 1~5, 6~10, 11~
		start_pg = (((pageno - 1) / page_ea) * page_ea) + 1;
		end_pg = Math.min(start_pg + (page_ea - 1), page_ea_total);

		Map<String, Object> pageinfo = new HashMap<String, Object>();
		pageinfo.put("pageno", pageno);	//현재 페이지 번호
		pageinfo.put("page_ea_total", page_ea_total);	//총 페이지 개수
		pageinfo.put("page_ea", page_ea);	//한페이지에 보여줄 페이징의 갯수
		pageinfo.put("final_post_ea", final_post_ea);	//마지막 페이지에 있는 게시물 개수 
		pageinfo.put("start_pg", start_pg);	//현재화면의 시작 페이지 
		pageinfo.put("end_pg", end_pg);	//현재화면의 끝 페이지 
			
		return pageinfo;
	}

}
