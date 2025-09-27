package controller.brand;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ProductOption;
import service.brand.ProductOptionService;
import service.brand.ProductOptionServiceImpl;

/**
 * Servlet implementation class ProductOptionController
 */
@WebServlet("/productOption")
public class ProductOptionController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ProductOptionService service = new ProductOptionServiceImpl();

	public ProductOptionController() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		String action = request.getParameter("action");

		try {
			if ("add".equals(action)) {
				String productId = request.getParameter("productId");
				String optionValue = request.getParameter("optionValue");
				String priceStr = request.getParameter("price");
				String stockStr = request.getParameter("stockQty");

				ProductOption option = new ProductOption();
				option.setProductId(productId);
				option.setOptionValue(optionValue);
				option.setPrice(new java.math.BigDecimal(priceStr));
				option.setStockQty(Integer.parseInt(stockStr));

				service.addOption(option);
				response.getWriter().write("{\"result\":\"success\"}");
			} else if ("list".equals(action)) {
				String productId = request.getParameter("productId");
				List<ProductOption> options = service.getOptions(productId);

				String json = new com.google.gson.Gson().toJson(options);
				response.getWriter().write(json);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
