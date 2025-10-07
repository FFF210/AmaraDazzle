package controller.brand;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dto.Brand;
import dto.UploadFile;
import service.UploadFileService;
import service.UploadFileServiceImpl;
import service.brand.BrandService;
import service.brand.BrandServiceImpl;

/**
 * Servlet implementation class BrandEdit
 */
@WebServlet("/brand/brandEdit")
@MultipartConfig( // multipart/form-data 처리를 위한 설정
		fileSizeThreshold = 1024 * 1024, // 1MB 이상이면 디스크에 임시 저장
		maxFileSize = 1024 * 1024 * 10, // 파일 하나 최대 10MB
		maxRequestSize = 1024 * 1024 * 50 // 요청 전체 최대 50MB
)
public class BrandEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final BrandService brandService = new BrandServiceImpl();
	private final UploadFileService uploadFileService = new UploadFileServiceImpl();

	public BrandEdit() {
		super();
	}

	/**
	 * 브랜드 정보 조회 (GET)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		// 세션 없거나 브랜드 정보 없음 → 로그인 페이지로 리다이렉트
		if (session == null || session.getAttribute("brand") == null) {
			response.sendRedirect(request.getContextPath() + "/brand/login");
			return;
		}

		Brand brand = (Brand) session.getAttribute("brand");
		Long brandId = brand.getBrandId();

		try {
			Brand brandDetail = brandService.getBrandInfo(brandId);

			// JSP에 전달
			request.setAttribute("brandDetail", brandDetail);
			request.getRequestDispatcher("/brand/brandEdit.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 수정된 정보 업데이트 (POST)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("brand") == null) {
			response.sendRedirect(request.getContextPath() + "/brand/login");
			return;
		}

		Brand brand = (Brand) session.getAttribute("brand");
		Long brandId = brand.getBrandId();

		try {
			// 브랜드 정보 담기
			Brand newBrand = new Brand();
			newBrand.setBrandId(brandId);

			// 로고 업로드
			Part logoPart = request.getPart("upload1");
			if (logoPart != null && logoPart.getSize() > 0) { // 업로드된 경우만 세팅
				Long logoFileId = saveFile(logoPart, request);
				newBrand.setLogoFileId(logoFileId);
			}

			// 대표이미지 업로드
			Part heroPart = request.getPart("upload2");
			if (heroPart != null && heroPart.getSize() > 0) { // 업로드된 경우만 세팅
				Long heroFileId = saveFile(heroPart, request);
				newBrand.setHeroFileId(heroFileId);
			}

			// 텍스트 입력 파라미터
			newBrand.setIntro(getParam(request, "intro"));
			newBrand.setBank(getParam(request, "bank"));
			newBrand.setAccountNumber(getParam(request, "accountNumber"));
			newBrand.setAccountHolder(getParam(request, "accountHolder"));
			newBrand.setSettlementDate(getParam(request, "settlementDate"));

			// DB 저장
			brandService.editBrandInfo(newBrand);

			// 완료 페이지 이동
			response.sendRedirect(request.getContextPath() + "/brand/todoDashboard?updated=true");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * multipart/form-data 에서 파라미터 꺼내는 유틸
	 */
	private String getParam(HttpServletRequest request, String name) throws IOException, ServletException {
		Part part = request.getPart(name);
		if (part == null)
			return null;

		try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"))) {
			return reader.lines().collect(Collectors.joining("\n"));
		}
	}

	/**
	 * 파일 저장 및 DB 기록 후 fileId 반환
	 */
	private Long saveFile(Part part, HttpServletRequest request) throws Exception {
		if (part == null || part.getSize() == 0)
			return null;

		// 저장 경로
		String savePath = request.getServletContext().getRealPath("/upload");
		File uploadDir = new File(savePath);
		if (!uploadDir.exists())
			uploadDir.mkdirs();

		// 원본 파일명
		String originalName = part.getSubmittedFileName();

		// 확장자 추출
		String ext = "";
		int dot = originalName.lastIndexOf(".");
		if (dot > -1)
			ext = originalName.substring(dot);

		// 리네임 파일명 (시간 + 랜덤)
		String renamed = System.currentTimeMillis() + "_" + (int) (Math.random() * 1000) + ext;

		// 실제 저장
		part.write(savePath + File.separator + renamed);

		// DB 저장
		UploadFile fileDto = new UploadFile();
		fileDto.setFileName(originalName);
		fileDto.setFileRename(renamed);
		fileDto.setStoragePath("/upload");

		uploadFileService.save_file(fileDto);

		Long fileId = uploadFileService.select_fileId(renamed); // FK로 넣을 upload_file_id 반환

		return fileId;
	}

}
