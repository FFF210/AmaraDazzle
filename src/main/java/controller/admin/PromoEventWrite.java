package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import util.FileAttach;

@WebServlet("/admin/promoEventWrite")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 메모리 저장 임계값 (2MB)
		maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크기 (10MB)
		maxRequestSize = 1024 * 1024 * 50 // 전체 요청 최대 크기 (50MB)
)
public class PromoEventWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/admin/promotion_event_write.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=UTF-8");

		PrintWriter pw = response.getWriter();

		try {
			String eventType = request.getParameter("eventType"); // 이벤트 종류
			Timestamp startDate = Timestamp.valueOf(request.getParameter("startDate") + " 00:00:00"); // 시작일
			Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate") + " 23:59:59"); // 마지막일
			String l_cate = request.getParameter("category1Id"); // 카테고리 - 대분류
			String m_cate = request.getParameter("category2Id"); // 카테고리 - 중분류
			String s_cate = request.getParameter("category3Id"); // 카테고리 - 소분류
			String eventName = request.getParameter("eventName"); // 이벤트명
			String evtContent = request.getParameter("evtContent"); // 게시물 내용
			Long eventWriter = Long.valueOf(request.getParameter("eventWriter")); // 등록한 관리자 코드

			Long cateIdx = null;
			if (s_cate != null && !s_cate.isEmpty()) {
				cateIdx = Long.parseLong(s_cate);
			} else if (m_cate != null && !m_cate.isEmpty()) {
				cateIdx = Long.parseLong(m_cate);
			} else if (l_cate != null && !l_cate.isEmpty()) {
				cateIdx = Long.parseLong(l_cate);
			}
			
			// 파일첨부파트 추출
			List<Part> fileParts = new ArrayList<>();
			for (Part part : request.getParts()) {
				if ("noticeFile".equals(part.getName()) && part.getSize() > 0) { // 전달된 Part중 name이 noticeFile 이면서 용량이 있는 Part가 있는지 확인
					fileParts.add(part);
				}
			}
			List<Long> fileIds = Collections.emptyList();
			if (!fileParts.isEmpty()) { // 파일첨부를 한 경우
				FileAttach fileAttach = new FileAttach(); // 파일첨부 클래스 소환
				Map<String, Object> result = fileAttach.file_save(fileParts, request);

				boolean saveYN = Boolean.TRUE.equals(result.get("save_YN"));
				List<Long> uploaded = (List<Long>) result.get("fileIds");

				if (saveYN && uploaded != null) {
					fileIds = uploaded; // 성공 시에만 세팅
				}
			}

			System.out.println("eventType : " + eventType);
			System.out.println("startDate : " + startDate);
			System.out.println("endDate : " + endDate);
			System.out.println("l_cate : " + l_cate);
			System.out.println("m_cate : " + m_cate);
			System.out.println("s_cate : " + s_cate);
			System.out.println("cateIdx : " + cateIdx);
			System.out.println("eventName : " + eventName);
			System.out.println("evtContent : " + evtContent);
			System.out.println("eventWriter : " + eventWriter);
			System.out.println("fileIds List : " + fileIds);
			

			

		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
