package controller.consumer;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import dto.Qna;
import service.consumer.QnaService;
import service.consumer.QnaServiceImpl;

/**
 * Servlet implementation class QnaCreate
 */
@WebServlet("/store/productDetail/qna")
public class QnaCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaCreate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("UTF-8");
	        
	        JsonObject json = new JsonObject();
	        
	        try {
	            // 로그인 체크
	            HttpSession session = request.getSession();
	            Long memberId = (Long) session.getAttribute("memberId");
	            
	            if (memberId == null) {
	                json.addProperty("success", false);
	                json.addProperty("message", "로그인이 필요합니다.");
	                sendJsonResponse(response, json);
	                return;
	            }
	            
	            // 파라미터 받기
	            String productIdStr = request.getParameter("productId");
	            String brandIdStr = request.getParameter("brandId");
	            String qnaContent = request.getParameter("qnaContent");
	            
	            if (productIdStr == null || brandIdStr == null || 
	                qnaContent == null || qnaContent.trim().isEmpty()) {
	                json.addProperty("success", false);
	                json.addProperty("message", "문의 내용을 입력해주세요.");
	                sendJsonResponse(response, json);
	                return;
	            }
	            
	            Long productId = Long.parseLong(productIdStr);
	            Long brandId = Long.parseLong(brandIdStr);
	            
	            // Qna 객체 생성
	            Qna qna = new Qna();
	            qna.setProductId(productId);
	            qna.setBrandId(brandId);
	            qna.setMemberId(memberId);
	            qna.setQuestion(qnaContent);
	            qna.setStatus("PENDING");
	            qna.setExposureStatus("PUBLISHED");
	            
	            // DB 저장
	            QnaService qnaService = new QnaServiceImpl();
	            qnaService.createQna(qna);  // throws Exception
	            
	            json.addProperty("success", true);
	            json.addProperty("message", "상품문의를 등록했습니다!");
	            
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	            json.addProperty("success", false);
	            json.addProperty("message", "잘못된 요청입니다.");
	        } catch (IllegalArgumentException e) {
	            e.printStackTrace();
	            json.addProperty("success", false);
	            json.addProperty("message", e.getMessage());
	        } catch (Exception e) {
	            e.printStackTrace();
	            json.addProperty("success", false);
	            json.addProperty("message", "오류가 발생했습니다.");
	        }
	        
	        sendJsonResponse(response, json);
	    }
	    
	    private void sendJsonResponse(HttpServletResponse response, JsonObject json) throws IOException {
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        
	        PrintWriter out = response.getWriter();
	        out.print(json.toString());
	        out.flush();
	    }
	}

