package dao.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.OrderItem;
import dto.Orders;
import util.MybatisSqlSessionFactory;

public class OrderDAOImpl implements OrderDAO {

	// 주문용 상품 정보 조회 (상품상세페이지에서 바로 주문할 때)
	// 상품 기본 정보 + 브랜드명 + 할인 정보 조회
	@Override
	public Map<String, Object> getProductForDirectOrder(Long productId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			// OrderMapper.xml의 getProductForDirectOrder 쿼리 실행
			return sqlSession.selectOne("mapper.orders.getProductForDirectOrder", productId);
		}
	}

	// 상품 옵션 정보 조회 - 옵션이 있는 상품의 특정 옵션 정보
	@Override
	public Map<String, Object> getProductOptionInfo(Long optionId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			// OrderMapper.xml의 getProductOptionInfo 쿼리 실행
			return sqlSession.selectOne("mapper.orders.getProductOptionInfo", optionId);
		}
	}

	// 주문 코드 자동 생성 - 오늘 날짜 + 일련번호 형태 (예: 20250915-000001)
	@Override
	public String generateOrderCode() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			// OrderMapper.xml의 generateOrderCode 쿼리 실행
			return sqlSession.selectOne("mapper.orders.generateOrderCode");
		}
	}

	// 새로운 주문 생성 - orders 테이블에 주문 기본 정보 저장
	@Override
	public void createOrder(Orders order) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			// OrderMapper.xml의 createOrder 쿼리 실행
			sqlSession.insert("mapper.orders.createOrder", order);
			sqlSession.commit();
		}
	}

	// 주문 상품 추가 - order_item 테이블에 개별 상품 정보 저장
	@Override
	public void createOrderItem(OrderItem orderItem) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			// OrderMapper.xml의 createOrderItem 쿼리 실행
			sqlSession.insert("mapper.orders.createOrderItem", orderItem);
			sqlSession.commit();
		}
	}

	// 주문 정보 조회 - 주문 완료 후 확인용===========현재는 안 씀!
	@Override
	public Orders getOrderById(Long ordersId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			// OrderMapper.xml의 getOrderById 쿼리 실행
			return sqlSession.selectOne("mapper.orders.getOrderById", ordersId);
		}
	}

	// 주문 상품 목록 조회 (기본 정보만) - 특정 주문에 포함된 모든 상품들
	@Override
	public List<OrderItem> getOrderItemsByOrderId(Long orderId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			// OrderMapper.xml의 getOrderItemsByOrderId 쿼리 실행
			return sqlSession.selectList("mapper.orders.getOrderItemsByOrderId", orderId);
		}
	}

	// 주문 상품 상세 정보 조회 (상품명, 브랜드명, 옵션명 포함) -주문 완료 페이지에서 보여줄 상세 정보
	@Override
	public List<Map<String, Object>> getOrderItemsWithProductInfo(Long orderId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			// OrderMapper.xml의 getOrderItemsWithProductInfo 쿼리 실행
			return sqlSession.selectList("mapper.orders.getOrderItemsWithProductInfo", orderId);
		}
	}

	// ===============orderList 용도=================

	@Override
	public List<Map<String, Object>> getOrderItemsByMemberWithPeriod(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orders.getOrderItemsByMemberWithPeriod", params);
		}
	}

	@Override
	public int getOrderItemCountByMember(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.getOrderItemCountByMember", params);
		}
	}

	// orderStatusCard용도
	@Override
	public Map<String, Object> getOrderStatusCountByMember(Long memberId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.getOrderStatusCountByMember", memberId);
		}
	}

	// 주문 상품 상태 업데이트
	@Override
	public void updateOrderItemStatus(Long orderItemId, String status) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> params = new HashMap<>();
			params.put("orderItemId", orderItemId);
			params.put("status", status);

			int result = session.update("mapper.orders.updateOrderItemStatus", params);

			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
				throw new Exception("주문 상품 상태 업데이트 실패");
			}
		}
	}

	// 주문 상태 조회
	@Override
	public String getOrderItemStatus(Long orderItemId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.orders.getOrderItemStatus", orderItemId);
		}
	}

	// 주문 상태 취소로 바꾸기
	@Override
	public int cancelOrderItem(Long orderItemId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = session.update("mapper.orders.cancelOrderItem", orderItemId);
			session.commit();
			return result;
		}
	}

	// 재고 복구 =========================
	// 옵션 있을 시
	@Override
	public void restoreOptionStock(Long orderItemId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.update("mapper.orders.restoreOptionStock", orderItemId);
			session.commit();
		}
	}

	// 옵션 없을 시
	@Override
	public void restoreProductStock(Long orderItemId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.update("mapper.orders.restoreProductStock", orderItemId);
			session.commit();
		}
	}

	// ================ 취소/교환/반품 통합 목록 조회 ===================
	@Override
	public List<Map<String, Object>> selectCancelExchangeReturnList(Map<String, Object> params) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.orders.selectCancelExchangeReturnList", params);
		}
	}

	// 페이징용 개수 조회
	@Override
	public int countCancelExchangeReturnList(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.countCancelExchangeReturnList", params);
		}
	}

	// 교환/반품 신청용
	@Override
	public Map<String, Object> getOrderItemForApply(Long orderItemId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.orders.getOrderItemForApply", orderItemId);
		}
	}

}
