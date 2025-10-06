package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Banner;
import service.admin.BannerService;
import service.admin.BannerServiceImpl;



@WebServlet("/admin/promoBannerDetail")
public class PromoBannerDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;



	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		try {
			String num = request.getParameter("num"); 
			BannerService banner_svc = new BannerServiceImpl();
			
			Banner banner_DTO = null;
			banner_DTO = banner_svc.bannerDetail(Integer.parseInt(num));
			
			request.setAttribute("banner", banner_DTO);
			request.getRequestDispatcher("promotion_banner_detail.jsp").forward(request, response);

		} catch (Exception e) {
			
			e.printStackTrace();
			
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}






}
