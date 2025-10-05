package controller.brand2;

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
import service.brand2.UploadFileService;
import service.brand2.UploadFileServiceImpl;

/**
 * Servlet implementation class BrandImage
 */
@WebServlet("/brand2/image")
public class BrandImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BrandImage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		 
		UploadFileService uploadFileService = new UploadFileServiceImpl();
		
		String fileIdStr = request.getParameter("uploadFileId");
        if (fileIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "fileId is required");
            return;
        }

        try {
            Long uploadFileId = Long.parseLong(fileIdStr);
            UploadFile uploadFile = uploadFileService.getFileById(uploadFileId); // DB 조회

            if (uploadFile == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
                return;
            }

            // 실제 저장 경로 (예: /upload/xxx.png)
            String path = request.getServletContext().getRealPath(uploadFile.getStoragePath());
            File file = new File(path);

            if (!file.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found on disk");
                return;
            }

            // MIME 타입 설정
            String mimeType = getServletContext().getMimeType(file.getName());
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            response.setContentType(mimeType);

            // 파일 스트리밍
            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream out = response.getOutputStream()) {
                byte[] buff = new byte[4096];
                int len;
                while ((len = fis.read(buff)) > 0) {
                    out.write(buff, 0, len);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing file");
        }
		
		/* ============== upload_file_name 기준 ==============
		String filename=request.getParameter("fileName");
		String path = request.getServletContext().getRealPath("upload");

		try {
			FileInputStream fis = new FileInputStream(new File(path, filename));
			OutputStream out = response.getOutputStream();
			byte[] buff = new byte[4096];
			int len;
			while((len=fis.read(buff))>0) {
				out.write(buff,0,len);
			}
			fis.close();
		} catch(Exception e) {
			e.printStackTrace();
		}  ============== upload_file_name 기준 ==============
		*/
		
		
	}

}
