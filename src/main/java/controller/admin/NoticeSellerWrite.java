package controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
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
import service.admin.NoticeSellerService;
import service.admin.NoticeSellerServiceImpl;
import util.FileAttach;


@WebServlet("/admin/noticeSellerWrite")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 *2,  // 메모리 저장 임계값 (2MB)
    maxFileSize = 1024 * 1024 * 10,   // 개별 파일 최대 크기 (10MB)
    maxRequestSize = 1024 * 1024 * 50 // 전체 요청 최대 크기 (50MB)
)
public class NoticeSellerWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	//GET 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/admin/notice_seller_write.jsp").forward(request, response);
	}

	//POST
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		try {

			Notice notice_DTO = new Notice();
			List<Part> fileParts = new ArrayList<>();
			Collection<Part> nFile = request.getParts();
			
			Long noticeTargetType = Long.parseLong(request.getParameter("target_type_id"));
			Long noticeCate = Long.parseLong(request.getParameter("type_id"));
			String noticeTitle = request.getParameter("title");
			String content = request.getParameter("content");
			String noticeWriter = request.getParameter("writer");
		
			for (Part part : nFile) {
			    if ("noticeFile".equals(part.getName()) && part.getSize() > 0) { //전달된 Part중 name이 noticeFile 이면서 용량이 있는 Part가 있는지 확인 
			        fileParts.add(part); //해당 Part만 리스트에 추가 
			    }
			}
			if (!fileParts.isEmpty()) { //리스트에 추가된 Part가 있으면 파일저장 클래스 소환 
			    FileAttach mfile = new FileAttach();
			    Map<String, Object> result = mfile.file_save(fileParts, request);
			    
			    if (result != null) {
			        boolean saveYN = Boolean.TRUE.equals(result.get("save_YN"));
			        List<Long> fileIds = (List<Long>) result.get("fileIds");

			        if (saveYN && fileIds != null) {
			            notice_DTO.setImageFileIds(fileIds); 
			        }
			    }
			}

			notice_DTO = new Notice(noticeCate, noticeTitle, content, noticeWriter, noticeTargetType, notice_DTO.getImageFileIds());
			NoticeSellerService notice_svc = new NoticeSellerServiceImpl();
			notice_svc.noticeSellerWrite(notice_DTO);
			
			request.setAttribute("noticeSeller", notice_DTO);
			request.getRequestDispatcher("notice_detail.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "시스템 오류로 공지 작성에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
	}
	



}
