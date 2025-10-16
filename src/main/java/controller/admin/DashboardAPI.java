package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.admin.DashboardService;
import service.admin.DashboardServiceImpl;

@WebServlet("/admin/dashboard")
public class DashboardAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private final DashboardService dash_svc = new DashboardServiceImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=UTF-8");
		
		PrintWriter pw = response.getWriter();
		
		try {
			 
			Map<String, Object> orderCnt = dash_svc.orderCntByPeriod();	//기간별 총 주문건수
			Map<String, Object> memberCnt = dash_svc.memberCntByPeriod();//기간별 가입자수
			List<Map<String, Object>> bestProductTop5 = dash_svc.bestSellerTop5();	//이번달 베스트셀러 top5(판매량기준)
			List<Map<String, Object>> bestBrandTop5 = dash_svc.bestBrandTop5();	//이번달 베스트브랜드 TOP5 (매출기준)
			List<Map<String, Object>> categoryRatio = dash_svc.selectCategoryRatio(); //판매상품 카테고리별 비율	
			List<Map<String, Object>> skinRatio = dash_svc.selectSkinRatio(); // 고객 피부타입별 비율	
			
			Map<String, Object> dataMap = new HashMap<>();
			dataMap.put("orderStats", orderCnt);
			dataMap.put("memberStats", memberCnt);
			dataMap.put("productStats", bestProductTop5);
			dataMap.put("brandStats", bestBrandTop5); 
			dataMap.put("categoryRatio", categoryRatio);
			dataMap.put("skinRatio", skinRatio);
			 
			Gson gson = new Gson();
			String data = gson.toJson(dataMap);
			
			pw.write(data.toString());
			pw.flush();
			pw.close();
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}


}
