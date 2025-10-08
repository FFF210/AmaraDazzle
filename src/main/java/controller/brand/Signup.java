package controller.brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Brand;
import service.brand.BrandService;
import service.brand.BrandServiceImpl;

/**
 * Servlet implementation class Signup
 */
@WebServlet("/brand/signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final BrandService service = new BrandServiceImpl();

	public Signup() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/brand/signup.jsp").forward(request, response);
	}

	/**
	 * 브랜드 회원가입 (POST)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		Brand brand = new Brand();
		brand.setEmail(request.getParameter("email"));
		brand.setPassword(request.getParameter("password"));
		brand.setBrn(request.getParameter("brn"));
		brand.setBrandName(request.getParameter("brandName"));
		brand.setManagerName(request.getParameter("managerName"));
		brand.setPhone(request.getParameter("phone"));

		try {
			service.registerBrand(brand);

			// 세션에 brandId 저장
			request.getSession().setAttribute("brand", brand);
			request.getSession().setAttribute("brandId", brand.getBrandId());

			request.getRequestDispatcher("/brand/brandApply.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
