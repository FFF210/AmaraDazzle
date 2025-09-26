//package util;
//
//import java.io.File;
//import java.io.IOException;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.Part;
//
//import dto.UploadFile;
//
//public class fileAttach {
//	
//	UploadFile upload_file = null;
//
//	long filesize = 0; // 파일용량 가져옴
//	String filenm = null;
//	String file_rnm = null;
//	String url = null;
//
//	public String file_attach(file_DTO f_dto, MultipartFile thumbImg, HttpServletRequest req, String savePath) throws IOException {
//
//		this.file_rnm = this.file_rename(thumbImg.getOriginalFilename()); // 원래파일명 리네임메소드에 전달
//
//		upload_file.setFileRename(this.file_rnm); // 새로 붙인 파일명 dto에 저장
//		upload_file.setFilenm(thumbImg.getOriginalFilename()); // 원래파일명 dto에 저장
//
//		String filePath = req.getServletContext().getRealPath(savePath);
//		System.out.println(filePath);
//
//		File dir = new File(filePath);
//		if (!dir.exists()) { // 해당 경로가 없을경우
//			dir.mkdirs(); // 폴더 생성
//		}
//
//		FileCopyUtils.copy(thumbImg.getBytes(), new File(filePath + this.file_rnm)); // 웹디렉톨에 리네임한 파일명으로 저장
//		f_dto.setImgPath(savePath + this.file_rnm); // 웹디렉토리 경로+리네임 파일명 dto에 저장
//
//		return f_dto;
//	}
//
//	// 파일 리네임 메소드
//	public String file_rename(String filenm) {
//		// 속성(파일확장자)
//		int sub = filenm.lastIndexOf(".");
//		String ext = filenm.substring(sub);
//
//		Date date = new Date();
//		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
//		String today = sf.format(date);
//
//		int no = (int) Math.ceil(Math.random() * 1000);
//		String makeFileRenm = today + no + ext;
//
//		return makeFileRenm;
//	}
//
//	// 웹디렉토리 실제 파일 삭제
//	public boolean file_delete(String filenm, HttpServletRequest req, String savePath) {
//		String url = req.getServletContext().getRealPath(savePath);
//		File file = new File(url + filenm);
//		boolean result = false;
//		if (file.exists()) { // 해당 파일이 있으면 삭제
//			result = file.delete();
//		} else { // 없으면 => 없어도 글 삭제
//			result = true;
//		}
//		return result;
//	}
//
//}
