package controller.brand2;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.Banner;
import dto.UploadFile;
import service.brand2.UploadFileService;
import service.brand2.UploadFileServiceImpl;
import service.brand2.AdbannerService;
import service.brand2.AdbannerServiceImpl;

/**
 * Servlet implementation class AdbannerList
 */

@WebServlet("/brand2/adbanner")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
public class Adbanner extends HttpServlet {
	public Adbanner() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 배너 신청 페이지 이동
		RequestDispatcher dispatcher = request.getRequestDispatcher("/brand2/adbannerForm.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		try {
			// 업로드 설정
			String path = request.getServletContext().getRealPath("upload");
			int size = 10 * 1024 * 1024;
			MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
			
			 // =================== 업로드 파일 저장 ===================
            String fileName = multi.getFilesystemName("uploadFileName"); // 실제 저장된 파일명
            String fileRename = multi.getFilesystemName("uploadFileName");   // 서버에 저장된 이름
            String storagePath = "/upload/" + fileRename;                    // 저장 경로
            
            UploadFile uploadFile = new UploadFile();
            uploadFile.setFileName(fileName);
            uploadFile.setFileRename(fileRename);
            uploadFile.setStoragePath(storagePath);
            
            
            UploadFileService uploadFileService = new UploadFileServiceImpl();
            uploadFileService.registerUploadFile(uploadFile); // insertUploadFileWithAuto 사용
            Long uploadFileId = uploadFile.getUploadFileId(); // PK 값 자동 주입됨
            
            // =================== 배너 저장 ===================
			// 폼에서 입력받는 값
			Banner banner = new Banner();
			
			// Banner DTO에 FK 세팅
			banner.setUploadFileId(uploadFileId);
			
			banner.setBannerName(multi.getParameter("bannerName")); // 광고명
			banner.setManagerName(multi.getParameter("managerName")); // 담당자
			banner.setManagerTel(multi.getParameter("managerTel")); // 담당연락처
			banner.setBannerMessage(multi.getParameter("bannerMessage")); // 전달사항
			banner.setStatus("PENDING"); // 최초 신청은 승인대기 상태
			banner.setCreatedAt(new Timestamp(System.currentTimeMillis())); // 신청일

			// 등록기간 날짜 변환 (HTML Form → String → LocalDate → Timestamp)
			String startDateStr = multi.getParameter("startDate"); // "2025-09-26"
			String endDateStr = multi.getParameter("endDate");
			if (startDateStr == null || endDateStr == null) {
				throw new IllegalArgumentException("날짜 값이 비어 있습니다.");
			}
			LocalDate startLocal = LocalDate.parse(startDateStr);
			LocalDate endLocal = LocalDate.parse(endDateStr);
			banner.setStartDate(Timestamp.valueOf(startLocal.atStartOfDay()));
			banner.setEndDate(Timestamp.valueOf(endLocal.atStartOfDay()));

			// 세션에서 brandId 꺼내기
//			HttpSession session = request.getSession();
//			Brand brand = (Brand) session.getAttribute("brand");
//			if (brand != null) {
//				banner.setBrandId(brand.getBrandId());
//			} 
			
			banner.setBrandId(1L);

			 // (3) upload_file FK 세팅
            banner.setUploadFileId(uploadFileId);
			
			AdbannerService service = new AdbannerServiceImpl();
			service.registerBanner(banner);

			request.getRequestDispatcher("/brand2/adbannerComplete.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/brand2/adbannerForm.jsp?error=true");
		}
	}
}
