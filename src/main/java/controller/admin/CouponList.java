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

import dto.Coupon;
import service.admin.CouponService;
import service.admin.CouponServiceImpl;
import util.Paging;

@WebServlet("/admin/pCouponList")
public class CouponList extends HttpServlet {
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
			CouponService coupon_svc = new CouponServiceImpl();

			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String startDate2 = request.getParameter("exp_startDate");
			String endDate2 = request.getParameter("exp_endDate");
			String totalSearch = request.getParameter("totalSearch");
			String keyword = request.getParameter("keyword");
			
			// 검색 조건이 하나라도 있는지 확인
		    boolean hasCondition =
		        (startDate != null && !startDate.trim().isEmpty()) ||
		        (endDate != null && !endDate.trim().isEmpty()) ||
		        (startDate2 != null && !startDate2.trim().isEmpty()) ||
		        (endDate2 != null && !endDate2.trim().isEmpty()) ||
		        (totalSearch != null && !totalSearch.trim().isEmpty()) ||
		        (keyword != null && !keyword.trim().isEmpty());
		    
		    List<Coupon> pCouponAllList;
		    Integer pCouponCnt;
		    Map<String, Object> paging;
		    
			int postNo = m_pg.serial_no(p_no); // 게시물 일련번호 계산

			if (!hasCondition) {
		        // 검색조건이 전혀 없는 경우: 전체 목록
				pCouponCnt = coupon_svc.pCouponCnt(new HashMap<String, String>()); // 전체 카운트
		        paging = m_pg.page_ea(p_no, pCouponCnt); // 페이징Map
		        pCouponAllList = coupon_svc.pCouponAllList(p_no);
		        
		    } else {
		        // 검색조건이 하나라도 있는 경우: 검색 수행
		    	
		    	Map<String, String> searchContent = new HashMap<>();
				searchContent.put("startDate", startDate);
				searchContent.put("endDate", endDate);
				searchContent.put("startDate2", startDate2);
				searchContent.put("endDate2", endDate2);
				searchContent.put("totalSearch", totalSearch);
				searchContent.put("keyword", keyword);
				
				pCouponCnt = coupon_svc.pCouponCnt(searchContent);
		        paging = m_pg.page_ea(p_no, pCouponCnt);
		        pCouponAllList = coupon_svc.pCouponSearchList(searchContent, p_no);
		        
		        request.setAttribute("searchContent", searchContent); // 검색어 map
		    }
//			System.out.println("hasCondition=" + hasCondition + ", sellerNoticeCnt=" + sellerNoticeCnt);
			
			request.setAttribute("postNo", postNo); // 페이지번호 클릭시 나오는 게시글 일련번호
			request.setAttribute("paging", paging); // 페이징Map
			request.setAttribute("pCouponCnt", pCouponCnt); // 총 게시글 수
			request.setAttribute("pCouponList", pCouponAllList); // 총 게시물 리스트

			request.getRequestDispatcher("/admin/promotion_couponPubl.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}




}
