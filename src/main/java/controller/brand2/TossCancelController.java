package controller.brand2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TossCancelController
 */
@WebServlet("/brand2/tossCancelController")
public class TossCancelController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String paymentKey = request.getParameter("paymentKey"); // 결제건의 paymentKey
        String cancelReason = request.getParameter("reason");   // 취소 사유 (예: "광고 취소 요청")

        // 토스 Secret Key
        String secretKey = "test_sk_XXXX"; 
        String encodedAuth = Base64.getEncoder()
                .encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

        // API 요청
        URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Authorization", "Basic " + encodedAuth);
        conn.setRequestProperty("Content-Type", "application/json");

        // body (취소 사유)
        String body = "{ \"cancelReason\": \"" + cancelReason + "\" }";
        conn.getOutputStream().write(body.getBytes(StandardCharsets.UTF_8));

        int code = conn.getResponseCode();
        InputStream respStream = (code == 200 ? conn.getInputStream() : conn.getErrorStream());

        String result = new BufferedReader(new InputStreamReader(respStream))
                            .lines().reduce("", (acc, line) -> acc + line);

        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().print(result);

        // ✅ 여기서 DB 상태 반영
        if (code == 200) {
            // admin_payment 테이블 상태 → "CANCELED"
            // banner.status → "CANCELED"
            // update 쿼리 실행
        }
    }
}