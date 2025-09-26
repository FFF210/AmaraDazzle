package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.Notice;
import service.admin.NoticeSellerService;
import service.admin.NoticeSellerServiceImpl;


@WebServlet("/admin/noticeSellerWrite")
public class NoticeSellerWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/admin/notice_seller_write.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		String path = request.getServletContext().getRealPath("upload_file");
		//파일 저장되는 실제 경로 가져옴 
		
		int size = 10*1024*1024; //10MB
		//파일 사이즈 지정. 이 이상 사이즈 올리면 에러발생  
		
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

		
		String title = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String writer = multi.getParameter("writer");
		String filename = multi.getFilesystemName("dfile");
		String imgfilenm = multi.getFilesystemName("ifile");
		
//		Notice notice = new Notice(title, content, writer, filename, imgfilenm);
		NoticeSellerService service = new NoticeSellerServiceImpl();
		
		try {
//			service.noticeWrite(notice);
//			request.setAttribute("notice", notice);
//			request.getRequestDispatcher("notice_detail.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "시스템 오류로 공지 작성에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
	}

}
