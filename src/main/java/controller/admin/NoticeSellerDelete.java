package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
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
import util.FileAttach;

@WebServlet("/admin/noticeSellerDelete")
public class NoticeSellerDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NoticeService notice_svc = new NoticeServiceImpl();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter pw = response.getWriter();

		try {
			String[] n_ch = request.getParameterValues("n_ch");
			
			boolean allSuccess = true;
			for (String noticeId : n_ch) {
				Notice selectOne = notice_svc.noticeSellerDetail(Integer.parseInt(noticeId));

				String[] oldFiles = { 
					selectOne.getImage1FileRename(), 
					selectOne.getImage2FileRename(),
					selectOne.getImage3FileRename()
				};

				// 파일 삭제 (실패하더라도 공지 DB 삭제는 진행)
				for (String fRename : oldFiles) {
					if (fRename != null && !fRename.isEmpty()) {
						new FileAttach().file_delete(fRename, request);
					}
				}

				int result = notice_svc.noticeSellerDelete(Long.valueOf(noticeId));
				if (result <= 0) allSuccess = false;
			}

			if (allSuccess) {
				pw.print("{\"status\":\"ok\",\"title\":\"삭제 완료\",\"message\":\"공지 삭제가 완료되었습니다.\"}");
			} else {
				pw.print("{\"status\":\"partial\",\"title\":\"일부 실패\",\"message\":\"일부 공지 삭제에 실패했습니다.\"}");
			}

		} catch (Exception e) {
			e.printStackTrace();
			pw.print("{\"status\":\"error\",\"title\":\"시스템 오류\",\"message\":\"공지 삭제 중 오류가 발생했습니다.\"}");
			
		} finally {
			pw.close();
		}
	}
}
