package controller.brand2;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

@WebServlet("/tossSuccess")
public class TossController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String paymentKey = request.getParameter("paymentKey");
        String amount = request.getParameter("amount");
        String orderId = request.getParameter("orderId");
        
        response.setContentType("application/json; charset=UTF-8");

        PrintWriter out = response.getWriter();

        try {
            // 1. 토스페이먼츠 API 호출 준비
            JSONObject obj = new JSONObject();
            obj.put("orderId", orderId);
            obj.put("amount", amount);
            obj.put("paymentKey", paymentKey);

            String widgetSecretKey = "test_sk_QbgMGZzorz5m714xdBN7Vl5E1em4"; // TODO: 실제 시크릿 키
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

            InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

            JSONParser parser = new JSONParser();
            Reader apiReader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
            JSONObject result = (JSONObject) parser.parse(apiReader);
            responseStream.close();

            System.out.println(result.toJSONString());
            // 4. 성공 시 DB 저장 (MyBatis 활용)
            if (isSuccess) {
            	String orderIdConfirm = (String)result.get("orderId");
            	String paymentKeyConfirm = (String)result.get("paymentKey");
            	String orderNameConfirm = (String)result.get("orderName");
            	String methodConfirm = (String)result.get("method");
            	String approvedAtConfirm = (String)result.get("approvedAt");
            	Long totalAmount = (Long)result.get("totalAmount");
            	String receiptUrl = (String)((JSONObject)result.get("receipt")).get("url");

            	System.out.println(orderIdConfirm);
            	System.out.println(paymentKeyConfirm);
            	System.out.println(orderNameConfirm);
            	System.out.println(methodConfirm);
            	System.out.println(approvedAtConfirm);
            	System.out.println(totalAmount);
            	System.out.println(receiptUrl);

            	// 예시: 결제 정보 AdminPayment 테이블에 insert
                // SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
                // AdminPaymentDAO dao = sqlSession.getMapper(AdminPaymentDAO.class);
                // dao.insertAdminPayment(new AdminPayment(orderId, amount, paymentKey, brandId));
                // sqlSession.commit();
                // sqlSession.close();
            }

            // 5. JSON 응답 반환
            response.setStatus(code);
            out.print(result.toJSONString());

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.sendRedirect("http://localhost:8080/tossFail");

//            JSONObject err = new JSONObject();
//            err.put("message", "결제 처리 중 오류가 발생했습니다.");
//            out.print(err.toJSONString());
        } finally {
            out.flush();
            out.close();
        }
    }
}
