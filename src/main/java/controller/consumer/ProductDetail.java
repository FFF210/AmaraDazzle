package controller.consumer;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.consumer.ProductOptionService;
import dao.consumer.ProductOptionServiceImpl;
import dao.consumer.WishlistDAO;
import dao.consumer.WishlistDAOImpl;
import dto.Brand;
import dto.Category;
import dto.Product;
import dto.ProductOption;
import dto.Qna;
import dto.Review;
import service.consumer.BrandService;
import service.consumer.BrandServiceImpl;
import service.consumer.CategoryService;
import service.consumer.CategoryServiceImpl;
import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;
import service.consumer.QnaService;
import service.consumer.QnaServiceImpl;
import service.consumer.ReviewService;
import service.consumer.ReviewServiceImpl;

/**
 * Servlet implementation class ProductDetail
 */
@WebServlet("/store/productDetail")
public class ProductDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductDetail() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// 파라미터 받기
			String productIdStr = request.getParameter("productId");

			if (productIdStr == null || productIdStr.trim().isEmpty()) {
				response.sendRedirect(request.getContextPath() + "consumer/error.jsp");
				return;
			}

			Long productId = Long.parseLong(productIdStr);

			// 세션에서 memberId 가져오기
			HttpSession session = request.getSession();
			Long memberId = (Long) session.getAttribute("memberId");

			// Service 생성 (상품, 상품옵션, 브랜드, 카테고리, 리뷰, qna)
			ProductService productService = new ProductServiceImpl();
			ProductOptionService productOptionService = new ProductOptionServiceImpl();
			BrandService brandService = new BrandServiceImpl();
			CategoryService categoryService = new CategoryServiceImpl();
			ReviewService reviewService = new ReviewServiceImpl();
			QnaService qnaService = new QnaServiceImpl();

			// 상품 정보 조회
			Product product = productService.getProductDetail(productId);
			// 상품 옵션 조회
			List<ProductOption> productOptions = productOptionService
					.getProductOptionsByProductId(product.getProductId());
			// 브랜드 정보 조회
			Brand brand = brandService.selectBrandByBrandId(product.getBrandId());
			// 카테고리 정보 조회
			Category category1 = categoryService.selectCategoryByCategoryId(product.getCategory1Id());
			Category category2 = categoryService.selectCategoryByCategoryId(product.getCategory2Id());
			Category category3 = null;
			if (product.getCategory3Id() != null) {
			    category3 = categoryService.selectCategoryByCategoryId(product.getCategory3Id());
			}
			// 리뷰 조회
			List<Review> reviews = reviewService.getReviewsByProductId(product.getProductId());
			Map<String, Object> reviewSummary = reviewService.getReviewSummary(product.getProductId());
			// QnA 조회
			List<Qna> qnas = qnaService.getQnasByProductId(product.getProductId());
			Integer qnaCount = qnaService.getQnaCount(product.getProductId());

			// 위시리스트 찜 여부 조회
			boolean isWished = false;
			if (memberId != null) {
				WishlistDAO wishlistDAO = new WishlistDAOImpl();
				Map<String, Object> params = new HashMap<>();
				params.put("memberId", memberId);
				params.put("productId", productId);

				isWished = wishlistDAO.existsWishlist(params) > 0;
			}

			// JSP로 데이터 전달
			request.setAttribute("product", product);
			request.setAttribute("brand", brand);
			request.setAttribute("category1", category1);
			request.setAttribute("category2", category2);
			request.setAttribute("category3", category3);
			request.setAttribute("productOptions", productOptions);
			request.setAttribute("reviews", reviews);
			request.setAttribute("reviewSummary", reviewSummary);
			request.setAttribute("qnas", qnas);
			request.setAttribute("qnaCount", qnaCount);
			request.setAttribute("isWished", isWished);

			// JSP로 포워딩
			request.getRequestDispatcher("/consumer/productDetail.jsp").forward(request, response);

		} catch (NumberFormatException e) {
			// 숫자 형식 오류
			response.sendRedirect(request.getContextPath() + "/consumer/error.jsp");
		} catch (Exception e) {
			// 기타 오류
			e.printStackTrace();
			request.setAttribute("err", "상품 조회 오류");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}
}
