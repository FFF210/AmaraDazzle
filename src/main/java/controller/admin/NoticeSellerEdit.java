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

@WebServlet("/admin/noticeSellerEdit")
@MultipartConfig(
	fileSizeThreshold = 1024 * 1024 * 2, // 메모리 저장 임계값 (2MB)
	maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크기 (10MB)
	maxRequestSize = 1024 * 1024 * 50 // 전체 요청 최대 크기 (50MB)
)
public class NoticeSellerEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final NoticeService notice_svc = new NoticeServiceImpl();

	// 공지 수정 페이지로 이동
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String num = request.getParameter("num"); 
		
		try {
			//공지 내용 가져오기 
			Notice noticeOne = notice_svc.noticeSellerDetail(Integer.parseInt(num));
			request.setAttribute("noticeOne", noticeOne);
			request.getRequestDispatcher("/admin/notice_seller_editView.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	// 공지 수정 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");

		try {
			String num = request.getParameter("num"); 
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
			
			// 새 파일 첨부가 있는 경우에만 기존 파일 삭제 및 교체
			if (!fileParts.isEmpty()) {
			    FileAttach fileAttach = new FileAttach();
			    Notice selectOne = notice_svc.noticeSellerDetail(Integer.parseInt(num));

			    String[] oldFiles = {
			        selectOne.getImage1FileRename(),
			        selectOne.getImage2FileRename(),
			        selectOne.getImage3FileRename()
			    };

			    boolean allDeleted = true;
			    for (String fRename : oldFiles) {
			        if (fRename != null && !fRename.isEmpty()) {
			            boolean deleted = fileAttach.file_delete(fRename, request);
			            if (!deleted) allDeleted = false;
			        }
			    }

			    if (allDeleted) {
			    	Map<String, Object> result = fileAttach.file_save(fileParts, request);
			    	boolean saveYN = Boolean.TRUE.equals(result.get("save_YN"));
					List<Long> uploaded = (List<Long>) result.get("fileIds");
					
					if (saveYN && uploaded != null) {
						fileIds = uploaded; // 성공 시에만 세팅
					}
					
			    } else {
			        System.err.println("기존 파일 일부 삭제 실패");
			    }
			}

			//카테고리 분류 
			Long category = null;
			if(noticeCate.trim().equals("시스템")) category = 28L;
			else if(noticeCate.trim().equals("이벤트")) category = 29L;
			else if(noticeCate.trim().equals("기타")) category = 30L;
			
			Notice notice = new Notice(category, title, content, writer, targetType, fileIds, Long.valueOf(num));
			int result = notice_svc.noticeSellerEdit(notice); 
			
			String json = null;
			if (result > 0) {
				json = "{\"status\":\"ok\",\"title\":\"판매자 공지 수정 완료\",\"message\":\"공지 수정이 완료되었습니다.\",\"id\":" + num +"}";
				response.getWriter().print(json);

			} else {
				json = "{\"status\":\"fail\",\"title\":\"공지 수정 실패\",\"message\":\"시스템 문제로 공지 수정에 실패했습니다.\"}";
				response.getWriter().write(json);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "시스템 오류로 공지 수정에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}

	}

}
