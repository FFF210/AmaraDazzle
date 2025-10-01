package controller.brand2;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dto.brand2.BannerForm;
import service.brand2.AdbannerService;
import service.brand2.AdbannerServiceImpl;
import util.FileAttach;

/**
 * Servlet implementation class AdbannerList
 */

@WebServlet("/brand2/adbanner")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
public class Adbanner extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final AdbannerService service = new AdbannerServiceImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
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
		
		System.out.println("[DEBUG Form] " + request.getParameter("bannerName"));
		System.out.println("AdBannerFormController doPost 실행됨!");

		try { 
			// 폼에서 입력받는 값
			BannerForm form = new BannerForm();
			form.setBannerName(request.getParameter("bannerName"));
			form.setManagerName(request.getParameter("managerName"));
			form.setManagerTel(request.getParameter("managerTel"));
			form.setBannerMessage(request.getParameter("bannerMessage"));
			
			// 최초 신청은 승인대기 상태
			form.setStatus("PENDING");
			
			// 신청일
			form.setCreatedAt(new Timestamp(System.currentTimeMillis()));
			
			
			// 날짜 변환
			String startDateStr = request.getParameter("startDate"); // "2025-09-26"
			String endDateStr = request.getParameter("endDate");
			
			if (startDateStr == null || endDateStr == null) {
			    throw new IllegalArgumentException("날짜 값이 비어 있습니다.");
			}
			
			// LocalDate 로 변환
			LocalDate startLocal = LocalDate.parse(startDateStr);
			LocalDate endLocal = LocalDate.parse(endDateStr);
			// LocalDate → Timestamp (하루의 00:00:00 기준)
			form.setStartDate(Timestamp.valueOf(startLocal.atStartOfDay()));
			form.setEndDate(Timestamp.valueOf(endLocal.atStartOfDay()));
			
			// 세션에서 brandId 꺼내기
//			Long brandId = (Long) request.getSession().getAttribute("brandId");
			HttpSession session = request.getSession();
			Long brandId = (Long) session.getAttribute("brandId"); // 로그인 시 저장했다고 가정
			form.setBrandId(brandId);
			form.setBrandId(1L); // 테스트용 임시값

			
			// 파일 업로드 처리 (Collection<Part>)
//			 FileAttach fileAttach = new FileAttach();
//	         Map<String, Object> resultMap = fileAttach.file_save(request.getParts(), request);
//	         controller에서 http요청 : 스트림 데이터로 들어옴, <form enctype="multipart/form-data"> 여러 파트로 분리되어 전송, 서블릿이 Collection<Part>형태로 제공
//	         HttpServletRequest.getParts() 리턴 타입 Collection<Part>
	            
			// 파일 업로드 처리 (Collection<Part> -> List<Part> 변환)
			 Collection<Part> col = request.getParts(); // @MultipartConfig + enctype 필요
			 List<Part> parts = new ArrayList<>(col);

			 FileAttach fileAttach = new FileAttach();
			 Map<String, Object> resultMap = fileAttach.file_save(parts, request);

			 boolean saveYN = Boolean.TRUE.equals(resultMap.get("save_YN"));
			 if (saveYN) {
			     @SuppressWarnings("unchecked")
			     List<Long> fileIds = (List<Long>) resultMap.get("fileIds");
			     if (fileIds != null && !fileIds.isEmpty()) {
			         // ✅ BannerForm에 uploadFileId 세팅
			         form.setUploadFileId(fileIds.get(0));
			     } else {
			    	 System.out.println("[DEBUG] fileIds가 비어 있음");
			     }
				 System.out.println("[DEBUG] 파일 저장 실패");
			 }

			 
			 System.out.println("[DEBUG] brandId=" + form.getBrandId());
			 System.out.println("[DEBUG] managerName=" + form.getManagerName());
			 System.out.println("[DEBUG] managerTel=" + form.getManagerTel());
			 System.out.println("[DEBUG] startDate=" + form.getStartDate());
			 System.out.println("[DEBUG] endDate=" + form.getEndDate());
			 System.out.println("[DEBUG] bannerName=" + form.getBannerName());
			 System.out.println("[DEBUG] bannerMessage=" + form.getBannerMessage());
			 System.out.println("[DEBUG] brandUrl=" + form.getBrandUrl());

			 
			service.registerBanner(form); // DB 저장

			response.sendRedirect(request.getContextPath() + "/brand2/adbannerComplete.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/brand2/adbannerForm.jsp?error=true");
		}

	}
}
