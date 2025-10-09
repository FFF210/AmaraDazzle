package util;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class BreadcrumbFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
	        throws IOException, ServletException {

	    HttpServletRequest request = (HttpServletRequest) req;
	    String uri = request.getRequestURI();
	    String breadcrumb = "";

	    System.out.println("uri : " + uri);
	    
	    Map<String, String> map = new LinkedHashMap<>();
	    map.put("/admin/user", "회원:/admin/userSellerList,");
	    map.put("/admin/notice", "게시판,공지사항:/admin/noticeSellerList,");
	    map.put("/admin/promo", "프로모션,");
	    map.put("/admin/coupon", "프로모션,쿠폰:/admin/couponPublList,");
	    map.put("/admin/point", "프로모션,포인트:/admin/pointList,");


	    for (Map.Entry<String, String> entry : map.entrySet()) {
	        if (uri.contains(entry.getKey())) {
	            breadcrumb = entry.getValue();
	            
	            if (uri.contains("Seller")) {
	            	if(uri.contains("user")) breadcrumb += "판매자:/admin/userSellerList,";
	            	else if(uri.contains("notice")) breadcrumb += "판매자:/admin/noticeSellerList,";
	            }
	            else if (uri.contains("Consumer")) breadcrumb += "일반회원:/admin/userConsumerList,";
	            else if (uri.contains("Platform")) breadcrumb += "플랫폼,";
	            else if (uri.contains("Event")) breadcrumb += "이벤트:/admin/promoEventList,";
	            else if (uri.contains("Banner")) breadcrumb += "배너:/admin/promoBannerList,";
	            else if (uri.contains("Publ")) breadcrumb += "발행 쿠폰:/admin/couponPublList,";
	            else if (uri.contains("Indi")) breadcrumb += "개별 지급:/admin/couponIndiList,";

	            if (uri.contains("List")) breadcrumb += "리스트 조회:";
	            else if (uri.contains("Detail")) breadcrumb += "상세보기:";
	            else if (uri.contains("Write")) breadcrumb += "작성:";
	            else if (uri.contains("Edit")) breadcrumb += "수정:";

	            break;
	        }
	    }
	    System.out.println("breadcrumbItems : " + breadcrumb );
	    
	    // 빈 문자열이면 아예 attribute를 남기지 않음 (JSP에서 not empty 체크용)
        if (breadcrumb != null && !breadcrumb.trim().isEmpty()) {
            request.setAttribute("breadcrumbItems", breadcrumb);
        }

	    chain.doFilter(request, res);
	}

}
