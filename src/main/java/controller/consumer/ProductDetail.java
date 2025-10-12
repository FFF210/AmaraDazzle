package controller.consumer;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
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

	private static final int REVIEW_PAGE_SIZE = 10;
	private static final int QNA_PAGE_SIZE = 10;

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

			// ✅ 페이지 파라미터 받기
			String reviewPageStr = request.getParameter("reviewPage");
			String qnaPageStr = request.getParameter("qnaPage");

			int reviewPage = 1;
			int qnaPage = 1;

			try {
				if (reviewPageStr != null && !reviewPageStr.trim().isEmpty()) {
					reviewPage = Integer.parseInt(reviewPageStr);
					if (reviewPage < 1)
						reviewPage = 1;
				}
			} catch (NumberFormatException e) {
				reviewPage = 1;
			}

			try {
				if (qnaPageStr != null && !qnaPageStr.trim().isEmpty()) {
					qnaPage = Integer.parseInt(qnaPageStr);
					if (qnaPage < 1)
						qnaPage = 1;
				}
			} catch (NumberFormatException e) {
				qnaPage = 1;
			}

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

			// 세일 계산 로직
			boolean isSale = false;
			BigDecimal finalPrice = product.getPrice(); // 기본값은 원가
			BigDecimal saleRate = BigDecimal.ZERO;

			// 세일 여부 체크
			if (product.getDiscountType() != null && product.getDiscountValue() != null) {
				Date now = new Date();
				Date startDate = product.getStartDate();
				Date endDate = product.getEndDate();

				// 시작일이 없거나 현재가 시작일 이후 && 종료일이 없거나 현재가 종료일 이전
				boolean isInPeriod = (startDate == null || !now.before(startDate))
						&& (endDate == null || !now.after(endDate));

				if (isInPeriod) {
					isSale = true;

					// 할인가 계산
					if ("RATE".equals(product.getDiscountType())) {
						// 정율 할인 (예: 10% 할인)
						saleRate = product.getDiscountValue();
						finalPrice = product.getPrice()
								.multiply(BigDecimal.ONE
										.subtract(product.getDiscountValue().divide(new BigDecimal("100"))))
								.setScale(0, RoundingMode.HALF_UP);
					} else if ("AMOUNT".equals(product.getDiscountType())) {
						// 정액 할인 (예: 5,000원 할인)
						BigDecimal discountAmount = product.getDiscountValue();
						finalPrice = product.getPrice().subtract(discountAmount);
						// 할인율 계산 (정액 할인도 %로 표시하기 위해)
						saleRate = discountAmount.divide(product.getPrice(), 4, RoundingMode.HALF_UP)
								.multiply(new BigDecimal("100")).setScale(0, RoundingMode.HALF_UP);
					}
				}
			}

			boolean isExclusive = (product.getIsExclusive() != null && product.getIsExclusive() == 1);
			boolean isPlanned = (product.getIsPlanned() != null && product.getIsPlanned() == 1);

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
			// 리뷰 조회 (페이지네이션)
			List<Map<String, Object>> reviews = reviewService.getReviewsByProductIdWithPaging(
					product.getProductId(), reviewPage, REVIEW_PAGE_SIZE
				);
			Map<String, Object> reviewSummary = reviewService.getReviewSummary(product.getProductId());
			int reviewTotalCount = reviewService.getReviewCount(product.getProductId());
			int reviewTotalPages = (int) Math.ceil((double) reviewTotalCount / REVIEW_PAGE_SIZE);

			// QnA 조회 (페이지네이션)
			List<Qna> qnas = qnaService.getQnasByProductIdWithPaging(product.getProductId(), qnaPage, QNA_PAGE_SIZE);
			Integer qnaCount = qnaService.getQnaCount(product.getProductId());
			int qnaTotalPages = (int) Math.ceil((double) qnaCount / QNA_PAGE_SIZE);
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
			request.setAttribute("isSale", isSale); // 세일 여부
			request.setAttribute("finalPrice", finalPrice); // 최종가
			request.setAttribute("saleRate", saleRate); // 할인율
			request.setAttribute("isExclusive", isExclusive); // 독점 여부
			request.setAttribute("isPlanned", isPlanned); // 기획 여부
			request.setAttribute("brand", brand);
			request.setAttribute("category1", category1);
			request.setAttribute("category2", category2);
			request.setAttribute("category3", category3);
			request.setAttribute("productOptions", productOptions);

			// 리뷰 페이지네이션 데이터
			request.setAttribute("reviews", reviews);
			request.setAttribute("reviewSummary", reviewSummary);
			request.setAttribute("reviewCurrentPage", reviewPage);
			request.setAttribute("reviewTotalPages", reviewTotalPages);
			request.setAttribute("reviewTotalCount", reviewTotalCount);

			// QnA 페이지네이션 데이터
			request.setAttribute("qnas", qnas);
			request.setAttribute("qnaCount", qnaCount);
			request.setAttribute("qnaCurrentPage", qnaPage);
			request.setAttribute("qnaTotalPages", qnaTotalPages);
			
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
