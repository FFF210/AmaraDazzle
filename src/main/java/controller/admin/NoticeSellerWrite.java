package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dto.Notice;
import service.admin.NoticeService;
import service.admin.NoticeServiceImpl;
import util.FileAttach;

@WebServlet("/admin/noticeSellerWrite")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 메모리 저장 임계값 (2MB)
		maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크기 (10MB)
		maxRequestSize = 1024 * 1024 * 50 // 전체 요청 최대 크기 (50MB)
)
public class NoticeSellerWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// GET
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/admin/notice_seller_write.jsp").forward(request, response);
	}

	// POST
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		try {

			Long targetType = Long.valueOf(request.getParameter("target_type_id"));
			Long category = Long.valueOf(request.getParameter("type_id"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");

			// 파일첨부파트 추출
			List<Part> fileParts = new ArrayList<>();
			for (Part part : request.getParts()) {
				if ("noticeFile".equals(part.getName()) && part.getSize() > 0) { // 전달된 Part중 name이 noticeFile 이면서 용량이 있는 Part가 있는지 확인
					fileParts.add(part);
				}
			}

			List<Long> fileIds = Collections.emptyList();
			if (!fileParts.isEmpty()) { // 파일첨부를 한 경우
				FileAttach fileAttach = new FileAttach(); // 파일첨부 클래스 소환
				Map<String, Object> result = fileAttach.file_save(fileParts, request);

				boolean saveYN = Boolean.TRUE.equals(result.get("save_YN"));
				List<Long> uploaded = (List<Long>) result.get("fileIds");

				if (saveYN && uploaded != null) {
					fileIds = uploaded; // 성공 시에만 세팅
				}
			}

			Notice notice = new Notice(category, title, content, writer, targetType, fileIds);

			NoticeService noticeSvc = new NoticeServiceImpl();
			int insertCount = noticeSvc.noticeSellerWrite(notice);

			if (insertCount > 0) {
				response.getWriter().write("ok");

				// request.setAttribute("noticeSeller", notice);
				// request.getRequestDispatcher("notice_detail.jsp").forward(request, response);
			} else {
				response.getWriter().write("fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "시스템 오류로 공지 작성에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}

	}

}
