package controller.brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.brand.BrandService;
import service.brand.BrandServiceImpl;

/**
 * Servlet implementation class CheckDuplicate
 */
@WebServlet("/checkDuplicate")
public class CheckDuplicate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final BrandService service = new BrandServiceImpl();

	public CheckDuplicate() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		String field = request.getParameter("field"); // email, brn, brandName
		String value = request.getParameter("value");

		boolean exists = false;

		try {
			switch (field) {
			case "email":
				exists = service.existsByEmail(value);
				break;
			case "brn":
				exists = service.existsByBrn(value);
				break;
			case "brandName":
				exists = service.existsByBrandName(value);
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		String json = "{\"exists\":" + exists + "}";
		response.getWriter().write(json);
	}
}
