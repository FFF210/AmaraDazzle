package controller.brand2;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Banner;
import service.brand2.AdbannerService;
import service.brand2.AdbannerServiceImpl;

@WebServlet("/brand2/adbannerDetail")
public class AdbannerDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final AdbannerService service = new AdbannerServiceImpl();
       
    public AdbannerDetail() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");  // 상세 or 취소 버튼
		Long bannerId = Long.parseLong(request.getParameter("bannerId")); // 배너 id 받기
		
		
		try {
			
			if("cancel".equals(action)) {
				
				// ============= 취소 버튼 =============
				
				Map<String, Object> params = new HashMap<>();
				params.put("bannerId", Long.parseLong(request.getParameter("bannerId")));
				params.put("status", "CANCELED");

				service.cancelBanner(params);
			    response.sendRedirect(request.getContextPath() + "/brand2/adbannerList");
			    return;
				
				// ============= 취소 버튼 =============
				
				
			}
			
			// ============= 상세보기 버튼 =============
			
			Banner detail = service.getBannerById(bannerId); // 상세보기 버튼
			
			// 결제 여부 조회
			boolean paid = service.isBannerPaid(bannerId);
			
			// JSP로 전달
			request.setAttribute("banner", detail);
			request.setAttribute("paid", paid);
			
			request.getRequestDispatcher("/brand2/adbannerFormDetail.jsp").forward(request, response);
			
			// ============= 상세보기 버튼 =============
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}

		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
