package controller.admin;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Settlement;
import service.admin.SettlementService;
import service.admin.SettlementServiceImpl;
import util.Paging;

@WebServlet("/admin/accountTodayList")
public class TodayCalcList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private final SettlementService settle_svc = new SettlementServiceImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		try {
			String pageno = request.getParameter("page"); // 클릭한 페이지번호
			Integer p_no = 1; // 기본 페이지번호 = 1
			if (pageno != null) {
				p_no = Integer.parseInt(pageno);
			}
			Paging m_pg = new Paging();

			String middleFilter = request.getParameter("middleFilter");
			String totalSearch = request.getParameter("totalSearch");
			String keyword = request.getParameter("keyword");
			
			System.out.println("middleFilter : " + middleFilter);
			System.out.println("totalSearch : " + totalSearch);
			System.out.println("keyword : " + keyword);
			
			// 검색 조건이 하나라도 있는지 확인
		    boolean hasCondition =
		        (middleFilter != null && !middleFilter.trim().isEmpty()) ||
		        (totalSearch != null && !totalSearch.trim().isEmpty()) ||
		        (keyword != null && !keyword.trim().isEmpty());
		    
		    List<Settlement> settlementList;
		    Integer settlementCnt;
		    Map<String, Object> paging;
		    
			int postNo = m_pg.serial_no(p_no); // 게시물 일련번호 계산

			if (!hasCondition) {
		        // 검색조건이 전혀 없는 경우: 전체 목록
				settlementCnt = settle_svc.settlementCnt(new HashMap<String, String>()); // 전체 카운트
		        paging = m_pg.page_ea(p_no, settlementCnt); // 페이징Map
		        settlementList = settle_svc.settlementAllList(p_no);
		        
		    } else {
		        // 검색조건이 하나라도 있는 경우: 검색 수행
		    	
		    	Map<String, String> searchContent = new HashMap<>();
				searchContent.put("middleFilter", middleFilter);
				searchContent.put("totalSearch", totalSearch);
				searchContent.put("keyword", keyword);
				
				settlementCnt = settle_svc.settlementCnt(searchContent);
		        paging = m_pg.page_ea(p_no, settlementCnt);
		        settlementList = settle_svc.settlementSearchList(searchContent, p_no);
		        
		        request.setAttribute("searchContent", searchContent); // 검색어 map
		    }
			
			LocalDate today = LocalDate.now();
			LocalDate firstDayPrevMonth = today.minusMonths(1).withDayOfMonth(1);
			LocalDate lastDayPrevMonth = today.minusMonths(1).withDayOfMonth(today.minusMonths(1).lengthOfMonth());
			
			request.setAttribute("settleStartDate", firstDayPrevMonth); //  정산월 시작일
			request.setAttribute("settleEndDate", lastDayPrevMonth); // 정산월 마지막일 
			
			request.setAttribute("postNo", postNo); // 페이지번호 클릭시 나오는 게시글 일련번호
			request.setAttribute("paging", paging); // 페이징Map
			request.setAttribute("settlementCnt", settlementCnt); // 총 게시글 수
			request.setAttribute("settlementList", settlementList); // 총 게시물 리스트
			System.out.println("settlementList : " + settlementList);
			request.getRequestDispatcher("/admin/accounts_todayCalc.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
		
	}
}
