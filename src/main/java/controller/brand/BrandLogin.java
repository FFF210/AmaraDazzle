package controller.brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Brand;
import dto.brand.LoginResult;
import service.brand.BrandService;
import service.brand.BrandServiceImpl;

/**
 * Servlet implementation class BrandLogin
 */
@WebServlet("/brand/login")
public class BrandLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final BrandService service = new BrandServiceImpl();

	public BrandLogin() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/brand/login.jsp").forward(request, response);
	}

	/**
	 * 브랜드 로그인 (POST)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String email = request.getParameter("email");
		String password = request.getParameter("password").trim();
		String autoLogin = request.getParameter("autoLogin");

		try {
			LoginResult result = service.loginBrand(email, password);

			if (!result.isSuccess()) {
				request.setAttribute("field", result.getErrorField());
				request.setAttribute("fieldError", result.getErrorMessage());
				request.setAttribute("email", email);
				request.getRequestDispatcher("/brand/login.jsp").forward(request, response);
				return;
			}

			if (result.isSuccess()) {
				Brand brand = result.getBrand();

				// 로그인 성공 → 세션 저장
				HttpSession session = request.getSession();
				session.setAttribute("brand", brand);

				// 쿠키 설정
				Cookie cookie1 = null;
				Cookie cookie2 = null;
				Cookie cookie3 = null;

				if (autoLogin == null || autoLogin.equals("")) {
					cookie1 = new Cookie("autoLogin", "");
					cookie1.setMaxAge(0);
					cookie2 = new Cookie("email", "");
					cookie2.setMaxAge(0);
					cookie3 = new Cookie("password", "");
					cookie3.setMaxAge(0);
				} else {
					cookie1 = new Cookie("autoLogin", autoLogin);
					cookie2 = new Cookie("email", email);
					cookie3 = new Cookie("password", password);

					cookie1.setMaxAge(600);
					cookie2.setMaxAge(600);
					cookie3.setMaxAge(600);
				}

				response.addCookie(cookie1);
				response.addCookie(cookie2);
				response.addCookie(cookie3);

				response.sendRedirect("/brand/productList");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("toastMsg", "로그인 처리 중 오류가 발생했습니다.");
		}
	}

}
