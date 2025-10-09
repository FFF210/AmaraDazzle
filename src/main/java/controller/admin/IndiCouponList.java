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

@WebServlet("/admin/iCouponList")
public class IndiCouponList extends HttpServlet {
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
		    
		    List<Coupon> iCouponAllList;
		    Integer iCouponCnt;
		    Map<String, Object> paging;
		    
			int postNo = m_pg.serial_no(p_no); // 게시물 일련번호 계산

			if (!hasCondition) {
		        // 검색조건이 전혀 없는 경우: 전체 목록
				iCouponCnt = coupon_svc.iCouponCnt(new HashMap<String, String>()); // 전체 카운트
		        paging = m_pg.page_ea(p_no, iCouponCnt); // 페이징Map
		        iCouponAllList = coupon_svc.iCouponAllList(p_no);
		        
		    } else {
		        // 검색조건이 하나라도 있는 경우: 검색 수행
		    	
		    	Map<String, String> searchContent = new HashMap<>();
				searchContent.put("startDate", startDate);
				searchContent.put("endDate", endDate);
				searchContent.put("startDate2", startDate2);
				searchContent.put("endDate2", endDate2);
				searchContent.put("totalSearch", totalSearch);
				searchContent.put("keyword", keyword);
				
				iCouponCnt = coupon_svc.iCouponCnt(searchContent);
		        paging = m_pg.page_ea(p_no, iCouponCnt);
		        iCouponAllList = coupon_svc.iCouponSearchList(searchContent, p_no);
		        
		        request.setAttribute("searchContent", searchContent); // 검색어 map
		    }
			
			request.setAttribute("postNo", postNo); // 페이지번호 클릭시 나오는 게시글 일련번호
			request.setAttribute("paging", paging); // 페이징Map
			request.setAttribute("iCouponCnt", iCouponCnt); // 총 게시글 수
			request.setAttribute("iCouponList", iCouponAllList); // 총 게시물 리스트
			
			request.getRequestDispatcher("/admin/promotion_couponIndi.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}




}
