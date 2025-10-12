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

import dao.consumer.BrandFollowDAO;
import dao.consumer.BrandFollowDAOImpl;
import dao.consumer.WishlistDAO;
import dao.consumer.WishlistDAOImpl;
import dto.Brand;
import service.consumer.BrandService;
import service.consumer.BrandServiceImpl;
import service.consumer.CouponService;
import service.consumer.CouponServiceImpl;
import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;

/**
 * Servlet implementation class BrandDetail
 */
@WebServlet("/store/brandDetail")
public class BrandDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
			HttpSession session = request.getSession();
			Long memberId = (Long) session.getAttribute("memberId");

			BrandService brandService = new BrandServiceImpl();
			ProductService productService = new ProductServiceImpl();
			CouponService couponService = new CouponServiceImpl();

			// 1. 브랜드 정보
			Brand brand = brandService.selectBrandByBrandId(brandId);

			// 2. 팔로워 수
			int followerCount = brandService.countBrandFollowers(brandId);

			// 3. 팔로우 여부
			boolean isFollowing = false;
			if (memberId != null) {
				BrandFollowDAO brandFollowDAO = new BrandFollowDAOImpl();
				Map<String, Object> params = new HashMap<>();
				params.put("memberId", memberId);
				params.put("brandId", brandId);
				isFollowing = brandFollowDAO.existsBrandFollow(params) > 0;
			}

			// 4. 브랜드 상품 목록
			List<Map<String, Object>> products = productService.getProductsByBrandId(brandId);

			// 5. 각 상품의 찜 여부 확인 (추가)
			if (memberId != null) {
				WishlistDAO wishlistDAO = new WishlistDAOImpl();
				for (Map<String, Object> product : products) {
					Map<String, Object> params = new HashMap<>();
					params.put("memberId", memberId);
					params.put("productId", product.get("productId"));

					boolean isWished = wishlistDAO.existsWishlist(params) > 0;
					product.put("isWished", isWished); // 맵에 추가
				}
			}

			Map<String, Object> couponParams = new HashMap<>();
			couponParams.put("memberId", memberId);
			couponParams.put("brandId", brandId);

			// 6. 브랜드 쿠폰 목록
			List<dto.consumer.CouponList> couponList = couponService.getCounponListForBrand(couponParams);

			request.setAttribute("brand", brand);
			request.setAttribute("couponList", couponList);
			request.setAttribute("followerCount", followerCount);
			request.setAttribute("isFollowing", isFollowing);
			request.setAttribute("products", products);

			request.getRequestDispatcher("/consumer/brandDetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			
			// 응답이 이미 커밋되었는지 확인
	        if (!response.isCommitted()) {
	            request.setAttribute("err", "브랜드 조회 오류: " + e.getMessage());
	            request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
	        } else {
	            // 이미 커밋된 경우 로그만 남기고 종료
	            System.err.println("응답이 이미 커밋되어 에러 페이지로 이동할 수 없습니다: " + e.getMessage());
	        }
		}
	}

}
