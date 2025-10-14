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

import dto.Brand;
import service.consumer.BrandFollowService;
import service.consumer.BrandFollowServiceImpl;
import service.consumer.BrandService;
import service.consumer.BrandServiceImpl;
import service.consumer.CouponService;
import service.consumer.CouponServiceImpl;
import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;
import service.consumer.WishlistService;
import service.consumer.WishlistServiceImpl;

/**
 * Servlet implementation class BrandDetail
 */
@WebServlet("/store/brandDetail")
public class BrandDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int PAGE_SIZE = 16;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BrandDetail() {
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
			Long brandId = Long.parseLong(request.getParameter("brandId"));
			String category1IdStr = request.getParameter("category1Id");
			Long category1Id = (category1IdStr != null && !category1IdStr.isEmpty()) ? Long.parseLong(category1IdStr)
					: null;

			int currentPage = 1;
			String pageStr = request.getParameter("page");
			if (pageStr != null && !pageStr.isEmpty()) {
				currentPage = Integer.parseInt(pageStr);
			}

			HttpSession session = request.getSession();
			Long memberId = (Long) session.getAttribute("memberId");

			// === Service 객체 모두 생성 (맨 위에서 한 번에!) ===
			BrandService brandService = new BrandServiceImpl();
			BrandFollowService brandFollowService = new BrandFollowServiceImpl();
			ProductService productService = new ProductServiceImpl();
			WishlistService wishlistService = new WishlistServiceImpl();
			CouponService couponService = new CouponServiceImpl();

			// === 1. 브랜드 정보 ===
			Brand brand = brandService.selectBrandByBrandId(brandId);

			// === 2. 팔로워 수 ===
			int followerCount = brandService.countBrandFollowers(brandId);

			// === 3. 팔로우 여부 (로그인한 경우만) ===
			boolean isFollowing = false;
			if (memberId != null) {
				isFollowing = brandFollowService.isBrandFollowed(memberId, brandId);
			}

			// === 4. 상품 개수 조회 ===
			Map<String, Object> countParams = new HashMap<>();
			countParams.put("brandId", brandId);
			if (category1Id != null) {
				countParams.put("category1Id", category1Id);
			}
			int totalProducts = productService.countProductsByBrand(countParams);
			int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

			// === 5. 상품 목록 조회 ===
			Map<String, Object> productParams = new HashMap<>();
			productParams.put("brandId", brandId);
			if (category1Id != null) {
				productParams.put("category1Id", category1Id);
			}
			productParams.put("offset", (currentPage - 1) * PAGE_SIZE);
			productParams.put("limit", PAGE_SIZE);

			List<dto.consumer.BrandDetail> products = productService.getProductsByBrandId(productParams);

			// === 6. 각 상품의 찜 여부 확인 (로그인한 경우만) ===
//			if (memberId != null) {
//				for (dto.consumer.BrandDetail product : products) {
//					Long productId = (Long) product.get("productId");
//					boolean isWished = wishlistService.isProductWished(memberId, productId);
//					product.put("isWished", isWished);
//				}
//			}

			// === 7. 브랜드 쿠폰 목록 ===
			Map<String, Object> couponParams = new HashMap<>();
			couponParams.put("memberId", memberId);
			couponParams.put("brandId", brandId);
			List<dto.consumer.CouponList> couponList = couponService.getCounponListForBrand(couponParams);

			// === 8. QueryString 생성 ===
			StringBuilder queryString = new StringBuilder("brandId=" + brandId);
			if (category1Id != null) {
				queryString.append("&category1Id=").append(category1Id);
			}
			
			// === 9. 브랜드 이벤트 목록 ===
			List<Map<String, Object>> eventList = brandService.getEventsByBrandId(brandId);

			// === Request에 데이터 설정 ===
			request.setAttribute("brand", brand);
			request.setAttribute("couponList", couponList);
			request.setAttribute("followerCount", followerCount);
			request.setAttribute("isFollowing", isFollowing);
			request.setAttribute("products", products);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("totalPages", totalPages);
			request.setAttribute("queryString", queryString.toString());
			request.setAttribute("eventList", eventList);

			System.out.print(products);

			request.getRequestDispatcher("/consumer/brandDetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();

			if (!response.isCommitted()) {
				request.setAttribute("err", "브랜드 조회 오류: " + e.getMessage());
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
			} else {
				System.err.println("응답이 이미 커밋되어 에러 페이지로 이동할 수 없습니다: " + e.getMessage());
			}
		}
	}

}
