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

import dto.Banner;
import dto.Brand;
import dto.UploadFile;
import service.brand2.AdbannerService;
import service.brand2.AdbannerServiceImpl;
import util.FileAttach;

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
			// 폼에서 입력받는 값
			Banner banner = new Banner();
			UploadFile uploadFile = new UploadFile();
			
			banner.setBannerName(request.getParameter("bannerName")); // 광고명
			banner.setManagerName(request.getParameter("managerName")); // 담당자
			banner.setManagerTel(request.getParameter("managerTel")); // 담당연락처
			banner.setBannerMessage(request.getParameter("bannerMessage")); // 전달사항

			// 최초 신청은 승인대기 상태
			banner.setStatus("PENDING");

			// 신청일
			banner.setCreatedAt(new Timestamp(System.currentTimeMillis()));

			// 등록기간 날짜 변환 (HTML Form → String → LocalDate → Timestamp)
			String startDateStr = request.getParameter("startDate"); // "2025-09-26"
			String endDateStr = request.getParameter("endDate");
			if (startDateStr == null || endDateStr == null) {
				throw new IllegalArgumentException("날짜 값이 비어 있습니다.");
			}
			LocalDate startLocal = LocalDate.parse(startDateStr);
			LocalDate endLocal = LocalDate.parse(endDateStr);
			banner.setStartDate(Timestamp.valueOf(startLocal.atStartOfDay()));
			banner.setEndDate(Timestamp.valueOf(endLocal.atStartOfDay()));

			// 세션에서 brandId 꺼내기
			HttpSession session = request.getSession();
			Brand brand = (Brand) session.getAttribute("brand");
			if (brand != null) {
				banner.setBannerId(brand.getBrandId());
			}

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
					banner.setUploadFileId(fileIds.get(0));
				} else {
					System.out.println("[DEBUG] fileIds가 비어 있음");
				}
				System.out.println("[DEBUG] 파일 저장 실패");
			}
			AdbannerService service = new AdbannerServiceImpl();
			service.registerBanner(banner);

			request.getRequestDispatcher("/brand2/adbannerComplete.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/brand2/adbannerForm.jsp?error=true");
		}
	}
}
