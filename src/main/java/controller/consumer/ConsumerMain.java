package controller.consumer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Banner;
import dto.consumer.MemberFilter;
import dto.consumer.MembershipBrand;
import service.consumer.BannerService;
import service.consumer.BannerServiceImpl;
import service.consumer.BrandService;
import service.consumer.BrandServiceImpl;
import service.consumer.EventService;
import service.consumer.EventServiceImpl;
import service.consumer.MemberService;
import service.consumer.MemberServiceImpl;
import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;

/**
 * Servlet implementation class ConsumerMain
 */
@WebServlet("/store/main")
public class ConsumerMain extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ProductService service = new ProductServiceImpl();
	private BannerService bannerService = new BannerServiceImpl();
	private EventService eventService = new EventServiceImpl();
	private BrandService brandService = new BrandServiceImpl();
	private MemberService memberService = new MemberServiceImpl();

	public ConsumerMain() {
		super();
	}

	/**
	 * 메인 상품 조회 (GET)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		try {
			HttpSession session = request.getSession(false);
			Long memberId = null;
			if (session != null && session.getAttribute("memberId") != null) {
				memberId = (Long) session.getAttribute("memberId");

				// 개인 맞춤 필터링 조회
				MemberFilter memberFilter = memberService.getMemberFilters(memberId);
				List<Long> filterIds = new ArrayList<>();

				if (memberFilter.getSkinTypeId() != null) {
					filterIds.add(memberFilter.getSkinTypeId());
				}
				if (memberFilter.getPersonalColorId() != null) {
					filterIds.add(memberFilter.getPersonalColorId());
				}
				if (memberFilter.getSkinIssueIds() != null && !memberFilter.getSkinIssueIds().isEmpty()) {
					filterIds.addAll(memberFilter.getSkinIssueIds());
				}

				request.setAttribute("filterIds", filterIds);
			}

			Map<String, Object> params = new HashMap<>();
			params.put("memberId", memberId);

			Map<String, Object> products = service.productMainList(params);

			// 배너 조회
			List<Banner> bannerList = bannerService.getBannerList();

			// 이벤트 조회
			Map<String, Object> params2 = new HashMap<>();
			params2.put("limit", 3);
			params2.put("offset", 0);
			Map<String, Object> events = eventService.eventListByPage(params2);

			// 브랜드 조회
			List<MembershipBrand> brandList = brandService.getActiveMembershipBrands(4);

			// JSP로 전달
			request.setAttribute("productMyFitList", products.get("productMyFitList"));
			request.setAttribute("productPopularList", products.get("productPopularList"));
			request.setAttribute("productSaleList", products.get("productSaleList"));
			request.setAttribute("productExclusiveList", products.get("productExclusiveList"));
			request.setAttribute("eventList", events.get("eventList"));
			request.setAttribute("bannerList", bannerList);
			request.setAttribute("brandList", brandList);

			request.getRequestDispatcher("/consumer/main.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
