package controller.consumer;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import service.consumer.CartItemService;
import service.consumer.CartItemServiceImpl;

/**
 * Servlet implementation class AddToCart
 */
@WebServlet("/store/addToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddToCart() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");

		JSONObject jsonResponse = new JSONObject();

		try {
			// 로그인 확인
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("memberId") == null) {
				jsonResponse.put("success", false);
				jsonResponse.put("message", "로그인이 필요합니다.");
				jsonResponse.put("needLogin", true);

				PrintWriter out = response.getWriter();
				out.print(jsonResponse.toJSONString());
				out.flush();
				return;
			}

			Long memberId = (Long) session.getAttribute("memberId");
			
			// ✅ 디버깅 로그 추가
	        String brandIdStr = request.getParameter("brandId");
	        String productIdStr = request.getParameter("productId");
	        String optionIdStr = request.getParameter("optionId");
	        String quantityStr = request.getParameter("quantity");
	        
	        System.out.println("=== AddToCart 디버깅 ===");
	        System.out.println("brandId: " + brandIdStr);
	        System.out.println("productId: " + productIdStr);
	        System.out.println("optionId: " + optionIdStr);
	        System.out.println("quantity: " + quantityStr);
	        System.out.println("========================");
	        
			// 필수 파라미터 검증
			if (productIdStr == null || productIdStr.trim().isEmpty()) {
				throw new Exception("상품 정보가 올바르지 않습니다.");
			}
			if (quantityStr == null || quantityStr.trim().isEmpty()) {
				throw new Exception("수량을 입력해주세요.");
			}

			// 파라미터 변환
			Long brandId = (brandIdStr != null && !brandIdStr.trim().isEmpty()) ? Long.parseLong(brandIdStr) : null;
			Long productId = Long.parseLong(productIdStr);
			Long optionId = (optionIdStr != null && !optionIdStr.trim().isEmpty()) ? Long.parseLong(optionIdStr) : null;
			int quantity = Integer.parseInt(quantityStr);

			// 장바구니에 추가
			CartItemService service = new CartItemServiceImpl();
			service.addToCart(memberId, brandId, productId, optionId, quantity);

			// 성공 응답
			jsonResponse.put("success", true);
			jsonResponse.put("message", "장바구니에 추가되었습니다.");

		} catch (NumberFormatException e) {
			jsonResponse.put("success", false);
			jsonResponse.put("message", "잘못된 입력 형식입니다.");
		} catch (Exception e) {
			e.printStackTrace();
			jsonResponse.put("success", false);
			jsonResponse.put("message", e.getMessage());
		}

		PrintWriter out = response.getWriter();
		out.print(jsonResponse.toJSONString()); // toJSONString() 사용
		out.flush();
	}
}
