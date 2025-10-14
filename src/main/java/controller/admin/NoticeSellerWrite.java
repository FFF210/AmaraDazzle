package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
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
@MultipartConfig(
	fileSizeThreshold = 1024 * 1024 * 2, // 메모리 저장 임계값 (2MB)
	maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크기 (10MB)
	maxRequestSize = 1024 * 1024 * 50 // 전체 요청 최대 크기 (50MB)
)
public class NoticeSellerWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// GET
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/admin/notice_seller_write.jsp").forward(request, response);
	}

	// POST
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");

		try {
			Long targetType = Long.valueOf(request.getParameter("noticeTargetType"));
			String noticeCate = request.getParameter("noticeCate");
			String title = request.getParameter("noticeTitle");
			String content = request.getParameter("content");
			String writer = request.getParameter("noticeWriter");

			System.out.println("targetType : " + targetType);
			System.out.println("noticeCate : " + noticeCate);
			System.out.println("title : " + title);
			System.out.println("content : " + content);
			System.out.println("writer : " + writer);
			
			// 파일첨부파트 추출
			List<Part> fileParts = new ArrayList<>();
			for (Part part : request.getParts()) {
				if ("noticeFile".equals(part.getName()) && part.getSize() > 0) { // 전달된 Part중 name이 noticeFile 이면서 용량이 있는 Part가 있는지 확인
					fileParts.add(part);
				}
			}

			List<Long> fileIds = new ArrayList<>();
			if (!fileParts.isEmpty()) { // 파일첨부를 한 경우
				FileAttach fileAttach = new FileAttach(); // 파일첨부 클래스 소환
				Map<String, Object> result = fileAttach.file_save(fileParts, request);

				boolean saveYN = Boolean.TRUE.equals(result.get("save_YN"));
				List<Long> uploaded = (List<Long>) result.get("fileIds");

				if (saveYN && uploaded != null) {
					fileIds = uploaded; // 성공 시에만 세팅
				}
			}

			//카테고리 분류 
			Long category = null;
			if(noticeCate.trim().equals("시스템")) category = 28L;
			else if(noticeCate.trim().equals("이벤트")) category = 29L;
			else if(noticeCate.trim().equals("기타")) category = 30L;
			
			Notice notice = new Notice(category, title, content, writer, targetType, fileIds);

			NoticeService notice_svc = new NoticeServiceImpl();
			Long noticePk = notice_svc.noticeSellerWrite(notice); //DB에 데이터 저장과 함께 생성된 pk값 받아옴 
			
			String json = null;
			if (noticePk != null && noticePk > 0) {
				json = "{\"status\":\"ok\",\"title\":\"판매자 공지 등록 완료\",\"message\":\"공지 등록이 완료되었습니다.\",\"id\":" + noticePk +"}";
				response.getWriter().print(json);

			} else {
				json = "{\"status\":\"fail\",\"title\":\"공지 등록 실패\",\"message\":\"시스템문제로 공지 등록에 실패했습니다.\"}";
				response.getWriter().write(json);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "시스템 오류로 공지 작성에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}

	}

}
