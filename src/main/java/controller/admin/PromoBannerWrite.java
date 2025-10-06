package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
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

import dto.Banner;
import dto.Notice;
import dto.UploadFile;
import service.admin.BannerService;
import service.admin.BannerServiceImpl;
import service.admin.NoticeService;
import service.admin.NoticeServiceImpl;
import util.FileAttach;



@WebServlet("/admin/promoBannerWrite")
@MultipartConfig(
	fileSizeThreshold = 1024 * 1024 * 2, // 메모리 저장 임계값 (2MB)
	maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크기 (10MB)
	maxRequestSize = 1024 * 1024 * 50 // 전체 요청 최대 크기 (50MB)
)
public class PromoBannerWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/admin/promotion_banner_write.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=UTF-8");
		
		PrintWriter pw = response.getWriter();

		try {
			String bannerName = request.getParameter("bannerName"); //배너명
			Timestamp startDate = Timestamp.valueOf(request.getParameter("startDate")+ " 00:00:00"); //배너 전시 시작일
			Timestamp endDate =  Timestamp.valueOf(request.getParameter("endDate")+ " 23:59:59"); //배너 전시 마지막일
			String bannerThumb = request.getParameter("bannerThumb"); //배너 이미지
			String bannerLink = request.getParameter("bannerLink"); // 배너 url 
			Long bnWriter = Long.valueOf(request.getParameter("bnWriter")); //등록한 관리자 코드 
			
			// 파일첨부파트 추출
			Part fileParts = request.getPart("bannerThumb");
			Long filePk = null;
			if (fileParts != null) { // 파일첨부를 한 경우
				FileAttach fileAttach = new FileAttach(); // 파일첨부 클래스 소환
				filePk = fileAttach.file_saveOne(fileParts, request);
			}
			System.out.println("filePk : " + filePk);
//			System.out.println("bannerName : " + bannerName);
//			System.out.println("startDate : " + startDate);
//			System.out.println("endDate : " + endDate);
//			System.out.println("fileIds : " + fileIds);
//			System.out.println("bannerLink : " + bannerLink);
//			System.out.println("bnWriter : " + bnWriter);
			
			Banner banner = new Banner(startDate, endDate, bannerName, bannerLink, bnWriter, filePk);
			
			BannerService banner_svc = new BannerServiceImpl();
			int result = banner_svc.adminBannerWrite(banner); 
			if(result > 0 ) {
				pw.print("{\"status\":\"ok\",\"title\":\"배너 등록 완료\",\"message\":\"등록 후 게시 상태를 변경해야 메인에 올라갑니다.\"}");
				
			}else {
				pw.print("{\"status\":\"fail\",\"title\":\"배너 등록 실패\",\"message\":\"시스템 문제로 배너 등록에 실패했습니다.\"}");
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
