package controller.brand2;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import util.MailSenderInlineOne;

@WebServlet("/sendMail")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10MB 제한
public class SendMailServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/brand2/mailForm.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 일반 폼 데이터
		String templateType = request.getParameter("templateType");
		String target = request.getParameter("target");
		String subject = "[브랜드 알림] " + templateType + " 안내";
		String bodyText = "안녕하세요, 고객님!\n\n" + templateType + " 관련 소식을 알려드립니다.";

		// 업로드된 파일 받기
		Part filePart = request.getPart("fileInput1");
		File uploadedFile = null;

		if (filePart != null && filePart.getSize() > 0) {
			String fileName = filePart.getSubmittedFileName();
			String uploadDir = getServletContext().getRealPath("/upload");
			File uploadPath = new File(uploadDir);
			if (!uploadPath.exists())
				uploadPath.mkdirs();

			uploadedFile = new File(uploadPath, fileName);
			filePart.write(uploadedFile.getAbsolutePath());
		}

		// 메일 발송
		try {
			if (uploadedFile != null) {
				MailSenderInlineOne.sendMailWithInlineImage("gyeongeh@gmail.com", // 테스트용 수신자
						subject, bodyText, uploadedFile);
			} else {
				throw new Exception("이미지 파일이 업로드되지 않았습니다.");
			}

			response.setContentType("text/plain; charset=UTF-8");
			response.getWriter().write("메일 발송 성공!");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("메일 발송 실패: " + e.getMessage());
		}
	}
}
