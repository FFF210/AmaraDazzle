package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Brand;
import service.admin.BrandService;
import service.admin.BrandServiceImpl;



@WebServlet("/admin/userSellerDetail")
public class UserSellerDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		try {
			String num = request.getParameter("num"); 
			BrandService brand_svc = new BrandServiceImpl();
			
			Brand brand = brand_svc.selectBrandDetail(Integer.parseInt(num));
			
			request.setAttribute("brand", brand);
			request.getRequestDispatcher("users_seller_detail.jsp").forward(request, response);

		} catch (Exception e) {
			
			e.printStackTrace();
			
			request.setAttribute("err", "오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}






}
