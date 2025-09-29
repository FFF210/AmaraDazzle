package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.consumer.CartItemService;
import service.consumer.CartItemServiceImpl;

/**
 * Servlet implementation class AddToCart
 */
@WebServlet("/addToCart")
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 로그인 확인
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("memberId") == null) {
			// 로그인 후 돌아올 URL 저장
			session = request.getSession(true);
			session.setAttribute("redirectURL", request.getHeader("Referer"));
			response.sendRedirect(request.getContextPath() + "/consumer/login");
			return;
		}

		Long memberId = (Long) session.getAttribute("memberId");

		// 파라미터 받기
		String brandIdStr = request.getParameter("brandId");
		String productIdStr = request.getParameter("productId");
		String optionIdStr = request.getParameter("optionId");
		String quantityStr = request.getParameter("quantity");

		try {
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

			// 성공 시 상품 상세 페이지로 리다이렉트 (성공 메시지와 함께)
			response.sendRedirect(request.getContextPath() + "/productDetail?id=" + productId + "&added=true");

		} catch (NumberFormatException e) {
			// 숫자 변환 오류
			String referer = request.getHeader("Referer");
			if (referer != null) {
				response.sendRedirect(referer + "?error=잘못된 입력 형식입니다.");
			} else {
				response.sendRedirect(request.getContextPath() + "/");
			}
		} catch (Exception e) {
			e.printStackTrace();

			// 에러 시 이전 페이지로 되돌아가기 (에러 메시지와 함께)
			String referer = request.getHeader("Referer");
			if (referer != null) {
				String errorParam = referer.contains("?") ? "&error=" : "?error=";
				response.sendRedirect(referer + errorParam + e.getMessage());
			} else {
				request.setAttribute("err", "장바구니 추가 오류: " + e.getMessage());
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
			}
		}
	}

}
