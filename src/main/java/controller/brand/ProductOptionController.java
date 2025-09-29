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

@WebServlet("/productOption")
public class ProductOptionController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ProductOptionService service = new ProductOptionServiceImpl();

	public ProductOptionController() {
		super();
	}

	/**
	 * 상품 옵션 관련 요청 처리 (POST)
	 * 
	 * 요청 파라미터: - action : "add" | "list"
	 * 
	 * 1) action = "add" - productId : 상품 ID - optionValue : 옵션명 (예: 01호, 100ml 등) -
	 * price : 옵션 가격 - stockQty : 옵션 재고 수량
	 * 
	 * → DB에 옵션 등록 → {"result":"success"} 반환
	 * 
	 * 2) action = "list" - productId : 상품 ID
	 * 
	 * → 해당 상품의 옵션 목록 조회 → JSON 배열 반환
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		String action = request.getParameter("action");

		try {
			// 옵션 등록
			if ("add".equals(action)) {
				Long productId = Long.parseLong(request.getParameter("productId"));
				String optionValue = request.getParameter("optionValue");
				String priceStr = request.getParameter("price");
				String stockStr = request.getParameter("stockQty");

				// DTO 생성
				ProductOption option = new ProductOption();
				option.setProductId(productId);
				option.setOptionValue(optionValue);
				option.setPrice(new java.math.BigDecimal(priceStr));
				option.setStockQty(Integer.parseInt(stockStr));

				service.addOption(option);
				response.getWriter().write("{\"result\":\"success\"}");

				// 옵션 목록 조회
			} else if ("list".equals(action)) {
				String productId = request.getParameter("productId");
				List<ProductOption> options = service.getOptions(productId);

				// JSON 직렬화
				String json = new com.google.gson.Gson().toJson(options);
				response.getWriter().write(json);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
