package controller.consumer;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;

@WebServlet("/store/tossSuccess")
public class TossSuccess extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public TossSuccess() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String paymentKey = request.getParameter("paymentKey");
		String amount = request.getParameter("amount");
		String orderId = request.getParameter("orderId");

		System.out.println("=== 토스 결제 콜백 ===");
		System.out.println("paymentKey: " + paymentKey);
		System.out.println("amount: " + amount);
		System.out.println("orderId: " + orderId);

		try {
			// 1. 토스페이먼츠 API 호출 준비
			JSONObject obj = new JSONObject();
			obj.put("orderId", orderId);
			obj.put("amount", amount);
			obj.put("paymentKey", paymentKey);

			String widgetSecretKey = "test_sk_Poxy1XQL8RYPqzXP5Dk6rQVxB9lG";
			Base64.Encoder encoder = Base64.getEncoder();
			byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
			String authorizations = "Basic " + new String(encodedBytes);

			// 2. Toss 결제 승인 API 호출
			URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestProperty("Authorization", authorizations);
			connection.setRequestProperty("Content-Type", "application/json");
			connection.setRequestMethod("POST");
			connection.setDoOutput(true);

			OutputStream outputStream = connection.getOutputStream();
			outputStream.write(obj.toString().getBytes("UTF-8"));
			outputStream.flush();

			int code = connection.getResponseCode();
			boolean isSuccess = code == 200;

			InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

			JSONParser parser = new JSONParser();
			Reader apiReader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
			JSONObject result = (JSONObject) parser.parse(apiReader);
			responseStream.close();

			System.out.println("토스 응답 코드: " + code);
			System.out.println("토스 응답: " + result.toJSONString());

			// 3. 성공/실패 처리
			if (isSuccess) {
				// ✅ 결제 성공!
				HttpSession session = request.getSession();

				// 세션에서 주문 데이터 가져오기
				@SuppressWarnings("unchecked")
				Map<String, Object> orderData = (Map<String, Object>) session.getAttribute("pendingOrderData");
				String temporaryOrderId = (String) session.getAttribute("temporaryOrderId");

				if (orderData == null) {
					throw new Exception("세션에 주문 정보가 없습니다.");
				}

				if (!orderId.equals(temporaryOrderId)) {
					throw new Exception("주문 번호가 일치하지 않습니다.");
				}

				// 결제 정보 추가
				orderData.put("paymentKey", paymentKey);
				orderData.put("paymentMethod", "CARD");

				// 주문 생성
				OrderService orderService = new OrderServiceImpl();
				Long savedOrderId = orderService.createOrder(orderData);

				System.out.println("주문 저장 완료: " + savedOrderId);

				// 재고 감소
				@SuppressWarnings("unchecked")
				List<Map<String, Object>> items = (List<Map<String, Object>>) orderData.get("items");
				if (items != null && !items.isEmpty()) {
					orderService.decreaseStock(items);
					System.out.println("재고 감소 완료");
				}

				// 세션 정리
				session.removeAttribute("pendingOrderData");
				session.removeAttribute("temporaryOrderId");

				// 주문 완료 페이지로 리다이렉트
				response.sendRedirect(request.getContextPath() + "/store/orderComplete?orderId=" + savedOrderId);

			} else {
				// ❌ 결제 실패!
				System.out.println("결제 승인 실패!");
				String errorMessage = (String) result.get("message");
				response.sendRedirect(request.getContextPath() + 
					"/consumer/error.jsp?message=결제승인실패:" + errorMessage);
			}

		} catch (Exception e) {
			System.out.println("=== 에러 발생 ===");
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + 
				"/consumer/error.jsp?message=" + e.getMessage());
		}
	}
}