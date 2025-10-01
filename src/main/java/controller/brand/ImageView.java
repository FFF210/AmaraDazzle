package controller.brand;

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

@WebServlet("/brand/image")
public class ImageView extends HttpServlet {

	private final UploadFileService service = new UploadFileServiceImpl();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		String fileIdParam = request.getParameter("fileId");
		if (fileIdParam == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "fileId required");
			return;
		}

		Long fileId = Long.parseLong(fileIdParam);
		UploadFile filex = null;

		try {
			filex = service.selectFileById(fileId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (filex == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "file not in DB");
			return;
		}

		// 실제 저장된 이름과 경로 사용
		String storagePath = filex.getStoragePath(); // 예: "/upload"
		String renamed = filex.getFileRename(); // 예: "1728401123_123.png"

		String uploadPath = request.getServletContext().getRealPath(storagePath);
		File file = new File(uploadPath, renamed);

		if (!file.exists() || !file.isFile()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "file not found on disk");
			return;
		}

		// MIME 타입
		String mime = getServletContext().getMimeType(file.getName());
		if (mime == null)
			mime = "application/octet-stream";

		response.setContentType(mime);
		response.setHeader("Content-Length", String.valueOf(file.length()));

		try (FileInputStream fis = new FileInputStream(file); OutputStream out = response.getOutputStream()) {
			byte[] buf = new byte[8192];
			int len;
			while ((len = fis.read(buf)) != -1) {
				out.write(buf, 0, len);
			}
		}
	}
}
