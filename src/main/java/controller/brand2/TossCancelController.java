package controller.brand2;

import java.io.IOException;
import java.io.OutputStream;
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

import dao.brand2.AdminPaymentDAO;
import dao.brand2.AdminPaymentDAOImpl;
import dto.AdminPayment;
import service.brand2.AdbannerService;
import service.brand2.AdbannerServiceImpl;

/**
 * Servlet implementation class TossCancelController
 */
@WebServlet("/tossCancel")
public class TossCancelController extends HttpServlet {
    private final AdminPaymentDAO adminPaymentDAO = new AdminPaymentDAOImpl();
    private final AdbannerService adbannerService = new AdbannerServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Long bannerId = Long.parseLong(request.getParameter("bannerId"));

        try {
            // 1. 결제 내역 조회
            AdminPayment payment = adminPaymentDAO.selectPaymentByBannerId(bannerId);
            if (payment == null) {
                throw new IllegalStateException("결제 내역이 없습니다.");
            }

            String paymentKey = payment.getPaymentKey();
            int amount = payment.getAmount();

            // 2. Toss API 취소 호출
            String secretKey = "test_sk_QbgMGZzorz5m714xdBN7Vl5E1em4"; // TODO: 실제 키로 교체
            String encodedAuth = Base64.getEncoder()
                    .encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

            URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Basic " + encodedAuth);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            JSONObject body = new JSONObject();
            body.put("cancelReason", "배너 광고 취소");
            body.put("cancelAmount", amount);

            OutputStream os = conn.getOutputStream();
            os.write(body.toString().getBytes("UTF-8"));
            os.flush();

            int code = conn.getResponseCode();
            System.out.println(">>> Toss Cancel API Response Code: " + code);

            if (code == 200) {
                // 3. DB 상태 업데이트
                adbannerService.cancelBanner(bannerId);

                response.sendRedirect(request.getContextPath() + "/brand2/adbannerList");
            } else {
                throw new RuntimeException("토스 결제 취소 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}