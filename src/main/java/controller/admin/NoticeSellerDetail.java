package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Notice;
import service.admin.NoticeService;
import service.admin.NoticeServiceImpl;

@WebServlet("/admin/noticeSellerDetail")
public class NoticeSellerDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//공지(seller) 상세보기 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		String num = request.getParameter("num"); 
		NoticeService notice_svc = new NoticeServiceImpl();

		try {
			Notice notice_DTO = null;
			notice_DTO = notice_svc.noticeSellerDetail(Integer.parseInt(num));
			
			List<Long> ids = new ArrayList<>();
			if (notice_DTO.getImage1FileId() != null) ids.add(notice_DTO.getImage1FileId());
			if (notice_DTO.getImage2FileId() != null) ids.add(notice_DTO.getImage2FileId());
			if (notice_DTO.getImage3FileId() != null) ids.add(notice_DTO.getImage3FileId());

			notice_DTO.setImageFileIds(ids);
			
			request.setAttribute("notice", notice_DTO);
			request.getRequestDispatcher("notice_detail.jsp").forward(request, response);

		} catch (Exception e) {
			
			e.printStackTrace();
			
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}

	}

}
