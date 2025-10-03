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

			request.setAttribute("brand", brand);
			request.setAttribute("followerCount", followerCount);
			request.setAttribute("isFollowing", isFollowing);
			request.setAttribute("products", products);

			request.getRequestDispatcher("/consumer/brandDetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "브랜드 조회 오류");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}

	}

}
