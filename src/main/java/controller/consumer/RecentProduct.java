package controller.consumer;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import dto.consumer.ModalProduct;
import service.consumer.ProductService;
import service.consumer.ProductServiceImpl;

/**
 * Servlet implementation class RecentProduct
 */
@WebServlet("/api/recentProducts")
public class RecentProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ProductService service = new ProductServiceImpl();

	public RecentProduct() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		HttpSession session = request.getSession(false);
		Long memberId = null;
		if (session != null && session.getAttribute("memberId") != null) {
			memberId = (Long) session.getAttribute("memberId");
		}

		String idsParam = request.getParameter("productIds");
		if (idsParam == null || idsParam.isEmpty()) {
			response.getWriter().write("[]");
			return;
		}

		// id 목록 파싱
		List<Long> productIds = Arrays.stream(idsParam.split(",")).map(Long::parseLong).collect(Collectors.toList());

		try {
			// 서비스 호출
			List<ModalProduct> products = service.getModalProducts(productIds, memberId);

			System.out.println("idsParam = " + idsParam);
			System.out.println("productIds = " + productIds);
			System.out.println("memberId = " + memberId);
			System.out.println("products = " + products);

			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			response.getWriter().write(gson.toJson(products));

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
