package controller.brand;

import java.io.IOException;
import java.math.BigDecimal;

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
	 * 상품 등록 / 수정 (POST)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getServletPath(); // "/brand/productDetail"

		// JSP에서 form action에 따라 분기 "/register" 또는 "/update"
		String pathInfo = request.getPathInfo();

		try {
			if ("/register".equals(pathInfo)) {
				// 신규 등록
				ProductDetail product = extractProductFromRequest(request);
				service.registerProduct(product);

				response.sendRedirect(request.getContextPath() + "/brand/productList");
			} else if ("/update".equals(pathInfo)) {
				// 수정
				ProductDetail product = extractProductFromRequest(request);
				service.updateProduct(product);

				response.sendRedirect(
						request.getContextPath() + "/brand/productDetail?productId=" + product.getProductId());
			} else {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 요청입니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "상품 저장 오류");
			request.getRequestDispatcher("/brand/productDetail.jsp").forward(request, response);
		}
	}

	/**
	 * request → ProductDetail DTO 변환
	 */
	private ProductDetail extractProductFromRequest(HttpServletRequest request) {
		ProductDetail product = new ProductDetail();

		// 상품 ID (수정 시만 존재)
		String productId = request.getParameter("productId");
		if (productId != null && !productId.isEmpty()) {
			product.setProductId(Long.parseLong(productId));
		}

		product.setName(request.getParameter("name"));

		// 단독/공개/기획 여부 (0,1 값으로 변환)
		product.setIsExclusive("Y".equals(request.getParameter("exclusive")) ? 1 : 0);
		product.setIsVisible("Y".equals(request.getParameter("visible")) ? 1 : 0);
		product.setIsPlanned("special".equals(request.getParameter("productType")) ? 1 : 0);

		// 카테고리
		product.setCategory1Id(parseLongSafe(request.getParameter("category1Id")));
		product.setCategory2Id(parseLongSafe(request.getParameter("category2Id")));
		product.setCategory3Id(parseLongSafe(request.getParameter("category3Id")));

		// 전성분
		product.setIngredients(request.getParameter("ingredients"));

		// 가격 관련
		product.setPrice(parseBigDecimalSafe(request.getParameter("price")));
		product.setSalePrice(parseBigDecimalSafe(request.getParameter("salePrice")));
		product.setOrderLimit(parseIntSafe(request.getParameter("orderLimit")));

		// 재고
		product.setStockQty(parseIntSafe(request.getParameter("stockQty")));

		// 배송 방법
		product.setShippingMethod(request.getParameter("shipping"));

		// 할인
		product.setDiscountType(request.getParameter("discountType"));

		// 필터
		product.setSkinIssues(request.getParameter("skinIssues"));
		product.setSkinTypes(request.getParameter("skinTypes"));
		product.setPersonalColors(request.getParameter("personalColors"));

		// 옵션 여부 (hidden 값이 있으면 1, 없으면 0)
		String optionValues = request.getParameter("optionValues");
		product.setHasOption((optionValues != null && !optionValues.isEmpty()) ? 1 : 0);

		return product;
	}

	/**
	 * 안전 파싱 유틸
	 */
	private Long parseLongSafe(String val) {
		try {
			return (val != null && !val.isEmpty()) ? Long.parseLong(val) : null;
		} catch (Exception e) {
			return null;
		}
	}

	private Integer parseIntSafe(String val) {
		try {
			return (val != null && !val.isEmpty()) ? Integer.parseInt(val) : null;
		} catch (Exception e) {
			return null;
		}
	}

	private BigDecimal parseBigDecimalSafe(String val) {
		try {
			return (val != null && !val.isEmpty()) ? new BigDecimal(val) : null;
		} catch (Exception e) {
			return null;
		}
	}
}
