package controller.brand2;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;

import dao.brand2.UploadFileDAO;
import util.MybatisSqlSessionFactory;

/**
 * Servlet implementation class UploadFile
 */
@WebServlet("/uploadFile")
public class UploadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UploadFile() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@WebServlet("/file/upload")
	@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, // 10MB
			maxRequestSize = 1024 * 1024 * 50 // 50MB
	)
	public class FileUploadController extends HttpServlet {

		@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {

			request.setCharacterEncoding("UTF-8");
			response.setContentType("application/json; charset=UTF-8");

			try {
				Part filePart = request.getPart("uploadFile"); // input name="uploadFile"
				String originalFileName = filePart.getSubmittedFileName();

				// 업로드 경로 설정
				String uploadPath = request.getServletContext().getRealPath("/brand2/uploads");
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists())
					uploadDir.mkdirs();

				// 리네임 파일명 (UUID + 확장자)
				String fileRename = UUID.randomUUID().toString() + "_" + originalFileName;
				String filePath = uploadPath + File.separator + fileRename;

				// 서버에 저장
				filePart.write(filePath);

				// DTO 생성
				UploadFile uploadFile = new UploadFile();
//				uploadFile.setFileName(originalFileName);
//				uploadFile.setFileRename(fileRename);
//				uploadFile.setStoragePath("/brand2/uploads/" + fileRename);
//				uploadFile.setCreatedAt(new Timestamp(System.currentTimeMillis()));

				// DB 저장 (MyBatis)
				try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
					UploadFileDAO dao = sqlSession.getMapper(UploadFileDAO.class);
//					dao.insertUploadFile(uploadFile);
					sqlSession.commit();
				}

				// 업로드 결과 응답
				JSONObject result = new JSONObject();
				result.put("status", "success");
				result.put("fileName", originalFileName);
				result.put("fileRename", fileRename);
				result.put("storagePath", "/brand2/uploads/" + fileRename);

				response.getWriter().print(result.toJSONString());

			} catch (Exception e) {
				e.printStackTrace();
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

				JSONObject err = new JSONObject();
				err.put("status", "fail");
				err.put("message", "파일 업로드 실패");
				response.getWriter().print(err.toJSONString());
			}
		}
	}
}