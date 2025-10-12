package controller.consumer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/store/deliveryTracking")
public class DeliveryTracking extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeliveryTracking() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        // 파라미터 받기
        String trackingNo = request.getParameter("trackingNo");
        String carrierName = request.getParameter("carrierName");

        // JSP로 전달
        request.setAttribute("trackingNo", trackingNo);
        request.setAttribute("carrierName", carrierName);

        // JSP로 포워드
        request.getRequestDispatcher("/consumer/deliveryTracking.jsp").forward(request, response);
    }
}