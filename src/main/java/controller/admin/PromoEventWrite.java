package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dto.Event;
import service.admin.BannerService;
import service.admin.BannerServiceImpl;
import service.admin.EventService;
import service.admin.EventServiceImpl;
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
			String[] fileNames = {"eventThumbImg", "eventDetailImg"};
			FileAttach fileAttach = new FileAttach();
			Map<String, Long> filePkMap = new HashMap<>();
			for (String name : fileNames) {
			    Part part = request.getPart(name);
			    if (part != null && part.getSize() > 0) {
			        Long pk = fileAttach.file_saveOne(part, request);
			        filePkMap.put(name, pk);
			    }
			}
			
			Long thumbPk = filePkMap.get("eventThumbImg");
			Long detailPk = filePkMap.get("eventDetailImg");

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
			System.out.println("thumbPk : " + thumbPk);
			System.out.println("detailPk : " + detailPk);
			
			Event event = new Event(eventType, startDate, endDate, eventName, filePkMap.get("eventThumbImg"), filePkMap.get("eventDetailImg"), cateIdx, evtContent, eventWriter);
			EventService event_svc = new EventServiceImpl();
			
			int result = event_svc.adminEventWrite(event); 
			if(result > 0 ) {
				pw.print("{\"status\":\"ok\",\"title\":\"이벤트 등록 완료\",\"message\":\"등록 후 게시 상태를 변경해야 메뉴에 올라갑니다.\"}");
				
			}else {
				pw.print("{\"status\":\"fail\",\"title\":\"이벤트 등록 실패\",\"message\":\"시스템 문제로 이벤트 등록에 실패했습니다.\"}");
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "시스템 오류로 공지 작성에 실패했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
