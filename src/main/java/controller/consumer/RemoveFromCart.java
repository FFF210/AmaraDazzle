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

@WebServlet("/store/cart/remove")
public class RemoveFromCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
                PrintWriter out = response.getWriter();
                out.print(jsonResponse.toJSONString());
                out.flush();
                return;
            }
            
            Long memberId = (Long) session.getAttribute("memberId");
            String cartItemIdStr = request.getParameter("cartItemId");
            
            if (cartItemIdStr == null || cartItemIdStr.trim().isEmpty()) {
                throw new Exception("삭제할 상품을 선택해주세요.");
            }
            
            Long cartItemId = Long.parseLong(cartItemIdStr);
            
            // 장바구니에서 삭제
            CartItemService service = new CartItemServiceImpl();
            service.removeFromCart(cartItemId, memberId);
            
            jsonResponse.put("success", true);
            jsonResponse.put("message", "삭제되었습니다.");
            
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "잘못된 입력 형식입니다.");
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", e.getMessage());
        }
        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toJSONString());
        out.flush();
    }
}