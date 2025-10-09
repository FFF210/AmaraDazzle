package controller.consumer;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;

@WebServlet("/store/mypage/orderList")
public class OrderList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public OrderList() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		try {
			// 1. 세션에서 회원 정보 가져오기
			HttpSession session = request.getSession();
			Long memberId = (Long) session.getAttribute("memberId");

			if (memberId == null) {
				response.sendRedirect(request.getContextPath() + "/store/login");
				return;
			}

			// 2. 요청 파라미터 처리
			String startY = request.getParameter("drfStartY");
			String startM = request.getParameter("drfStartM");
			String startD = request.getParameter("drfStartD");
			String endY = request.getParameter("drfEndY");
			String endM = request.getParameter("drfEndM");
			String endD = request.getParameter("drfEndD");

			String pageParam = request.getParameter("page");
			int page = 1;
			if (pageParam != null && !pageParam.trim().isEmpty()) {
				page = Integer.parseInt(pageParam);
			}

			int pageSize = 10;

			// Service 호출
			OrderService orderService = new OrderServiceImpl();
			Map<String, Object> result;

			// 조건부 조회
			if (startY != null && endY != null) {
				String startDateStr = startY + "-" + startM + "-" + startD + " 00:00:00";
				String endDateStr = endY + "-" + endM + "-" + endD + " 23:59:59";

				result = orderService.getOrderListByMember(memberId, null, startDateStr, endDateStr, page, pageSize);
			} else {
				result = orderService.getOrderListByMember(memberId, null, null, null, page, pageSize);
			}

			// ===== ✅ 교환/반품 가능 여부 계산 추가 =====
			List<Map<String, Object>> groupedOrders = (List<Map<String, Object>>) result.get("groupedOrders");
			
			if (groupedOrders != null) {
				for (Map<String, Object> order : groupedOrders) {
					List<Map<String, Object>> items = (List<Map<String, Object>>) order.get("items");
					
					if (items != null) {
						for (Map<String, Object> item : items) {
							// 각 아이템의 교환/반품 가능 여부 계산
							boolean canExchange = canApplyExchange(item);
							boolean canReturn = canApplyReturn(item);
							
							item.put("canExchange", canExchange);
							item.put("canReturn", canReturn);
						}
					}
				}
			}

			// 4. 주문 통계 정보도 가져오기
			Map<String, Object> summary = orderService.getOrderSummaryByMember(memberId);

			// 5. JSP로 데이터 전달
			request.setAttribute("orderResult", result);
			request.setAttribute("orderSummary", summary);
			
			// 날짜 파라미터도 전달 (검색 조건 유지용)
			request.setAttribute("startY", startY);
			request.setAttribute("startM", startM);
			request.setAttribute("startD", startD);
			request.setAttribute("endY", endY);
			request.setAttribute("endM", endM);
			request.setAttribute("endD", endD);

			// 6. JSP로 포워드
			request.getRequestDispatcher("/consumer/orderList.jsp").forward(request, response);

		} catch (NumberFormatException e) {
			e.printStackTrace();
			request.setAttribute("err", "잘못된 페이지 번호입니다.");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "주문 목록 조회 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

	// ===== ✅ 교환 가능 여부 체크 메서드 =====
	private boolean canApplyExchange(Map<String, Object> item) {
		String status = (String) item.get("status");

		// 1. DELIVERED 상태만 교환 가능
		if (!"DELIVERED".equals(status)) {
			return false;
		}

		// 2. updated_at 기준 7일 이내 체크
		Object updatedAtObj = item.get("updatedAt");
		if (updatedAtObj != null) {
			try {
				Timestamp updatedAt = null;

				if (updatedAtObj instanceof Timestamp) {
					updatedAt = (Timestamp) updatedAtObj;
				} else if (updatedAtObj instanceof java.util.Date) {
					updatedAt = new Timestamp(((java.util.Date) updatedAtObj).getTime());
				}

				if (updatedAt != null) {
					long diffMillis = System.currentTimeMillis() - updatedAt.getTime();
					long diffDays = diffMillis / (1000 * 60 * 60 * 24);

					if (diffDays > 7) {
						return false;
					}
				}
			} catch (Exception e) {
				return false;
			}
		}

		return true;
	}

	// ===== ✅ 반품 가능 여부 체크 메서드 =====
	private boolean canApplyReturn(Map<String, Object> item) {
		String status = (String) item.get("status");

		// 1. DELIVERED 상태만 반품 가능
		if (!"DELIVERED".equals(status)) {
			return false;
		}

		// 2. updated_at 기준 7일 이내 체크
		Object updatedAtObj = item.get("updatedAt");
		if (updatedAtObj != null) {
			try {
				Timestamp updatedAt = null;

				if (updatedAtObj instanceof Timestamp) {
					updatedAt = (Timestamp) updatedAtObj;
				} else if (updatedAtObj instanceof java.util.Date) {
					updatedAt = new Timestamp(((java.util.Date) updatedAtObj).getTime());
				}

				if (updatedAt != null) {
					long diffMillis = System.currentTimeMillis() - updatedAt.getTime();
					long diffDays = diffMillis / (1000 * 60 * 60 * 24);

					if (diffDays > 7) {
						return false;
					}
				}
			} catch (Exception e) {
				return false;
			}
		}

		return true;
	}
}