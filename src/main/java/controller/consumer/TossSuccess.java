package controller.consumer;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
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

import dto.Payment;
import service.consumer.MemberCouponService;
import service.consumer.MemberCouponServiceImpl;
import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;
import service.consumer.PaymentService;
import service.consumer.PaymentServiceImpl;

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

		System.out.println("========================================");
		System.out.println("=== 토스 결제 콜백 시작 ===");
		System.out.println("paymentKey: " + paymentKey);
		System.out.println("amount: " + amount);
		System.out.println("orderId: " + orderId);
		System.out.println("========================================");

		try {
			// 1. 세션 확인
			HttpSession session = request.getSession();

			System.out.println(">>> 1단계: 세션에서 주문 데이터 가져오기");
			@SuppressWarnings("unchecked")
			Map<String, Object> orderData = (Map<String, Object>) session.getAttribute("pendingOrderData");
			String temporaryOrderId = (String) session.getAttribute("temporaryOrderId");

			System.out.println("orderData null? " + (orderData == null));
			System.out.println("temporaryOrderId: " + temporaryOrderId);

			if (orderData == null) {
				System.out.println("❌ 에러: 세션에 주문 정보가 없습니다!");
				String errorMsg = URLEncoder.encode("세션만료-다시주문해주세요", "UTF-8");
				response.sendRedirect(request.getContextPath() + "/consumer/error.jsp?message=" + errorMsg);
				return;
			}

			if (!orderId.equals(temporaryOrderId)) {
				System.out.println("❌ 에러: 주문 번호 불일치!");
				System.out.println("orderId: " + orderId);
				System.out.println("temporaryOrderId: " + temporaryOrderId);
				String errorMsg = URLEncoder.encode("주문번호불일치", "UTF-8");
				response.sendRedirect(request.getContextPath() + "/consumer/error.jsp?message=" + errorMsg);
				return;
			}

			// 2. 토스페이먼츠 API 호출 준비
			System.out.println(">>> 2단계: 토스 결제 승인 API 호출");
			JSONObject obj = new JSONObject();
			obj.put("orderId", orderId);
			obj.put("amount", amount);
			obj.put("paymentKey", paymentKey);

			String widgetSecretKey = "test_sk_6BYq7GWPVveXkXR7RvqG3NE5vbo1";
			Base64.Encoder encoder = Base64.getEncoder();
			byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
			String authorizations = "Basic " + new String(encodedBytes);

			// 3. Toss 결제 승인 API 호출
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

			System.out.println("토스 응답 코드: " + code);

			InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

			JSONParser parser = new JSONParser();
			Reader apiReader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
			JSONObject result = (JSONObject) parser.parse(apiReader);
			responseStream.close();

			System.out.println("토스 응답: " + result.toJSONString());

			// 4. 성공/실패 처리
			if (isSuccess) {
				System.out.println("✅ 토스 결제 승인 성공!");

				// 결제 정보 추가
				orderData.put("paymentKey", paymentKey);
				orderData.put("paymentMethod", "CARD");

				// 5. 주문 생성
				System.out.println(">>> 3단계: DB에 주문 저장");
				OrderService orderService = new OrderServiceImpl();
				Long savedOrderId = orderService.createOrder(orderData);

				System.out.println("✅ 주문 저장 완료: orderId=" + savedOrderId);
				
				// ✅ 수정: 결제 정보 저장
				System.out.println(">>> 3-0단계: 결제 정보 저장");
				try {
				    Payment payment = new Payment();
				    payment.setOrderId(savedOrderId);
				    payment.setProvider("toss");
				    
				    // 토스 응답에서 결제 방법 추출
				    String paymentMethod = "tosspay"; // 기본값
				    if (result.containsKey("method")) {
				        paymentMethod = (String) result.get("method");
				    }
				    payment.setMethod(paymentMethod);
				    
				    payment.setAmount(new BigDecimal(amount));
				    payment.setStatus("AUTHORIZED");
				    payment.setPaymentKey(paymentKey);
				    
				    // Service로 payment 저장
				    PaymentService paymentService = new PaymentServiceImpl();
				    paymentService.savePayment(payment);
				    
				    System.out.println("✅ 결제 정보 저장 완료: paymentKey=" + paymentKey);
				} catch (Exception e) {
				    System.err.println("⚠️ 결제 정보 저장 실패: " + e.getMessage());
				    e.printStackTrace();
				    // 결제 정보 저장 실패해도 주문은 완료된 상태이므로 계속 진행
				}
				
				// ===== 쿠폰 사용 처리 추가 =====
				System.out.println(">>> 3-1단계: 쿠폰 사용 처리");
				Long memberCouponId = (Long) orderData.get("usingCoupon");
				Long memberId = (Long) orderData.get("memberId");

				if (memberCouponId != null) {
				    try {
				        MemberCouponService couponService = new MemberCouponServiceImpl();
				        boolean couponUsed = couponService.applyCoupon(memberId, memberCouponId, savedOrderId);
				        
				        if (couponUsed) {
				            System.out.println("✅ 쿠폰 사용 처리 완료: " + memberCouponId);
				        } else {
				            System.err.println("⚠️ 쿠폰 사용 처리 실패 (이미 사용됨): " + memberCouponId);
				        }
				    } catch (Exception e) {
				        // 쿠폰 처리 실패해도 주문은 계속 진행
				        System.err.println("⚠️ 쿠폰 사용 처리 중 오류: " + e.getMessage());
				        e.printStackTrace();
				    }
				}

				// 6. 재고 감소
				System.out.println(">>> 4단계: 재고 감소");
				@SuppressWarnings("unchecked")
				List<Map<String, Object>> items = (List<Map<String, Object>>) orderData.get("items");
				if (items != null && !items.isEmpty()) {
					orderService.decreaseStock(items);
					System.out.println("✅ 재고 감소 완료: " + items.size() + "개 아이템");
				}

				// 7. 세션 정리
				session.removeAttribute("pendingOrderData");
				session.removeAttribute("temporaryOrderId");
				System.out.println("✅ 세션 정리 완료");

				// 8. 주문 완료 페이지로 리다이렉트
				System.out.println(">>> 5단계: 주문 완료 페이지로 이동");
				String redirectUrl = request.getContextPath() + "/store/orderComplete?orderId=" + savedOrderId;
				System.out.println("리다이렉트 URL: " + redirectUrl);
				response.sendRedirect(redirectUrl);

			} else {
				// 결제 실패
				System.out.println("❌ 토스 결제 승인 실패!");
				String errorMessage = (String) result.get("message");
				System.out.println("에러 메시지: " + errorMessage);

				String encodedMsg = URLEncoder.encode("결제승인실패:" + errorMessage, "UTF-8");
				response.sendRedirect(request.getContextPath() + "/consumer/error.jsp?message=" + encodedMsg);
			}

		} catch (Exception e) {
			System.out.println("========================================");
			System.out.println("❌❌❌ 치명적 에러 발생! ❌❌❌");
			System.out.println("========================================");
			e.printStackTrace();

			// ✅ 응답이 아직 커밋되지 않았을 때만 리다이렉트
			if (!response.isCommitted()) {
				try {
					String encodedMsg = URLEncoder.encode("결제처리오류", "UTF-8");
					response.sendRedirect(request.getContextPath() + "/consumer/error.jsp?message=" + encodedMsg);
				} catch (Exception ex) {
					response.sendRedirect(request.getContextPath() + "/consumer/error.jsp?message=PaymentError");
				}
			}
		} 
	}  
} 