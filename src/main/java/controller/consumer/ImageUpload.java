package controller.consumer;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dto.UploadFile;
import service.UploadFileService;
import service.UploadFileServiceImpl;

/**
 * 이미지 업로드 처리 서블릿
 * 
 * AJAX 요청으로 이미지 파일을 받아서:
 * 1. 서버 디스크에 저장
 * 2. DB(upload_file 테이블)에 메타정보 저장
 * 3. JSON 형태로 fileId 반환
 * 
 * 사용처: 교환신청, 1:1문의 등에서 이미지 첨부 시
 */
@WebServlet("/store/imageUpload")
@MultipartConfig(
	    maxFileSize = 1024 * 1024 * 5,      // 파일당 최대 5MB
	    maxRequestSize = 1024 * 1024 * 10   // 전체 요청 최대 10MB
	)
public class ImageUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageUpload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
	        response.setContentType("application/json; charset=utf-8");
	        
	        try {
	            // 1. 업로드된 파일 가져오기
	            Part filePart = request.getPart("file");
	            
	            if (filePart == null || filePart.getSize() == 0) {
	                response.getWriter().write("{\"success\":false,\"message\":\"파일이 없습니다\"}");
	                return;
	            }
	            
	            // 2. 원본 파일명 추출
	            String originalFileName = getFileName(filePart);
	            
	            // 3. 이미지 파일인지 검증
	            if (!isImageFile(originalFileName)) {
	                response.getWriter().write("{\"success\":false,\"message\":\"이미지 파일만 업로드 가능합니다\"}");
	                return;
	            }
	            
	            // 4. 확장자 추출
	            String extension = "";
	            int lastDot = originalFileName.lastIndexOf('.');
	            if (lastDot > 0) {
	                extension = originalFileName.substring(lastDot);
	            }
	            
	            // 5. 리네임 파일명 생성
	            String renamedFileName = System.currentTimeMillis() + "_" + 
	                                    (int)(Math.random() * 10000) + extension;
	            
	            // 6. 저장 경로 설정
	            String storagePath = "/upload";
	            String uploadPath = request.getServletContext().getRealPath(storagePath);
	            
	            // 7. 디렉토리 생성
	            File uploadDir = new File(uploadPath);
	            if (!uploadDir.exists()) {
	                uploadDir.mkdirs();
	            }
	            
	            // 8. 파일 저장
	            File saveFile = new File(uploadPath, renamedFileName);
	            filePart.write(saveFile.getAbsolutePath());
	            
	            // 9. DB에 파일 정보 저장
	            UploadFile uploadFile = new UploadFile();
	            uploadFile.setFileName(originalFileName);
	            uploadFile.setFileRename(renamedFileName);
	            uploadFile.setStoragePath(storagePath);
	            
	            // ✅ 기존 Service 사용 (새로 추가한 메서드)
	            UploadFileService service = new UploadFileServiceImpl();
	            Long fileId = service.insertFile(uploadFile);
	            
	            // 10. JSON 응답
	            response.getWriter().write(
	                "{\"success\":true," +
	                "\"fileId\":" + fileId + "," +
	                "\"fileName\":\"" + originalFileName + "\"}"
	            );
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().write(
	                "{\"success\":false,\"message\":\"" + e.getMessage() + "\"}"
	            );
	        }
	    }
	    
	    private String getFileName(Part part) {
	        String contentDisposition = part.getHeader("content-disposition");
	        String[] tokens = contentDisposition.split(";");
	        
	        for (String token : tokens) {
	            if (token.trim().startsWith("filename")) {
	                return token.substring(token.indexOf('=') + 1)
	                           .trim()
	                           .replace("\"", "");
	            }
	        }
	        return "unknown";
	    }
	    
	    private boolean isImageFile(String fileName) {
	        String lowerFileName = fileName.toLowerCase();
	        return lowerFileName.endsWith(".jpg") || 
	               lowerFileName.endsWith(".jpeg") || 
	               lowerFileName.endsWith(".png") || 
	               lowerFileName.endsWith(".gif") || 
	               lowerFileName.endsWith(".bmp") || 
	               lowerFileName.endsWith(".webp");
	    }
	}

