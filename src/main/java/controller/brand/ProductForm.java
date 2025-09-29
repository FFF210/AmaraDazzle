package controller.brand;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dto.ProductOption;
import dto.brand.ProductDetail;
import service.brand.ProductFilterMapService;
import service.brand.ProductFilterMapServiceImpl;
import service.brand.ProductOptionService;
import service.brand.ProductOptionServiceImpl;
import service.brand.ProductService;
import service.brand.ProductServiceImpl;

/**
 * Servlet implementation class ProductDetail
 */
@WebServlet("/brand/productDetail/*")
@MultipartConfig( // multipart/form-data 처리를 위한 설정
		fileSizeThreshold = 1024 * 1024, // 1MB 이상이면 디스크에 임시 저장
		maxFileSize = 1024 * 1024 * 10, // 파일 하나 최대 10MB
		maxRequestSize = 1024 * 1024 * 50 // 요청 전체 최대 50MB
)
public class ProductForm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final ProductService service = new ProductServiceImpl();
	private final ProductOptionService optionService = new ProductOptionServiceImpl();
	private final ProductFilterMapService filterMapService = new ProductFilterMapServiceImpl();

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

		// JSP에서 form action에 따라 분기 "/register" 또는 "/update"
		String pathInfo = request.getPathInfo();

		try {
			// 상품 신규 등록
			if ("/register".equals(pathInfo)) {
				ProductDetail product = extractProductFromRequest(request);

				// product 테이블에 저장
				service.registerProduct(product);

				// product_option 테이블에 저장
				String optionValues = getParam(request, "optionValues");
				if (optionValues != null && !optionValues.isEmpty()) {
					for (String optStr : optionValues.split(",")) {
						String[] parts = optStr.split("/");
						if (parts.length == 3) {
							String optionName = parts[0];
							BigDecimal optionPrice = new BigDecimal(parts[1]); // 문자열 → BigDecimal 변환
							Integer optionStock = Integer.parseInt(parts[2]); // 문자열 → Integer 변환

							ProductOption po = new ProductOption(product.getProductId(), optionName, optionPrice,
									optionStock);

							optionService.addOption(po);
						}
					}
				}

				// product_filter_map 테이블에 저장
				saveFilters(service, product);

				response.sendRedirect(request.getContextPath() + "/brand/productList");
			} else if ("/update".equals(pathInfo)) { // 상품 수정
				ProductDetail product = extractProductFromRequest(request);

				// product 테이블 업데이트
				service.updateProduct(product);
				Long productId = product.getProductId();

				// product_option 테이블 업데이트 (기존 → 삭제, 신규 → 등록)
				optionService.deleteOption(productId); // 기존 옵션 삭제

				String optionValues = getParam(request, "optionValues");
				if (optionValues != null && !optionValues.isEmpty()) {
					for (String optStr : optionValues.split(",")) {
						String[] parts = optStr.split("/");
						if (parts.length == 3) {
							String optionName = parts[0];
							BigDecimal optionPrice = new BigDecimal(parts[1]);
							Integer optionStock = Integer.parseInt(parts[2]);

							ProductOption po = new ProductOption(productId, optionName, optionPrice, optionStock);
							optionService.addOption(po);
						}
					}
				}

				// product_filter_map 테이블 업데이트 (기존 → 삭제, 신규 → 등록)
				filterMapService.deleteProductFilters(productId); // 기존 매핑 삭제
				saveFilters(service, product);

				response.sendRedirect(request.getContextPath() + "/brand/productList");
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
	 * 상품-필터 저장
	 * 
	 * @throws Exception
	 * @throws NumberFormatException
	 */
	private void saveFilters(ProductService service, ProductDetail product) throws Exception {
		if (product.getSkinIssues() != null) {
			for (String code : product.getSkinIssues().split(",")) {
				if (code != null && !code.trim().isEmpty()) {
					filterMapService.insertProductFilter(product.getProductId(), Long.parseLong(code.trim()));
				}
			}
		}
		if (product.getSkinTypes() != null) {
			for (String code : product.getSkinTypes().split(",")) {
				if (code != null && !code.trim().isEmpty()) {
					filterMapService.insertProductFilter(product.getProductId(), Long.parseLong(code.trim()));
				}
			}
		}
		if (product.getPersonalColors() != null) {
			for (String code : product.getPersonalColors().split(",")) {
				if (code != null && !code.trim().isEmpty()) {
					filterMapService.insertProductFilter(product.getProductId(), Long.parseLong(code.trim()));
				}
			}
		}
	}

	/**
	 * multipart/form-data 에서 파라미터 꺼내는 유틸
	 */
	private String getParam(HttpServletRequest request, String name) throws IOException, ServletException {
		Part part = request.getPart(name);
		if (part == null)
			return null;

		try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"))) {
			return reader.lines().collect(Collectors.joining("\n"));
		}
	}

	/**
	 * request → ProductDetail DTO 변환
	 */
	private ProductDetail extractProductFromRequest(HttpServletRequest request) throws IOException, ServletException {
		ProductDetail product = new ProductDetail();

//		Long brandId = (Long) request.getSession().getAttribute("brandId");
		Long brandId = (long) 1;
		product.setBrandId(brandId);

		// 상품ID
		String productId = getParam(request, "productId");
		if (productId != null && !productId.isEmpty()) {
			product.setProductId(Long.parseLong(productId));
		}

		// 기본 정보
		product.setName(getParam(request, "name"));
		product.setIsExclusive("Y".equals(getParam(request, "exclusive")) ? 1 : 0);
		product.setIsVisible("Y".equals(getParam(request, "visible")) ? 1 : 0);
		product.setIsPlanned("plan".equals(getParam(request, "productType")) ? 1 : 0);

		// 카테고리
		product.setCategory1Id(parseLongSafe(getParam(request, "category1Id")));
		product.setCategory2Id(parseLongSafe(getParam(request, "category2Id")));
		product.setCategory3Id(parseLongSafe(getParam(request, "category3Id")));

		// 성분
		product.setIngredients(getParam(request, "ingredients"));

		// 가격 & 수량
		product.setPrice(parseBigDecimalSafe(getParam(request, "price")));
		product.setSalePrice(parseBigDecimalSafe(getParam(request, "salePrice")));
		product.setOrderLimit(parseIntSafe(getParam(request, "orderLimit")));
		product.setStockQty(parseIntSafe(getParam(request, "stockQty")));

		// 배송
		product.setShippingMethod(getParam(request, "shipping"));

		// 필터
		product.setSkinIssues(getParam(request, "skinIssues"));
		product.setSkinTypes(getParam(request, "skinTypes"));
		product.setPersonalColors(getParam(request, "personalColors"));

		// 할인
		product.setDiscountType(getParam(request, "discountType"));

		// 옵션 여부
		String optionValues = getParam(request, "optionValues");
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
