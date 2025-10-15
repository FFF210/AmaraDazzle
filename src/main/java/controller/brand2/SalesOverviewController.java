package controller.brand2;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dto.Brand;
import dto.Category;
import dto.brand2.SalesOverview;
import dto.brand2.SalesStatusRow;
import service.brand2.SalesOverviewService;
import service.brand2.SalesOverviewServiceImpl;

@WebServlet("/brand2/salesOverview")
public class SalesOverviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SalesOverviewController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);

		// 세션 없거나 브랜드 정보 없음 → 로그인 페이지로 리다이렉트
		if (session == null || session.getAttribute("brand") == null) {
			response.sendRedirect(request.getContextPath() + "/brand/login");
			return;
		}

		Brand brand = (Brand) session.getAttribute("brand");
		Long brandId = brand.getBrandId();
		
		SalesOverviewService service = new SalesOverviewServiceImpl();
		
		// 페이지네이션
				int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
				int limit = 10; // 한 페이지당 개수
				int offset = (page - 1) * limit;


		try {

			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			String categoryIds = request.getParameter("categories"); // "1,2,3" 형태


			Map<String, Object> params = new HashMap<>();
			params.put("brandId", brandId);
			params.put("startDate", startDate);
			params.put("endDate", endDate);
			
			// 페이징
			params.put("limit", limit);
			params.put("offset", offset);
			
			if (categoryIds != null && !categoryIds.isEmpty()) {
			    List<Long> categoryList = Arrays.stream(categoryIds.split(","))
			                                    .map(Long::parseLong)   // String → Long 변환
			                                    .collect(Collectors.toList());
			    params.put("categories", categoryList);
			} else {
			    params.put("categories", Collections.emptyList());
			}

			
			// ====== 서비스 호출 ======
			List<SalesOverview> overviewList  = service.getCategorySalesTrend(params);

			// 테이블 데이터용 (pivot 구조)
	        Map<String, Object> result = service.getSalesStatusRows(params);
			
			// 카테고리 depth=1 목록
			List<Category> categories = service.getLargeCategories();
			
			// ====== Chart.js 데이터용 JSON 변환 ======
			Map<String, Object> chartData = new HashMap<>();

			// x축 라벨 (날짜별)
			Set<String> labelSet = new TreeSet<>(); // 자동 정렬
			for (SalesOverview row : overviewList) {
				labelSet.add(row.getDate().toString());
			}
			List<String> labels = new ArrayList<>(labelSet);
			chartData.put("labels", labels);
			
			// 카테고리별 매출 데이터셋 구성
			Map<String, List<Long>> categoryDataMap = new LinkedHashMap<>();

			for (SalesOverview row : overviewList) {
				String dateStr = row.getDate().toString();
				String catName = row.getCategoryName();
				Long amount = row.getAmount() != null ? row.getAmount() : 0L;

				// 데이터셋 초기화
				categoryDataMap.putIfAbsent(catName, new ArrayList<>(Collections.nCopies(labels.size(), 0L)));

				// 현재 날짜 index 찾아서 값 세팅
				int idx = labels.indexOf(dateStr);
				if (idx >= 0) {
					categoryDataMap.get(catName).set(idx, amount);
				}
			}

			// Chart.js datasets
			List<Map<String, Object>> datasets = new ArrayList<>();
			for (Map.Entry<String, List<Long>> entry : categoryDataMap.entrySet()) {
				Map<String, Object> dataset = new HashMap<>();
				dataset.put("label", entry.getKey());
				dataset.put("data", entry.getValue());
				dataset.put("fill", false);
				datasets.add(dataset);
			}
			chartData.put("datasets", datasets);

			// JSON 변환
			Gson gson = new Gson();
			String salesChartJson = gson.toJson(chartData);

			// ====== JSP에 전달 ======
			request.setAttribute("salesList", result.get("salesList"));
			request.setAttribute("totalCount", result.get("totalCount"));
			request.setAttribute("totalPages", result.get("totalPages"));
			request.setAttribute("currentPage", result.get("page"));
			
			request.setAttribute("salesChartJson", salesChartJson);
			request.setAttribute("categories", categories);

			request.getRequestDispatcher("/brand2/salesOverview.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
