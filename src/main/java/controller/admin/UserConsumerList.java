package controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.admin.BrandService;
import service.admin.BrandServiceImpl;
import service.admin.ConsumerService;
import service.admin.ConsumerServiceImpl;
import util.Paging;

@WebServlet("/admin/consumerList")
public class UserConsumerList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		try {
			String pageno = request.getParameter("page"); // 클릭한 페이지번호
			Integer p_no = 1; // 기본 페이지번호 = 1
			if (pageno != null) {
				p_no = Integer.parseInt(pageno);
			}

			Paging m_pg = new Paging();
			ConsumerService member_svc = new ConsumerServiceImpl();
			BrandService brand_svc = new BrandServiceImpl();
			
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String memberGrade = request.getParameter("memberGrade");
			String totalSearch = request.getParameter("totalSearch");
			String keyword = request.getParameter("keyword");

			System.out.println("startDate : " + startDate);
			System.out.println("endDate : " + endDate);
			System.out.println("memberGrade : " + memberGrade);
			System.out.println("totalSearch : " + totalSearch);
			System.out.println("keyword : " + keyword);

			// 검색 조건이 하나라도 있는지 확인
			boolean hasCondition = (startDate != null && !startDate.trim().isEmpty())
					|| (endDate != null && !endDate.trim().isEmpty())
					|| (memberGrade != null && !memberGrade.trim().isEmpty())
					|| (totalSearch != null && !totalSearch.trim().isEmpty())
					|| (keyword != null && !keyword.trim().isEmpty());

			List<Member> memberAllList;
			Integer memberCnt;
			Map<String, Object> paging;

			int postNo = m_pg.serial_no(p_no); // 게시물 일련번호 계산

			if (hasCondition) {
				// 검색조건이 하나라도 있는 경우: 검색 수행
				Map<String, String> searchContent = new HashMap<>();
				searchContent.put("startDate", startDate);
				searchContent.put("endDate", endDate);
				searchContent.put("middleFilter", memberGrade);
				searchContent.put("totalSearch", totalSearch);
				searchContent.put("keyword", keyword);

				memberCnt = member_svc.memberCnt(searchContent); // 검색 후 카운트
				paging = m_pg.page_ea(p_no, memberCnt);
				memberAllList = member_svc.memberSearchList(searchContent, p_no);

				if (memberCnt == null) memberCnt = 0;

				request.setAttribute("searched", "searched");
				request.setAttribute("searchContent", searchContent); // 검색어 map
				request.setAttribute("message", "검색된 회원이 없습니다.");
				
			}else {
				memberCnt = 0;
			    paging = m_pg.page_ea(p_no, memberCnt);
			    memberAllList = null;
				
				request.setAttribute("message", "검색 후 리스트 확인 가능합니다");
			}

			Integer memberAllCnt = member_svc.memberCnt(new HashMap<String, String>()); // 전체 카운트;
			request.setAttribute("memberAllCnt", memberAllCnt); // 총 회원 수
			
			Integer sellerAllCnt = brand_svc.brandAllCnt(new HashMap<String, String>()); // 전체 카운트;
			request.setAttribute("sellerAllCnt", sellerAllCnt); // 총 브랜드 수 
			
			request.setAttribute("postNo", postNo); // 페이지번호 클릭시 나오는 게시글 일련번호
			request.setAttribute("paging", paging); // 페이징Map
			request.setAttribute("memberCnt", memberCnt); // 총 게시글 수
			request.setAttribute("memberList", memberAllList); // 총 게시물 리스트
			

			request.getRequestDispatcher("/admin/users_consumer.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
