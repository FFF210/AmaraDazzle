package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.consumer.BrandFollowService;
import service.consumer.BrandFollowServiceImpl;
import service.consumer.BrandService;
import service.consumer.BrandServiceImpl;

/**
 * Servlet implementation class BrandFollowToggle
 */
@WebServlet("/store/brandFollowToggle")
public class BrandFollowToggle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private BrandFollowService service = new BrandFollowServiceImpl();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BrandFollowToggle() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json; charset=UTF-8");

		Long memberId = (Long) request.getSession().getAttribute("memberId");

		// 로그인 여부 체크
		if (memberId == null) {
			response.getWriter().write("{\"success\":false, \"requireLogin\":true}");
			return;
		}

		Long brandId = Long.valueOf(request.getParameter("brandId"));

		try {
			boolean isFollowing = service.toggleBrandFollow(memberId, brandId);
			response.getWriter().write("{\"success\":true, \"isFollowing\":" + isFollowing + "}");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("{\"success\":false, \"message\":\"서버 오류\"}");
		}
	}

	/**
	 * 브랜드 찜하기 토글 (POST)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json; charset=UTF-8");

		Long memberId = (Long) request.getSession().getAttribute("memberId");

		// 로그인 여부 체크
		if (memberId == null) {
			response.getWriter().write("{\"success\":false, \"requireLogin\":true}");
			return;
		}

		String brandIdParam = request.getParameter("brandId");
		if (brandIdParam == null || brandIdParam.isEmpty()) {
			response.getWriter().write("{\"success\":false, \"message\":\"브랜드 ID가 필요합니다\"}");
			return;
		}

		try {
			Long brandId = Long.valueOf(brandIdParam);
			boolean isFollowing = service.toggleBrandFollow(memberId, brandId);

			// 팔로워 수도 함께 반환 (선택사항)
			BrandService brandService = new BrandServiceImpl();
			int followerCount = brandService.countBrandFollowers(brandId);

			response.getWriter().write(
					"{\"success\":true, \"isFollowing\":" + isFollowing + ", \"followerCount\":" + followerCount + "}");
		} catch (NumberFormatException e) {
			response.getWriter().write("{\"success\":false, \"message\":\"잘못된 브랜드 ID\"}");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("{\"success\":false, \"message\":\"서버 오류\"}");
		}
	}

}
