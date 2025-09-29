package util;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
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
	
	public Map<String, Object> file_save(List<Part> parts, HttpServletRequest req) throws IOException {
		UploadFile f_dto = null;
		UploadFileService file_svc = new UploadFileServiceImpl();
		
		String savePath = req.getServletContext().getRealPath("/upload_file/"); //파일 저장 경로
//		System.out.println("savePath : " + savePath);
		
		File uploadDir = new File(savePath);
        if (!uploadDir.exists()) uploadDir.mkdirs();  //저장 폴더가 없으면 새로 생성하기
	
        int successCount = 0;
        Long file_id = null;
        List<Long> fileIds = new ArrayList<>();   // 저장된 파일들의 PK 모음
        Map<String, Object> resultMap = new HashMap<>(); //컨트롤러로 반환할 map
        
		try {
			for (Part p : parts) {
				if (p.getSubmittedFileName() != null && p.getSize() > 0) { //한번 더 확인 
			    	this.filenm = p.getSubmittedFileName();
			    	this.fileRename = this.file_rename(this.filenm);
					this.filesize = p.getSize();
					
					if(this.fileRename != null && this.filesize < 1024*1024*10) {
						//경로에 파일 저장 
						p.write(savePath + File.separator + this.fileRename);
						 
						//DTO에 파일정보 세팅
						f_dto = new UploadFile();
						f_dto.setFileName(this.filenm );
						f_dto.setFileRename(this.fileRename);
						f_dto.setStoragePath("/upload_file/");
						
						//DB에 파일 저장 
						int result = file_svc.save_file(f_dto);
						if(result > 0) {
							successCount++;
							file_id = file_svc.select_fileId(this.fileRename); //저장된 파일의 pk값 받아오기 
							fileIds.add(file_id); //해당 pk값들을 리스트에 저장 
						}
					}
				}
		    }
			
			boolean save_YN = (successCount > 0 && parts.size() == successCount); //DB에 저장된 파일 개수와 첨부한 파일 개수가 맞을 경우 true
			resultMap.put("save_YN", save_YN);
			resultMap.put("fileIds", fileIds);
			
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("파일첨부 실패 : " + e);
		}
		
		return resultMap;
	}

	// 파일 리네임 메소드
	public String file_rename(String filenm) {
		
		int sub = filenm.lastIndexOf(".");
		String ext = filenm.substring(sub); // 속성(파일확장자)

		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		String today = sf.format(date);

		int no = (int) Math.ceil(Math.random() * 1000);
		String makeFileRenm = today + no + ext;

		return makeFileRenm;
	}

	// 웹디렉토리 실제 파일 삭제
	public boolean file_delete(String filenm, HttpServletRequest req, String savePath) {
		String url = req.getServletContext().getRealPath(savePath);
		File file = new File(url + filenm);
		boolean result = false;
		if (file.exists()) { // 해당 파일이 있으면 삭제
			result = file.delete();
		} else { // 없으면 => 없어도 글 삭제
			result = true;
		}
		return result;
	}

}


