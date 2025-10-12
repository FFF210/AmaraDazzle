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

import dao.consumer.WishlistDAO;
import dao.consumer.WishlistDAOImpl;
import dto.Brand;
import dto.Product;
import service.consumer.BrandService;
import service.consumer.BrandServiceImpl;
import service.consumer.CartItemService;
import service.consumer.CartItemServiceImpl;
import service.consumer.MemberCouponService;
import service.consumer.MemberCouponServiceImpl;
import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;
import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;
import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;
import service.consumer.WishlistService;
import service.consumer.WishlistServiceImpl;
import util.PriceCalculator;

@WebServlet("/store/mypage")
public class Mypage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Mypage() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		Long memberId = (Long) session.getAttribute("memberId");

		// 로그인 체크
		if (memberId == null) {
			response.sendRedirect(request.getContextPath() + "/store/login");
			return;
		}

		try {
			// 서비스
			OrderService orderService = new OrderServiceImpl();
			MemberService memberService = new MemberServiceImpl();
			MemberCouponService couponService = new MemberCouponServiceImpl();
			WishlistService wishlistService = new WishlistServiceImpl();
			CartItemService service = new CartItemServiceImpl();
			ProductService productService = new ProductServiceImpl();
			BrandService brandService = new BrandServiceImpl();

			// userInfo용
			Map<String, Object> memberInfo = memberService.getHeaderInfo(memberId);
			int couponCount = couponService.getAvailableCouponCount(memberId);
			
			// 주문 통계 정보 가져오기
			Map<String, Object> summary = orderService.getOrderSummaryByMember(memberId);
			
			// 좋아요
			List<Map<String, Object>> wishlist = wishlistService.getWishlistByMemberId(memberId);
			
			// 장바구니
			List<Map<String, Object>> cartItems = service.getCartItems(memberId);
			
			// 6개씩만 보여주기
			List<Map<String, Object>> wishlistLimited = wishlist.size() > 6 
			    ? wishlist.subList(0, 6) 
			    : wishlist;

			List<Map<String, Object>> cartItemsLimited = cartItems.size() > 6 
			    ? cartItems.subList(0, 6) 
			    : cartItems;

			// 장바구니 상품 정보
			WishlistDAO wishlistDAO = new WishlistDAOImpl();
			for (Map<String, Object> item : cartItems) {
				// 상품 상세 조회
			    Long productId = (Long) item.get("productId");
			    Product product = productService.getProductDetail(productId);
			    Brand brand = brandService.selectBrandByBrandId(product.getBrandId());
			    
				// 찜 여부
				Map<String, Object> params = new HashMap<>();
				params.put("memberId", memberId);
				params.put("productId", productId);
				boolean isWished = wishlistDAO.existsWishlist(params) > 0;
				
				// 세일 정보
				Map<String, Object> saleInfo = PriceCalculator.calculateSaleInfo(product);
				
			    item.put("isWished", isWished ? 1 : 0);
			    item.put("finalPrice", saleInfo.get("finalPrice"));
			    item.put("saleRate", saleInfo.get("saleRate"));
			    item.put("name", product.getName());
			    item.put("brandName", brand.getBrandName());
			}
			
			// 위시리스트 상품 정보
			for (Map<String, Object> item : wishlist) {
				// 상품 정보
				Long productId = (Long) item.get("productId");
			    Product product = productService.getProductDetail(productId);
			    Brand brand = brandService.selectBrandByBrandId(product.getBrandId());
				
				// 세일 정보
				Map<String, Object> saleInfo = PriceCalculator.calculateSaleInfo(product);

				item.put("isWished", 1);
			    item.put("finalPrice", saleInfo.get("finalPrice"));
			    item.put("saleRate", saleInfo.get("saleRate"));
			    item.put("name", product.getName());
			    item.put("brandName", brand.getBrandName());
			}

			request.setAttribute("memberInfo", memberInfo);
			request.setAttribute("couponCount", couponCount);
			request.setAttribute("orderSummary", summary);
			request.setAttribute("cartItems", cartItemsLimited);
			request.setAttribute("wishlist", wishlistLimited);

			// 마이페이지로 포워드
			request.getRequestDispatcher("/consumer/mypage.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "마이페이지 조회 오류: " + e.getMessage());
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}
}