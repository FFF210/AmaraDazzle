package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.UploadFile;
import service.UploadFileService;
import service.UploadFileServiceImpl;

/**
 * ImageView 서블릿
 *
 * 클라이언트에서 /image?fileId=xxx 요청이 들어오면 - DB에서 해당 fileId의 파일 메타정보를 조회하고 - web.xml의
 * UPLOAD_DIR에서 실제 파일을 찾아 - 브라우저로 전송한다.
 *
 * 사용 예시: <img src="/image?fileId=123" />
 */
@WebServlet("/image")
public class ImageView extends HttpServlet {

	private final UploadFileService service = new UploadFileServiceImpl();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		// 1. 요청 파라미터(fileId) 확인
		String fileIdParam = request.getParameter("fileId");
		if (fileIdParam == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "fileId required");
			return;
		}

		Long fileId = Long.parseLong(fileIdParam);
		UploadFile filex = null;

		try {
			// 2. DB에서 파일 메타정보 조회
			filex = service.selectFileById(fileId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (filex == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "file not in DB");
			return;
		}

		// 3. 실제 저장된 파일 절대 경로 확인
		// web.xml의 UPLOAD_DIR을 읽음
		String uploadDirPath = request.getServletContext().getInitParameter("UPLOAD_DIR");

		// DB에 저장된 파일명
		String renamed = filex.getFileRename();

		// 파일 객체 생성
		File file = new File(uploadDirPath, renamed);

		if (!file.exists() || !file.isFile()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "file not found on disk");
			return;
		}

		// 4. MIME 타입 설정 (없으면 기본 application/octet-stream)
		String mime = getServletContext().getMimeType(file.getName());
		if (mime == null)
			mime = "application/octet-stream";

		response.setContentType(mime);
		response.setHeader("Content-Length", String.valueOf(file.length()));

		// 5. 파일을 스트림으로 클라이언트에게 전송
		try (FileInputStream fis = new FileInputStream(file); OutputStream out = response.getOutputStream()) {
			byte[] buf = new byte[8192];
			int len;
			while ((len = fis.read(buf)) != -1) {
				out.write(buf, 0, len);
			}
		}
	}
}
