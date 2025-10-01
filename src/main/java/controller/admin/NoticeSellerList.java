package controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Notice;
import service.admin.NoticeService;
import service.admin.NoticeServiceImpl;
import util.Paging;

@WebServlet("/admin/noticeSellerList")
public class NoticeSellerList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		try {
			String pageno = request.getParameter("page"); // 클릭한 페이지번호
			Integer p_no = 1; // 기본 페이지번호 = 1
			if (pageno != null) {
				p_no = Integer.parseInt(pageno);
			}

			Paging m_pg = new Paging();
			NoticeService notice_svc = new NoticeServiceImpl();

			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String q_select = request.getParameter("q_select");
			String totalSearch = request.getParameter("totalSearch");
			String keyword = request.getParameter("keyword");
			
			// 검색 조건이 하나라도 있는지 확인
		    boolean hasCondition =
		        (startDate != null && !startDate.trim().isEmpty()) ||
		        (endDate != null && !endDate.trim().isEmpty()) ||
		        (q_select != null && !q_select.trim().isEmpty()) ||
		        (totalSearch != null && !totalSearch.trim().isEmpty()) ||
		        (keyword != null && !keyword.trim().isEmpty());
		    
		    List<Notice> noticeSellerList;
		    Integer sellerNoticeCnt;
		    Map<String, Object> paging;
		    
			int postNo = m_pg.serial_no(p_no); // 게시물 일련번호 계산

			if (!hasCondition) {
		        // 검색조건이 전혀 없는 경우: 전체 목록
		        sellerNoticeCnt = notice_svc.noticeCount(new HashMap<String, String>()); // 전체 카운트
		        paging = m_pg.page_ea(p_no, sellerNoticeCnt); // 페이징Map
		        noticeSellerList = notice_svc.sellerNoticeByPage(p_no);
		        
		    } else {
		        // 검색조건이 하나라도 있는 경우: 검색 수행
		    	
		    	Map<String, String> searchContent = new HashMap<>();
				searchContent.put("startDate", startDate);
				searchContent.put("endDate", endDate);
				searchContent.put("q_select", q_select);
				searchContent.put("totalSearch", totalSearch);
				searchContent.put("keyword", keyword);
				
		        sellerNoticeCnt = notice_svc.noticeCount(searchContent);
		        paging = m_pg.page_ea(p_no, sellerNoticeCnt);
		        noticeSellerList = notice_svc.search_post(searchContent, p_no);
		        
		        request.setAttribute("searchContent", searchContent); // 검색어 map
		    }
//			System.out.println("hasCondition=" + hasCondition + ", sellerNoticeCnt=" + sellerNoticeCnt);
			
			request.setAttribute("postNo", postNo); // 페이지번호 클릭시 나오는 게시글 일련번호
			request.setAttribute("paging", paging); // 페이징Map
			request.setAttribute("noticeCnt", sellerNoticeCnt); // 총 게시글 수
			request.setAttribute("noticeList", noticeSellerList); // 총 게시물 리스트

			request.getRequestDispatcher("/admin/notice_seller.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
