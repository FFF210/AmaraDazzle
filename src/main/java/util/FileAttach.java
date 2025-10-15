package util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import dto.UploadFile;
import service.UploadFileService;
import service.UploadFileServiceImpl;

public class FileAttach {

	String filenm = null;
	String fileRename = null;
	long filesize = 0;

	//multiple 파일 첨부 메소드
	public Map<String, Object> file_save(List<Part> parts, HttpServletRequest req) throws Exception {
		UploadFileService file_svc = new UploadFileServiceImpl();

//		String savePath = req.getServletContext().getInitParameter("UPLOAD_DIR");
		String savePath = req.getServletContext().getRealPath("/upload_file/");
		
		File uploadDir = new File(savePath);
		if (!uploadDir.exists()) { //해당 경로가 없을경우
			uploadDir.mkdirs(); // 폴더 생성
		}
		if (!uploadDir.exists() && !uploadDir.mkdirs()) { //저장경로가 없고 경로 생성에 실패한 경우 
			throw new IOException("업로드 폴더 생성 실패: " + savePath);
		}

		List<Long> fileIds = new ArrayList<>();
		int successCount = 0;

		for (Part p : parts) {
			// 파일 이름이 없거나(폼필드) 사이즈 0이면 스킵
			String originalName = p.getSubmittedFileName();
			if (originalName == null || p.getSize() <= 0)
				continue;

			// 새 이름 생성 
			String renamed = file_rename(originalName);
			long size = p.getSize();

			// 10MB 제한
			if (renamed != null && size <= 10 * 1024 * 1024) {
				//파일경로에 첨부파일 저장 
				p.write(savePath + File.separator + renamed);

				// DB에저장 
				UploadFile file_dto = new UploadFile();
				file_dto.setFileName(originalName);
				file_dto.setFileRename(renamed);
				file_dto.setStoragePath("/upload_file");

				int result = file_svc.save_file(file_dto);
				if (result > 0) {
					successCount++;//DB저장된 파일 개수 카운트 
					
					//DB저장된 파일의 pk가져오기 
					Long fileId = file_svc.select_fileId(renamed);
					if (fileId != null) fileIds.add(fileId); //가져왔으면 리스트에 추가 
				}
			}
		}

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("save_YN", successCount > 0 && successCount == fileIds.size()); //첨부한 파일 수와 저장된 파일 수가 일치할 경우 
		resultMap.put("fileIds", fileIds);

		return resultMap;
	}
	
	//단일 파일첨부 저장 메소드
	public Long file_saveOne(Part parts, HttpServletRequest req) throws Exception {
		UploadFile file_dto = null;
		UploadFileService file_svc = new UploadFileServiceImpl();

//		String savePath = req.getServletContext().getInitParameter("UPLOAD_DIR");
//		System.out.println("UPLOAD_DIR PATH = " + new File(savePath).getAbsolutePath());
		String savePath = req.getServletContext().getRealPath("/upload_file/");
		
		File uploadDir = new File(savePath);
		if (!uploadDir.exists()) { //해당 경로가 없을경우
			uploadDir.mkdirs(); // 폴더 생성
		}
		if (!uploadDir.exists() && !uploadDir.mkdirs()) { //저장경로가 없고 경로 생성에 실패한 경우 
			throw new IOException("업로드 폴더 생성 실패: " + savePath);
		}

		String originalName = parts.getSubmittedFileName();

		// 새 이름 생성 
		String renamed = file_rename(originalName); //원래파일명 리네임메소드에 전달 
		long size = parts.getSize();
		Long fileId = null;
		
		// 10MB 제한
		if (renamed != null && size <= 10 * 1024 * 1024) {
			//파일경로에 첨부파일 저장 
			parts.write(savePath + File.separator + renamed);

			// DB에저장 
			file_dto = new UploadFile();
			file_dto.setFileName(originalName);
			file_dto.setFileRename(renamed);
			file_dto.setStoragePath("/upload_file");

			int result = file_svc.save_file(file_dto);
			if (result > 0) {
				fileId = file_svc.select_fileId(renamed); //file pk 가져오기 
			}
		}
		
		return fileId;
	}

	// 파일 리네임 메소드
	public String file_rename(String filenm) {

		int sub = filenm.lastIndexOf(".");
		String ext = filenm.substring(sub); // 속성(파일확장자)

		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		String today = sf.format(date);

		int no = (int) Math.ceil(Math.random() * 1000);
		String makeFileRenm = today + "_" + no + ext;

		return makeFileRenm;
	}

	
	// 웹디렉토리 실제 파일 삭제
	public boolean file_delete(String fRename, HttpServletRequest req) {
		UploadFileService file_svc = new UploadFileServiceImpl();
		
//		String url = req.getServletContext().getInitParameter("UPLOAD_DIR");
		String url = req.getServletContext().getRealPath("/upload_file/");
		
		File file = new File(url + fRename);
		boolean result = false;
		
		//디렉토리에서 파일 삭제 
		if (file.exists()) { // 해당 파일이 있으면 삭제
			result = file.delete();
		} else { // 없으면 => 없어도 글 삭제
			result = true;
		}
		
		//db에서도 삭제 
		file_svc.deleteFile(fRename);
		
		return result;
	}

}
