package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Notice;
import service.admin.NoticeService;
import service.admin.NoticeServiceImpl;
import util.PageInfo;

@WebServlet("/admin/noticeSellerList")
public class NoticeSellerList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String spage = request.getParameter("page");
		Integer page = 1;
		if(spage != null) {
			page = Integer.parseInt(spage);
		}
		
		PageInfo pageInfo = new PageInfo(page);
		
		NoticeService notice_svc = new NoticeServiceImpl();
		
		try {
			Integer sellerNoticeCnt = notice_svc.noticeCount(); //전체 게시글 수 
			List<Notice> noticeSellerList = notice_svc.sellerNoticeByPage(pageInfo);
			

			request.setAttribute("noticeCnt", sellerNoticeCnt);
			request.setAttribute("noticeList", noticeSellerList);
			request.setAttribute("pageInfo", pageInfo);
			
			request.getRequestDispatcher("/admin/notice_seller.jsp").forward(request, response);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}




}
