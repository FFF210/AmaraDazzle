package controller.brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.brand.ProductDetail;
import service.brand.ProductService;
import service.brand.ProductServiceImpl;

/**
 * Servlet implementation class ProductDetail
 */
@WebServlet("/brand/productDetail")
public class ProductForm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ProductService service = new ProductServiceImpl();

	public ProductForm() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * 상품 상세 정보 조회 (GET)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String productIdParam = request.getParameter("productId");

		if (productIdParam != null && !productIdParam.isEmpty()) {
			long productId = Long.parseLong(productIdParam);
			try {
				ProductDetail product = service.productDetail(productId);
				request.setAttribute("product", product);
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("err", "상품 상세 조회 오류");
			}
		}

		// param 없는 경우 → 상품 등록 페이지로
		request.getRequestDispatcher("/brand/productDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
