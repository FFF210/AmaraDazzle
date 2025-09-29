package controller.admin;

import java.io.IOException;
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
import util.PageInfo;
import util.Paging;

@WebServlet("/admin/noticeSellerList")
public class NoticeSellerList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		try {
			Paging m_pg = new Paging();
			NoticeService notice_svc = new NoticeServiceImpl();

			String pageno = request.getParameter("pageNo");	//클릭한 페이지번호 
			String keyword = request.getParameter("keyword"); //검색어
			
			Integer p_no = 1;  //전달받은 파라미터 int로 변환
			if(pageno != null) {
				p_no = Integer.parseInt(pageno);
			}
			
			String condition = ""; //검색여부 
			
			//총 게시글 수 
			Integer sellerNoticeCnt = notice_svc.noticeCount(condition, keyword); 
			
			int clickPage = m_pg.serial_no(p_no);  // 게시물 일련번호 계산 
			Map<String, Object> paging = m_pg.page_ea(p_no, sellerNoticeCnt); // 페이지개수
			
			
			//총 게시물 리스트
			List<Notice> noticeSellerList = null;
			if(keyword.equals("")) { //검색어가 없을 경우
				noticeSellerList = notice_svc.sellerNoticeByPage(p_no);	// 공지(seller) 게시글 리스트 
				
			}else {  //검색어가 있을 경우 
				condition = "search";
				sellerNoticeCnt = notice_svc.noticeCount(condition, keyword);  //검색된 게시글 총 개수 
				noticeSellerList = notice_svc.search_post(keyword, p_no);
				paging = m_pg.page_ea(p_no, sellerNoticeCnt);
			}
			
//			System.out.println("noticeSellerList : " + noticeSellerList);
			
			request.setAttribute("clickPage", clickPage);  //페이지번호 클릭시 나오는 게시글 일련번호
			request.setAttribute("paging", paging); //페이지 개수 
			request.setAttribute("pageno", pageno); //클릭한 페이지 번호 
			request.setAttribute("keyword", keyword); //검색어 
			request.setAttribute("noticeCnt", sellerNoticeCnt); //총 게시글 수  
			request.setAttribute("noticeList", noticeSellerList);  //총 게시물 리스트		
			
			request.getRequestDispatcher("/admin/notice_seller.jsp").forward(request, response);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
		
		
		
//		String spage = request.getParameter("page");
//		Integer page = 1;
//		if(spage != null) {
//			page = Integer.parseInt(spage);
//		}
//		
//		PageInfo pageInfo = new PageInfo(page);
//		
//		NoticeService notice_svc = new NoticeServiceImpl();
//		
//		try {
//			Integer sellerNoticeCnt = notice_svc.noticeCount(); //전체 게시글 수 
//			List<Notice> noticeSellerList = notice_svc.sellerNoticeByPage(pageInfo);
//			
//			System.out.println("noticeSellerList : " + noticeSellerList);
//			request.setAttribute("noticeCnt", sellerNoticeCnt);
//			request.setAttribute("noticeList", noticeSellerList);
//			request.setAttribute("pageInfo", pageInfo);
//			
//			request.getRequestDispatcher("/admin/notice_seller.jsp").forward(request, response);
//			
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			request.setAttribute("err", "오류가 발생했습니다.");
//			request.getRequestDispatcher("error.jsp").forward(request, response);
//		}
	}




}
